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

Future<void> addressUpdateIsolate() async {
  LoggerWrapper().init();
  HttpWrapper().init();

  final logger = LoggerWrapper().logger;
  logger.i('addressUpdateIsolate isolate started.');

  final isar = await Isar.open(
    [
      AddressModelSchema,
      BlockSchema,
      TxSchema,
      UtxoSchema,
    ],
  );

  //figure out if we're syncing
  final chainInfo = await HttpWrapper().get(
    path: 'chaininfo.json',
    requestJson: true,
  );
  final heightInRest = chainInfo["blocks"];

  while (await isar.blocks.count() < heightInRest) {
    //wait for sync
    logger.i('addressUpdateIsolate waiting for sync. Ignoring updates...');
    await Future.delayed(Duration(seconds: 10));
  }

  logger.i('addressUpdateIsolate Sync complete, looking for updates...');

  //define closure
  Future<void> performSync() async {
    final addressesThatNeedUpdating = await isar.addressModels
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

      await isar.writeTxn(
        () async {
          address.needsUpdating = false;
          await isar.addressModels.put(address);
        },
      );
    }
  }

  //look for updates
  final isarStream = isar.addressModels.watchLazy(fireImmediately: true);

  await for (var _ in isarStream) {
    await performSync();
  }

  logger.i('addressUpdateIsolate Ended');
}
