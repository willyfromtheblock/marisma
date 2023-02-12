import 'dart:async';
import 'dart:io';

import 'package:crypto/crypto.dart';
import 'package:isar/isar.dart';
import 'package:just_throttle_it/just_throttle_it.dart';

import '../http_wrapper/http_wrapper.dart';
import '../models/address.dart';
import '../models/block.dart';
import '../models/utxo.dart';
import '../tools/decimal_product.dart';
import '../tools/height_in_rest.dart';
import '../tools/logger.dart';

Map<String, String> env = Platform.environment;
final _logger = LoggerWrapper().logger;
late Isar _isar;

Future<void> addressUpdateIsolate() async {
  LoggerWrapper().init();
  HttpWrapper().init();

  _logger.i('addressUpdateIsolate isolate started.');

  _isar = await Isar.open(
    [
      AddressModelSchema,
      BlockSchema,
      UtxoSchema,
    ],
    directory: env["LOCAL_TESTING"] == "true" ? 'isar' : '/app/isar/',
  );

  _logger.i('addressUpdateIsolate isar opened.');

  while (await _isar.blocks.count() < await heightInRest() ||
      await _isar.utxos.filter().flaggedForDeleteEqualTo(true).count() > 0) {
    //wait for sync
    _logger.i(
      'addressUpdateIsolate waiting for sync and utxo gargabe man to be done. Ignoring updates...',
    );
    await Future.delayed(Duration(seconds: 10));
  }

  _logger.i('addressUpdateIsolate Sync complete, looking for updates...');
  await performSync();

  //look for updates
  final isarStream = _isar.addressModels.watchLazy(fireImmediately: true);

  final streamController = StreamController();
  streamController.addStream(isarStream);
  final throttledStream = streamController.stream.transform(
    ThrottleStreamTransformer.milliseconds(250),
  );

  _logger.i('addressUpdateIsolate initialized');

  await for (var _ in throttledStream) {
    await performSync();
  }
}

Future<void> performSync() async {
  _logger.d("addressUpdateIsolate performSync called");

  final addressesThatNeedUpdating = await _isar.addressModels
      .filter()
      .needsUpdatingEqualTo(true)
      .limit(
        1000,
      ) //limit to 1000, writeTxn will trigger stream event and thus all addresses will be parsed in sequence
      .findAll();

  for (var address in addressesThatNeedUpdating) {
    try {
      await _updateAddress(address);
    } catch (e) {
      _logger.e(e.toString());
      throw Exception(e.toString());
    }
  }
}

Future<void> _updateAddress(AddressModel address) async {
  _logger.d("addressUpdateIsolate updating ${address.address}");
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
}
