import 'dart:io';
import 'dart:isolate';

import 'package:crypto/crypto.dart';
import 'package:isar/isar.dart';

import '../models/address.dart';
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
    if (message is String) {
      String address = message;
      logger.d('addressUpdateIsolate message received for $address.');

      final addrInIsar =
          await isar.addressModels.where().addressEqualTo(address).findFirst();
      if (addrInIsar != null) {
        int confirmedBalance = 0;
        int unconfirmedBalance = 0;

        for (var utxo in addrInIsar.utxos) {
          final value = (utxo.value * getDecimalProduct()).toInt();
          if (utxo.block > 0) {
            confirmedBalance += value;
          } else {
            unconfirmedBalance += value;
          }
        }

        addrInIsar.confirmedBalance = confirmedBalance;
        addrInIsar.unconfirmedBalance = unconfirmedBalance;

        addrInIsar.status =
            sha256.convert(addrInIsar.toHashableString().codeUnits).toString();

        await isar.writeTxn(() async {
          await isar.addressModels.put(addrInIsar);
        });
      }
    } else if (message == null) {
      logger.i('addressUpdateIsolate isolate finished.');
      Isolate.exit();
    }
  }
}
