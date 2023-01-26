import 'dart:io';
import 'dart:isolate';

import 'package:crypto/crypto.dart';
import 'package:isar/isar.dart';

import '../http_wrapper/http_wrapper.dart';
import '../models/address.dart';
import '../models/block.dart';
import '../models/tx.dart';
import '../models/utxo.dart';
import '../tools/decimal_product.dart';
import '../tools/logger.dart';

Future<void> addressUpdateIsolate(SendPort p) async {
  LoggerWrapper().init();
  HttpWrapper().init();

  final logger = LoggerWrapper().logger;
  logger.i('addressUpdateIsolate isolate started.');
  Map<String, String> env = Platform.environment;

  final isar = await Isar.open(
    [
      AddressModelSchema,
      BlockSchema,
      TxSchema,
      UtxoSchema,
    ],
    directory: env["LOCAL_TESTING"] == "true" ? 'isar' : '/app/isar/',
    inspector: false,
  );

  //provide port
  final commandPort = ReceivePort();
  p.send(commandPort.sendPort);

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

  logger.i('Sync complete, looking for updates...');

  //define closure
  Future<void> performSync() async {
    final addressesThatNeedUpdating =
        await isar.addressModels.filter().needsUpdatingEqualTo(true).findAll();

    for (var address in addressesThatNeedUpdating) {
      logger.d("addressUpdateIsolate updating ${address.address}");
      int confirmedBalance = 0;
      int unconfirmedBalance = 0;

      for (var utxo in address.utxos) {
        final value = (utxo.value * getDecimalProduct()).toInt();
        if (utxo.block > 0) {
          confirmedBalance += value;
        } else {
          unconfirmedBalance += value;
        }
      }

      address.confirmedBalance = confirmedBalance;
      address.unconfirmedBalance = unconfirmedBalance;

      address.status =
          sha256.convert(address.toHashableString().codeUnits).toString();

      await isar.writeTxn(() async {
        address.needsUpdating = false;
        await isar.addressModels.put(address);
      });
    }
  }

  //look for updates
  final isarStream = isar.addressModels.watchLazy(fireImmediately: true);

  await for (var _ in isarStream) {
    await performSync();
  }
}
