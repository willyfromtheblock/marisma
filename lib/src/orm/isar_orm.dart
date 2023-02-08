import 'dart:convert';
import 'dart:io';
import 'dart:isolate';

import 'package:isar/isar.dart';
import 'package:marisma/src/orm/utxo_garbage_man_isolate.dart';

import '../models/address.dart';
import '../models/block.dart';
import '../models/utxo.dart';
import '../tools/logger.dart';
import 'address_update_isolate.dart';

class IsarORM {
  static final Map<String, IsarORM> _cache = <String, IsarORM>{};
  late Isar _isar;
  final _logger = LoggerWrapper().logger;
  Map<String, String> env = Platform.environment;

  factory IsarORM() {
    return _cache.putIfAbsent('isar', () => IsarORM._internal());
  }
  IsarORM._internal();

  Future<void> createBlock(Block block) async {
    try {
      await _isar.writeTxn(() async {
        await _isar.blocks.put(block);
      });
    } catch (e) {
      _logger.e(e.toString());
      throw Exception(e);
    }
  }

  Future<void> createOrUpdateAddress(AddressModel addr, String txId) async {
    try {
      //check if already exists
      final addressInIsar =
          await _isar.addressModels.getByAddress(addr.address);

      if (addressInIsar == null) {
        await _isar.writeTxn(() async {
          await _isar.addressModels.put(addr);
        });
      }
    } catch (e) {
      _logger.e(e.toString());
      throw Exception(e);
    }
  }

  Future<void> createUtxo(Utxo utxo) async {
    //TODO check if tx was unconfirmed before
    //TODO final wasUnconfirmed to pass to isolate?
    try {
      await _isar.writeTxn(() async {
        //put utxo
        await _isar.utxos.put(utxo);

        //update related addresses
        for (var addr in utxo.addresses) {
          final addrInIsar = await _isar.addressModels
              .where()
              .addressEqualTo(addr)
              .findFirst();

          if (addrInIsar != null) {
            addrInIsar.utxos.add(utxo);
            addrInIsar.needsUpdating = true;
            await _isar.addressModels.put(addrInIsar);
            await addrInIsar.utxos.save();
          }
        }
      });
    } catch (e) {
      _logger.e(e.toString());
      throw Exception(e);
    }
  }

  Future<void> flagUtxoForDelete({
    required String utxoTxId,
    required int txPos,
  }) async {
    try {
      await _isar.writeTxn(() async {
        final utxos = await _isar.utxos
            .where()
            .txidTxposEqualTo(utxoTxId, txPos)
            .findAll();

        for (var utxo in utxos) {
          utxo.flaggedForDelete = true;
          await _isar.utxos.put(utxo);
        }
      });
    } catch (e) {
      _logger.e(e.toString());
      throw Exception(e);
    }
  }

  Future<List<String>> getAddressHistory(
    String address,
    bool ascending,
  ) async {
    final addrInIsar =
        await _isar.addressModels.where().addressEqualTo(address).findFirst();
    if (addrInIsar != null) {
      List<String> response = [];
      for (var tx in addrInIsar.utxoHistory) {
        response.add(tx);
      }
      if (ascending == false) {
        return response.reversed.toSet().toList(); //filter duplicates
      }
      return response.toSet().toList(); //filter duplicates
    }

    return [];
  }

  Future<int> getAddressNumberOfUtxos(
    String address,
  ) async {
    final addrInIsar =
        await _isar.addressModels.where().addressEqualTo(address).findFirst();

    if (addrInIsar != null) {
      return addrInIsar.utxos.count();
    }
    return 0;
  }

  Future<List<String>> getAddressUtxos(
    String address,
    bool ascending,
  ) async {
    final addrInIsar =
        await _isar.addressModels.where().addressEqualTo(address).findFirst();
    if (addrInIsar != null) {
      List<String> response = [];
      for (var utxo in addrInIsar.utxos) {
        response.add(jsonEncode({
          "txid": utxo.txid,
          "block": utxo.block,
          "value": utxo.value,
          "index": utxo.txpos,
        }));
      }
      if (ascending == false) {
        return response.reversed.toList();
      }
      return response;
    }
    return [];
  }

  Future<Map<String, int>> getBalanceForAddress(String address) async {
    final addrInIsar =
        await _isar.addressModels.where().addressEqualTo(address).findFirst();

    if (addrInIsar != null) {
      return {
        "confirmed": addrInIsar.confirmedBalance,
        "unconfirmed": addrInIsar.unconfirmedBalance,
      };
    }
    return {
      "confirmed": 0,
      "unconfirmed": 0,
    };
  }

  Future<String> getBlockHash(int height) async {
    try {
      var block = await _isar.blocks.where().idEqualTo(height).findFirst();
      if (block != null) {
        return block.hash;
      }
    } catch (e) {
      _logger.e(e.toString());
    }
    return '';
  }

  Future<int> getHeightInIsar() async {
    return await _isar.blocks.count();
  }

  Future<int> getNumberOfAddressesThatNeedUpdating() async {
    return await _isar.addressModels
        .filter()
        .needsUpdatingEqualTo(true)
        .count();
  }

  Future<bool> getIsAddressKnown(String address) async {
    if (await _isar.addressModels.getByAddress(address) == null) {
      return false;
    }
    return true;
  }

  Future<void> init({required bool spawnIsolates}) async {
    //open db connection
    _logger.i('Init Isar');
    await Isar.initializeIsarCore(download: true);
    _isar = await Isar.open(
      [
        AddressModelSchema,
        BlockSchema,
        UtxoSchema,
      ],
      directory: env["LOCAL_TESTING"] == "true" ? 'isar' : '/app/isar/',
      maxSizeMiB: 8000, //TODO 8 GB is a placeholder here
      compactOnLaunch: CompactCondition(minRatio: 2.0),
    );

    if (spawnIsolates == true) {
      await Isolate.spawn(
        (_) {
          addressUpdateIsolate();
        },
        '',
      );
      await Isolate.spawn(
        (_) {
          utxoGarbageManIsolate();
        },
        '',
      );
    }

    ProcessSignal.sigterm.watch().listen(
      (event) async {
        LoggerWrapper().logger.i('IsarORM SIGTERM received');
        //TODO
      },
    );

    _logger.i('Isar init complete');
  }

  Future<void> performIsarReorg(int height) async {
    try {
      await _isar.writeTxn(() async {
        await _isar.blocks
            .where()
            .idGreaterThan(height, include: true)
            .deleteAll();
      });

      final utxos = await _isar.utxos
          .filter()
          .blockGreaterThan(height, include: true)
          .not()
          .blockLessThan(0) //don't delete mempool utxos on reorg
          .findAll();

      for (var utxo in utxos) {
        for (var address in utxo.addresses) {
          final addrInIsar = await _isar.addressModels
              .where()
              .addressEqualTo(address)
              .findFirst();

          if (addrInIsar != null) {
            await _isar.writeTxn(() async {
              addrInIsar.needsUpdating = true;
              await _isar.addressModels.put(addrInIsar);
            });
          }
        }
        await _isar.writeTxn(() async {
          await _isar.utxos.delete(utxo.id);
        });
      }
    } catch (e) {
      _logger.e(e.toString());
      throw Exception(e);
    }
  }
}
