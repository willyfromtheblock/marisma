import 'dart:io';

import 'package:isar/isar.dart';

import '../models/address.dart';
import '../models/block.dart';
import '../models/tx.dart';
import '../models/utxo.dart';
import '../server/grpc_server.dart';
import '../tools/logger.dart';

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
        //TODO outgoing tx not in history
      });
    } catch (e) {
      _logger.e(e.toString());
    }
  }

  Future<void> createTx(Tx tx) async {
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
    try {
      await _isar.writeTxn(() async {
        _isar.utxos.put(utxo);
      });
    } catch (e) {
      _logger.e(e.toString());
    }

    for (var addr in utxo.addresses) {
      await pingBalanceUpdate(
        address: addr,
        utxo: utxo,
      );
      try {
        await _isar.writeTxn(() async {
          final addrInIsar = await _isar.addressModels
              .where()
              .addressEqualTo(addr)
              .findFirst();
          addrInIsar!.utxos.add(utxo);
          await addrInIsar.utxos.save();
        });
      } catch (e) {
        _logger.e(e.toString());
      }
    }
  }

  Future<void> deleteUtxo({
    required String utxoId,
    required int txPos,
  }) async {
    try {
      final utxos = await _isar.utxos
          .filter()
          .group(
            (q) => q.txidEqualTo(utxoId).and().txposEqualTo(txPos),
          )
          .findAll();

      for (var utxo in utxos) {
        for (var address in utxo.addresses) {
          await pingBalanceUpdate(
            address: address,
            utxo: utxo,
            spent: true,
          );
        }
        await _isar.writeTxn(() async {
          //delete
          await _isar.utxos.delete(utxo.id);
        });
      }
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
        response.add({
          "txid": tx.txid,
          "block": tx.block,
        }.toString());
      }
      if (ascending == false) {
        return response.reversed.toSet().toList(); //filter duplicates
      }
      return response.toSet().toList(); //filter duplicates
    }

    return [""];
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
        response.add({
          "txid": utxo.txid,
          "block": utxo.block,
          "value": utxo.value,
          "index": utxo.txpos,
        }.toString());
      }
      if (ascending == false) {
        return response.reversed.toList();
      }
      return response;
    }
    return [];
  }

  Future<double> getBalanceForAddress(String address) async {
    final addrInIsar =
        await _isar.addressModels.where().addressEqualTo(address).findFirst();

    if (addrInIsar != null) {
      return double.tryParse(addrInIsar.balance.toString()) ?? 0.0;
    }
    return 0.0;
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
      return res.rawTx.toString();
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
      directory: "isar",
    );
    _logger.i('Isia init complete');
  }

  Future<void> performIsarReorg(int height) async {
    try {
      // await _isar.query(
      //   '''
      //   BEGIN TRANSACTION;
      //   DELETE FROM tx WHERE block.height >= $height;
      //   DELETE FROM tx_raw WHERE height >= $height;
      //   DELETE FROM utxo WHERE block.height >= $height;
      //   DELETE FROM block WHERE height >= $height;
      //   UPDATE blockchain:height SET height = ${height - 1};
      //   COMMIT TRANSACTION;
      //   ''',
      // );

      //TODO
    } catch (e) {
      _logger.e(e.toString());
    }
  }

  Future<void> pingBalanceUpdate({
    required String address,
    required Utxo utxo,
    bool spent = false,
  }) async {
    final addrInIsar =
        await _isar.addressModels.where().addressEqualTo(address).findFirst();
    if (addrInIsar != null) {
      int value = (utxo.value * getDecimalProduct()).toInt();

      if (spent == false) {
        addrInIsar.balance += value;
      } else {
        addrInIsar.balance -= value;
      }

      await _isar.writeTxn(() async {
        await _isar.addressModels.put(addrInIsar);
      });
    }
  }
}
