import 'dart:async';

import 'package:crypto/crypto.dart';
import 'package:isar/isar.dart';

import '../http_wrapper/http_wrapper.dart';
import '../models/address.dart';
import '../models/block.dart';
import '../models/utxo.dart';
import '../tools/decimal_product.dart';
import '../tools/height_in_rest.dart';
import '../tools/logger.dart';

final _logger = LoggerWrapper().logger;
late Isar _isar;

Future<void> addressUpdateIsolate() async {
  LoggerWrapper().init();
  HttpWrapper().init();

  _logger.i('addressUpdateIsolate isolate started.');

  _isar = Isar.getSQLite(
    schemas: [
      AddressModelSchema,
      BlockSchema,
      UtxoSchema,
    ],
  );

  _logger.d('addressUpdateIsolate isar opened.');

  while (_isar.blocks.count() < await heightInRest() ||
      _isar.utxos.where().flaggedForDeleteEqualTo(true).count() > 0) {
    //wait for sync
    _logger.d(
      'addressUpdateIsolate waiting for sync and utxo gargabe man to be done. Ignoring updates...',
    );
    await Future.delayed(Duration(seconds: 10));
  }

  _logger.i('addressUpdateIsolate Sync complete, looking for updates...');
  await performSync();

  //look for updates
  final isarStream = _isar.addressModels.watchLazy(fireImmediately: true);

  _logger.i('addressUpdateIsolate initialized');

  await for (var _ in isarStream) {
    while (_isar.addressModels.where().needsUpdatingEqualTo(true).count() > 0) {
      await performSync();
    }
  }
}

Future<void> performSync() async {
  _logger.d("addressUpdateIsolate performSync called");
  while (_isar.utxos.where().flaggedForDeleteEqualTo(true).count() > 0) {
    _logger.d(
      "addressUpdateIsolate utxo garbage man at work, delaying this update...",
    );
    await Future.delayed(
      Duration(seconds: 1),
    );
  }

  final addressesThatNeedUpdating = _isar.addressModels
      .where()
      .needsUpdatingEqualTo(true)
      .findAll(limit: 1000);

  List<Future<void>> futures = [];
  for (var address in addressesThatNeedUpdating) {
    futures.add(_updateAddress(address));
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

Future<void> _updateAddress(AddressModel address) async {
  _logger.d("addressUpdateIsolate updating ${address.address}");
  double confirmedBalanceDouble = 0;
  double unconfirmedBalanceDouble = 0;

  for (var utxoId in address.utxos) {
    final utxo = await _isar.utxos.getAsync(utxoId);
    if (utxo == null) {
      throw Exception('Utxo $utxoId not found in database');
    }

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

  _isar.write(
    (instance) {
      address.needsUpdating = false;
      instance.addressModels.put(address);
    },
  );
}
