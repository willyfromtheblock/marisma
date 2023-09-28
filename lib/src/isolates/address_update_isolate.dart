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

Future<void> addressUpdateIsolate() async {
  LoggerWrapper().init();
  HttpWrapper().init();

  _logger.i('addressUpdateIsolate isolate started.');

  await SurrealORM().init(true);

  _logger.i('addressUpdateIsolate SurrealORM initialized.');

  while (await SurrealORM().getHeightInSurrealDB() < await heightInRest()) {
    //wait for sync
    _logger.d(
      'addressUpdateIsolate waiting for sync and utxo gargabe man to be done. Ignoring updates...',
    );
    await Future.delayed(Duration(seconds: 10));
  }

  _logger.i('addressUpdateIsolate Sync complete, looking for updates...');

  //look for updates
  final surrealStream = await SurrealORM().liveTableStream('address');

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
      await SurrealORM().getAddressUtxos(address: address.address);

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
      await SurrealORM().getAddressHistory(address: address.address);
  hashString += history.toString();

  address.status = sha256.convert(hashString.codeUnits).toString();

  //unflag need for update
  address.needsUpdate = false;

  //write
  await SurrealORM().updateAddress(address);
}
