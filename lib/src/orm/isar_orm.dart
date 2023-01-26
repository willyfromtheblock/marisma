import 'dart:convert';
import 'dart:io';
import 'dart:isolate';

import 'package:isar/isar.dart';

import '../models/address.dart';
import '../models/block.dart';
import '../models/tx.dart';
import '../models/utxo.dart';
import '../tools/logger.dart';
import 'address_update_isolate.dart';

class IsarORM {
  static final Map<String, IsarORM> _cache = <String, IsarORM>{};
  late Isar _isar;
  final _logger = LoggerWrapper().logger;
  late SendPort _addressUpdatePort;
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
    }
  }

  Future<void> createOrUpdateAddress(AddressModel addr, String txId) async {
    try {
      await _isar.writeTxn(() async {
        //check if already exists
        final addressInIsar =
            await _isar.addressModels.getByAddress(addr.address);
        AddressModel addrToWrite = addressInIsar ?? addr;

        //link transaction for history
        final tx = await _isar.txs.getByTxid(txId);
        if (tx != null) {
          addrToWrite.transactions.add(tx);
        }

        await _isar.addressModels.put(addrToWrite);
        await addrToWrite.transactions.save();
        //[x] outgoing tx not in history for now , do we want it to be?
      });
    } catch (e) {
      _logger.e(e.toString());
    }
  }

  Future<void> createTx(Tx tx) async {
    //TODO check if tx was unconfirmed before
    try {
      await _isar.writeTxn(() async {
        final txInIsar = await _isar.txs.getByTxid(tx.txid);

        if (txInIsar == null) {
          await _isar.txs.put(tx);
        }
      });
    } catch (e) {
      _logger.e(e.toString());
    }
  }

  Future<void> createUtxo(Utxo utxo) async {
    //TODO check if tx was unconfirmed before
    //TODO final wasUnconfirmed to pass to isolate?
    try {
      await _isar.writeTxn(() async {
        _isar.utxos.put(utxo);
      });
    } catch (e) {
      _logger.e(e.toString());
    }

    await _isar.writeTxn(
      () async {
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
      },
    );
  }

  Future<void> deleteUtxo({
    required String utxoTxId,
    required int txPos,
  }) async {
    try {
      final utxos = await _isar.utxos
          .filter()
          .group(
            (q) => q.txidEqualTo(utxoTxId).and().txposEqualTo(txPos),
          )
          .findAll();

      await _isar.writeTxn(() async {
        for (var utxo in utxos) {
          for (var address in utxo.addresses) {
            final addrInIsar = await _isar.addressModels
                .where()
                .addressEqualTo(address)
                .findFirst();

            if (addrInIsar != null) {
              addrInIsar.needsUpdating = true;
              await _isar.addressModels.put(addrInIsar);
            }
          }
          //delete
          await _isar.utxos.delete(utxo.id);
        }
      });
    } catch (e) {
      _logger.e(e.toString());
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
      for (var tx in addrInIsar.transactions) {
        response.add(jsonEncode({
          "txid": tx.txid,
          "block": tx.block,
        }));
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
    if (env.containsKey('STARTING_POINT')) {
      return int.parse(env['STARTING_POINT']!);
    }
    return await _isar.blocks.count();
  }

  Future<bool> getIsAddressKnown(String address) async {
    if (await _isar.addressModels.getByAddress(address) == null) {
      return false;
    }
    return true;
  }

  Future<String> getTransaction(String txid) async {
    var res = await _isar.txs.where().txidEqualTo(txid).findFirst();

    if (res != null) {
      return jsonEncode(res.rawTx); //TODO not in correct format
      //    "tx": "\"{txid: 11f6fbb8acd7aaf29276ead5fa0ff34ccbae7e2ddbbc51fa0c85451564cf9132 ...
    }
    return "";
  }

  Future<void> init() async {
    //open db connection
    _logger.i('Init Isar');
    await Isar.initializeIsarCore(download: true);
    _isar = await Isar.open(
      [
        AddressModelSchema,
        BlockSchema,
        TxSchema,
        UtxoSchema,
      ],
      directory: env["LOCAL_TESTING"] == "true" ? 'isar' : '/app/isar/',
      maxSizeMiB: 20000,
    );

    _addressUpdatePort = await spawnAddressUpdateIsolate();

    ProcessSignal.sigterm.watch().listen(
      (event) async {
        LoggerWrapper().logger.i('IsarORM SIGTERM received');
        _addressUpdatePort.send(null);
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

        await _isar.txs
            .filter()
            .blockGreaterThan(height, include: true)
            .deleteAll();

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
          await _isar.utxos.delete(utxo.id);
        }
      });
    } catch (e) {
      _logger.e(e.toString());
    }
  }

  Future<SendPort> spawnAddressUpdateIsolate() async {
    final p = ReceivePort();

    await Isolate.spawn(
      addressUpdateIsolate,
      p.sendPort,
    );
    return await p.first;
  }
}
