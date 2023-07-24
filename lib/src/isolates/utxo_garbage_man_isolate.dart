import 'dart:async';
import 'dart:io';

import 'package:isar/isar.dart';

import '../http_wrapper/http_wrapper.dart';
import '../models/address.dart';
import '../models/block.dart';
import '../models/utxo.dart';
import '../tools/logger.dart';

Map<String, String> env = Platform.environment;
final _logger = LoggerWrapper().logger;
late Isar _isar;

Future<void> utxoGarbageManIsolate() async {
  LoggerWrapper().init();
  HttpWrapper().init();

  _logger.i('utxoGarbageManIsolate isolate started.');

  _isar = Isar.getSQLite(
    schemas: [
      AddressModelSchema,
      BlockSchema,
      UtxoSchema,
    ],
  );

  _logger.d('utxoGarbageManIsolate isar opened.');
  await performDelete();

  //look for updates
  final isarStream = _isar.utxos.watchLazy(fireImmediately: true);

  _logger.i('utxoGarbageManIsolate initialized');

  await for (var _ in isarStream) {
    while (_isar.utxos.where().flaggedForDeleteEqualTo(true).count() > 0) {
      await performDelete();
    }
  }
}

Future<void> performDelete() async {
  _logger.d("utxoGarbageManIsolate performDelete called");
  final utxosFlaggedForDeletion = _isar.utxos
      .where()
      .flaggedForDeleteEqualTo(true)
      .findAll(); //TODO add limit

  List<Future<void>> futures = [];
  for (var utxo in utxosFlaggedForDeletion) {
    _logger.d("utxoGarbageManIsolate deleting ${utxo.txid} pos ${utxo.txpos}");

    futures.add(
      _isar.writeAsync(
        (instance) async {
          //delete
          instance.utxos.delete(utxo.id);

          for (var address in utxo.addresses) {
            final addrInIsar = instance.addressModels
                .where()
                .addressEqualTo(address)
                .findFirst();

            if (addrInIsar != null) {
              addrInIsar.needsUpdating = true;
              addrInIsar.utxoHistory = [
                ...addrInIsar.utxoHistory,
                utxo.toJson(),
              ];
              instance.addressModels.put(addrInIsar);
            }
          }
        },
      ),
    );
  }

  await Future.wait(futures).onError(
    (e, _) {
      _logger.e(e.toString());
      throw Exception(
        e.toString(),
      );
    },
  );
}
