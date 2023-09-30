import 'dart:async';
import 'dart:io';

import 'package:crypto/crypto.dart';
import 'package:marisma/src/orm/surreal_orm.dart';
import 'package:surrealdb/surrealdb.dart';

import '../http_wrapper/http_wrapper.dart';
import '../models/address.dart';
import '../tools/decimal_product.dart';
import '../tools/height_in_rest.dart';
import '../tools/logger.dart';

Map<String, String> env = Platform.environment;
final _logger = LoggerWrapper().logger;
final SurrealORM _surrealORM = SurrealORM();

Future<void> addressUpdateIsolate() async {
  LoggerWrapper().init();
  HttpWrapper().init();

  _logger.i('addressUpdateIsolate isolate started.');

  await _surrealORM.init(true);

  _logger.i('addressUpdateIsolate SurrealORM initialized.');

  while (await _surrealORM.getHeightInSurrealDB() < await heightInRest()) {
    //wait for sync
    _logger.d(
      'addressUpdateIsolate waiting for sync and utxo gargabe man to be done. Ignoring updates...',
    );
    await Future.delayed(Duration(seconds: 10));
  }

  _logger.i('addressUpdateIsolate Sync complete, looking for updates...');

  //find all addresses that need updating on startup and update them
  await _checkForAddressesThatNeedUpdating();

  //start timer that will run every 1 minute to check for updates
  Timer.periodic(Duration(minutes: 1), (Timer t) async {
    await _checkForAddressesThatNeedUpdating();
  });

  //continue with continous watch for updates
  final surrealStream = await _surrealORM.liveTableStream('address');

  _logger.i('addressUpdateIsolate initialized');

  await for (LiveQueryResponse event in surrealStream) {
    //extract address
    final resultMap = event.result as Map;

    bool containsAddress = resultMap.containsKey('address');
    if (containsAddress) {
      //update
      await _updateAddress(AddressModel.fromJson(resultMap));
    }
  }
}

Future<void> _updateAddress(AddressModel address) async {
  _logger.d("addressUpdateIsolate updating ${address.address}");

  //update balance
  double confirmedBalanceDouble = 0;
  double unconfirmedBalanceDouble = 0;

  final addressUtxos =
      await _surrealORM.getAddressUtxos(address: address.address);

  for (var utxo in addressUtxos) {
    if (utxo.block > 0) {
      confirmedBalanceDouble += utxo.value;
    } else {
      unconfirmedBalanceDouble += utxo.value;
    }
  }

  address.confirmedBalance =
      (confirmedBalanceDouble * getDecimalProduct()).round();
  address.unconfirmedBalance =
      (unconfirmedBalanceDouble * getDecimalProduct()).round();

  //update status
  String hashString =
      '$address$confirmedBalanceDouble$unconfirmedBalanceDouble';
  //append history to String
  final history =
      await _surrealORM.getAddressUtxoHistoryStrings(address: address.address);
  hashString += history.toString();

  address.status = sha256.convert(hashString.codeUnits).toString();

  //unflag need for update
  address.needsUpdate = false;

  //write
  await _surrealORM.updateAddress(address);
}

Future<void> _checkForAddressesThatNeedUpdating() async {
  while (await _surrealORM.getDBHasAddressesThatNeedUpdating() == true) {
    _logger.d('addressUpdateIsolate found addresses that need updating.');
    //limited to 1000 addresses per batch by ORM
    final addresses = await _surrealORM.getAddressesThatNeedUpdating();

    for (var address in addresses) {
      await _updateAddress(address);
    }
  }
}
