import 'dart:async';
import 'dart:io';

import 'package:marisma/src/orm/surreal_orm.dart';
import 'package:surrealdb/surrealdb.dart';

import '../http_wrapper/http_wrapper.dart';
import '../models/address.dart';
import '../tools/logger.dart';

Map<String, String> env = Platform.environment;
final _logger = LoggerWrapper().logger;
final SurrealORM _surrealORM = SurrealORM();
late Timer _updateTimer;

Future<void> addressUpdateIsolate() async {
  LoggerWrapper().init();
  HttpWrapper().init();

  _logger.i('addressUpdateIsolate isolate started.');

  //intercept SIGTERM
  ProcessSignal.sigterm.watch().listen(
    (_) async {
      LoggerWrapper().logger.i('addressUpdateIsolate SIGTERM received');
      _updateTimer.cancel();
    },
  );

  await _surrealORM.init(true);

  _logger.i('addressUpdateIsolate SurrealORM initialized.');

  while (await _surrealORM.checkInitialSyncCompleted() == false) {
    //wait for sync
    _logger.d(
      'addressUpdateIsolate waiting for sync to be done. Ignoring updates...',
    );
    await Future.delayed(Duration(seconds: 10));
  }

  _logger.i('addressUpdateIsolate Sync complete, looking for updates...');

  //toggle utxo merge after sync
  await _surrealORM.computeMergeUtxos();

  //find all addresses that need updating on startup and update them
  await _checkForAddressesThatNeedUpdating();

  //start timer that will run every 1 minute to check for updates
  _updateTimer = Timer.periodic(Duration(minutes: 1), (Timer t) async {
    //check for addresses
    await _checkForAddressesThatNeedUpdating();
  });

  //continue with continous watch for updates
  final surrealStream = await _surrealORM.liveTableStream('address');

  _logger.i('addressUpdateIsolate continuous watch initialized');

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
  if (address.needsUpdate == false) {
    //return early to avoid endless update loop since we are watching the address table and surreal events are triggered on update
    _logger.d("addressUpdateIsolate ${address.address} does not need update");
    return;
  }

  //trigger update
  await _surrealORM.computeUpdateAddress(address.address);
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
