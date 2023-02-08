import 'dart:async';
import 'dart:io';

import 'package:isar/isar.dart';
import 'package:just_throttle_it/just_throttle_it.dart';

import '../http_wrapper/http_wrapper.dart';
import '../models/address.dart';
import '../models/block.dart';
import '../models/utxo.dart';
import '../tools/logger.dart';

Map<String, String> env = Platform.environment;
final _logger = LoggerWrapper().logger;
late Isar _isar;
bool garbageCollectionInProgress = false;

Future<void> utxoGarbageManIsolate() async {
  LoggerWrapper().init();
  HttpWrapper().init();

  _logger.i('utxoGarbageManIsolate isolate started.');

  _isar = await Isar.open(
    [
      AddressModelSchema,
      BlockSchema,
      UtxoSchema,
    ],
    directory: env["LOCAL_TESTING"] == "true" ? 'isar' : '/app/isar/',
  );

  _logger.i('utxoGarbageManIsolate isar opened.');
  await performDelete();

  //look for updates
  final isarStream = _isar.utxos.watchLazy();

  final streamController = StreamController();
  streamController.addStream(isarStream);
  streamController.stream
      .transform(ThrottleStreamTransformer.milliseconds(250))
      .listen((event) async {
    if (garbageCollectionInProgress == false) {
      await performDelete();
    }
  });

  _logger.i('utxoGarbageManIsolate initialized');
}

Future<void> performDelete() async {
  _logger.d("utxoGarbageManIsolate performDelete called");
  if (garbageCollectionInProgress == true) {
    _logger.d("utxoGarbageManIsolate delete already in progress");
    return;
  }
  garbageCollectionInProgress = true;
  final utxosFlaggedForDeletion = await _isar.utxos
      .filter()
      .flaggedForDeleteEqualTo(true)
      .limit(
        1000,
      ) //limit to 1000, delete will trigger stream event and thus all addresses will be parsed in sequence
      .findAll();

  for (var utxo in utxosFlaggedForDeletion) {
    _logger.d("utxoGarbageManIsolate deleting ${utxo.txid} pos ${utxo.txpos}");

    try {
      await _isar.writeTxn(
        () async {
          for (var address in utxo.addresses) {
            final addrInIsar = await _isar.addressModels.getByAddress(address);

            if (addrInIsar != null) {
              addrInIsar.needsUpdating = true;
              addrInIsar.utxoHistory = [
                ...addrInIsar.utxoHistory,
                utxo.toJson(),
              ];
              await _isar.addressModels.put(addrInIsar);
            }
          }
          //delete
          await _isar.utxos.delete(utxo.id);
        },
      );
    } catch (e) {
      _logger.e(e.toString());
      throw Exception(e);
    }
  }
  garbageCollectionInProgress = false;
}
