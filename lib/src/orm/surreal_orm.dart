import 'dart:io';

import 'package:isar/isar.dart';

import '../models/address.dart';
import '../models/block.dart';
import '../models/tx.dart';
import '../models/utxo.dart';
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

  Future<void> createOrUpdateAddress(AddressModel addr, String txId) async {
    //TODO try catch
    await _isar.writeTxn(() async {
      //check if already exists
      final addressInIsar =
          await _isar.addressModels.getByAddress(addr.address);

      if (addressInIsar == null) {
        //create new address and relate
        await _isar.addressModels.put(addr);
        //TODO link utxo
        //TODO link transaction for history
        //TODO update balance
      } else {
        //relate existing address with txid on existing address
        // try {
        //   await .query(
        //     "RELATE address:${addr.address}->tx_history->tx:$txId",
        //   );
      }
    });
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

  void deleteUtxo({
    required String utxoId,
    required int txPos,
  }) async {
    try {
      await _isar.writeTxn(() async {
        await _isar.utxos
            .filter()
            .group(
              (q) => q.txidEqualTo(utxoId).and().txposEqualTo(txPos),
            )
            .deleteAll();
      });
    } catch (e) {
      _logger.e(e.toString());
    }
  }

  Future<List<String>> getAddressHistory(
    String address,
    bool ascending,
  ) async {
    return ["asdf"];
    // var res = parseQueryResults(
    //   await _isar.query(
    //     r"SELECT ->tx_history->tx as txs FROM $addr fetch txs PARALLEL",
    //     {"addr": "address:$address"},
    //   ),
    // );
    // if (res.isEmpty) return [];

    // List txids = res["txs"];
    // List<Map> responseUnsorted = [];

    // for (var element in txids) {
    //   responseUnsorted.add({
    //     "txid": element["txid"],
    //     "block": element["block"].replaceAll('block:', ''),
    //   });
    // }

    // responseUnsorted.sort(
    //   ascending
    //       ? ((a, b) => a["block"]!.compareTo(b["block"]!))
    //       : ((a, b) => b["block"]!.compareTo(a["block"]!)),
    // );

    // List<String> responseSorted = [];
    // for (var element in responseUnsorted) {
    //   responseSorted.add(element.toString());
    // }
    // return responseSorted.toSet().toList(); //filters duplicates
  }

  Future<String> getAdressUtxos(
    String address,
    int decimalProduct,
    bool ascending,
  ) async {
    final addrInIsar =
        await _isar.addressModels.where().addressEqualTo(address).findFirst();
    return addrInIsar!.utxos.toString();
    // var res = parseQueryResults(
    //   await _isar.query(
    //     r"SELECT ->has_utxo->utxo as utxos FROM $addr FETCH utxos PARALLEL",
    //     {"addr": "address:$address"},
    //   ),
    // );
    // if (res.isEmpty) return "";

    // List utxos = res["utxos"];
    // List response = [];
    // for (var element in utxos) {
    //   response.add({
    //     "txid": element["txid"].toString().replaceAll('tx:', ''),
    //     "block": element["block"].toString().replaceAll('block:', ''),
    //     "value":
    //         ((double.tryParse(element["value"]) ?? 0) * decimalProduct).toInt(),
    //     "index": element["txpos"]
    //   });
    // }

    // response.sort(
    //   ascending
    //       ? ((a, b) => a["block"]!.compareTo(b["block"]!))
    //       : ((a, b) => b["block"]!.compareTo(a["block"]!)),
    // );

    // return response.toString();
  }

  Future<double> getBalanceForAddress(String address) async {
    // var res = parseQueryResults(
    //   await _isar.query(
    //     r"SELECT balance FROM $addr",
    //     {"addr": "address:$address"},
    //   ),
    // );
    // if (res["balance"] != null) {
    //   return double.tryParse(res["balance"].toString()) ?? 0.0;
    // }
    return 0.0;
  }

  Future<int> getAddressNumberOfUtxos(
    String address,
  ) async {
    // var res = parseQueryResults(
    //   await _isar.query(
    //     r"SELECT count(->has_utxo) FROM $addr",
    //     {"addr": "address:$address"},
    //   ),
    // );

    // if (res.containsKey('count')) {
    //   return res['count'];
    // }
    return 0;
  }

  Future<int> getHeightInIsar() async {
    if (env.containsKey('STARTING_POINT')) {
      return int.parse(env['STARTING_POINT']!);
    }
    return await _isar.blocks.count();
  }

  Future<String> getTransaction(String txid) async {
    var res = await _isar.txs.where().txidEqualTo(txid).findFirst();

    if (res != null) {
      return res.rawTx.toString();
    }
    return "";
  }

  Future<bool> getIsAddressKnown(String address) async {
    // var res = parseQueryResults(
    //   await _isar.query(
    //     r"SELECT id FROM $addr",
    //     {"addr": "address:$address"},
    //   ),
    // );

    // if (res.containsKey('id')) {
    //   return true;
    // }
    return false;
  }

  Future<void> init() async {
    //open db connection
    _logger.i('Init Isar');
    await Isar.initializeIsarCore(download: true);
    _isar = await Isar.open([
      AddressModelSchema,
      BlockSchema,
      TxSchema,
      UtxoSchema,
    ]);
    _logger.i('Isia init complete');
  }
}
