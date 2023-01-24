import 'dart:io';
import 'dart:isolate';

import 'package:crypto/crypto.dart';
import 'package:isar/isar.dart';

import '../models/address.dart';
import '../models/address_isolate_message.dart';
import '../models/block.dart';
import '../models/tx.dart';
import '../models/utxo.dart';
import '../tools/decimal_product.dart';
import '../tools/logger.dart';

Future<void> addressUpdateIsolate(SendPort p) async {
  LoggerWrapper().init();
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

  final commandPort = ReceivePort();
  p.send(commandPort.sendPort);

  await for (final message in commandPort) {
    if (message is AddressIsolateMessage) {
      String address = message.address;
      Utxo utxo = message.utxo;
      bool spent = message.spent;
      logger.d('addressUpdateIsolate message received for $address.');

      final addrInIsar =
          await isar.addressModels.where().addressEqualTo(address).findFirst();
      if (addrInIsar != null) {
        int value = (utxo.value * getDecimalProduct()).toInt();

        if (spent == false) {
          addrInIsar.confirmedBalance += value;
        } else {
          addrInIsar.confirmedBalance -= value;
        }

        //update status
        addrInIsar.status =
            sha256.convert(addrInIsar.toHashableString().codeUnits).toString();

        await isar.writeTxn(() async {
          await isar.addressModels.put(addrInIsar);
        });
      }
    }
  }

  logger.i('addressUpdateIsolate isolate finished.');
  Isolate.exit();
}
