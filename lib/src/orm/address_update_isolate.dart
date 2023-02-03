import 'dart:io';

import 'package:crypto/crypto.dart';
import 'package:isar/isar.dart';

import '../http_wrapper/http_wrapper.dart';
import '../models/address.dart';
import '../models/block.dart';
import '../models/tx.dart';
import '../models/utxo.dart';
import '../tools/decimal_product.dart';
import '../tools/logger.dart';

Map<String, String> env = Platform.environment;
final logger = LoggerWrapper().logger;
late Isar _isar;

Future<void> addressUpdateIsolate() async {
  LoggerWrapper().init();
  HttpWrapper().init();

  logger.i('addressUpdateIsolate isolate started.');

  _isar = await Isar.open(
    [
      AddressModelSchema,
      BlockSchema,
      TxSchema,
      UtxoSchema,
    ],
    directory: env["LOCAL_TESTING"] == "true" ? 'isar' : '/app/isar/',
  );

  logger.i('addressUpdateIsolate isar opened.');

  while (await _isar.blocks.count() < await _heightInRest()) {
    //wait for sync
    logger.i('addressUpdateIsolate waiting for sync. Ignoring updates...');
    await Future.delayed(Duration(seconds: 10));
  }

  logger.i('addressUpdateIsolate Sync complete, looking for updates...');
  await performSync();

  //look for updates
  final isarStream = _isar.addressModels.watchLazy();

  await for (var _ in isarStream) {
    await performSync();
  }

  logger.i('addressUpdateIsolate Ended');
}

Future<int> _heightInRest() async {
  //figure out if we're syncing
  final chainInfo = await HttpWrapper().get(
    path: 'chaininfo.json',
    requestJson: true,
  );
  return chainInfo["blocks"];
}

bool syncInProgress = false;
//define closure
Future<void> performSync() async {
  logger.d("addressUpdateIsolate performSync called");
  if (syncInProgress == true) {
    logger.d("addressUpdateIsolate sync already in progress");
    return;
  }
  syncInProgress = true;
  final addressesThatNeedUpdating = await _isar.addressModels
      .filter()
      .needsUpdatingEqualTo(true)
      .limit(
        100,
      ) //limit to 100, writeTxn will trigger stream event and thus all addresses will be parsed in sequence
      .findAll();

  for (var address in addressesThatNeedUpdating) {
    logger.d("addressUpdateIsolate updating ${address.address}");
    double confirmedBalanceDouble = 0;
    double unconfirmedBalanceDouble = 0;

    for (var utxo in address.utxos) {
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

    address.status =
        sha256.convert(address.toHashableString().codeUnits).toString();

    await _isar.writeTxn(
      () async {
        address.needsUpdating = false;
        await _isar.addressModels.put(address);
      },
    );
    syncInProgress = false;
  }
}
