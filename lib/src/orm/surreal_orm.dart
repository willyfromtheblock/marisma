import 'dart:io';

import 'package:color_logger/color_logger.dart';
import 'package:dart_utxo_server/src/models/address.dart';
import 'package:dart_utxo_server/src/models/block.dart';
import 'package:dart_utxo_server/src/models/utxo.dart';
import 'package:surrealdb/surrealdb.dart';

import '../models/tx.dart';

class SurrealORM {
  late SurrealDB surrealClient;
  final _console =
      ColorLogger(); //TODO change logger to something where you can set log level
  Map<String, String> env = Platform.environment;
  static final Map<String, SurrealORM> _cache = <String, SurrealORM>{};

  factory SurrealORM() {
    return _cache.putIfAbsent('coin', () => SurrealORM._internal());
  }
  SurrealORM._internal();

  Future<void> init() async {
    //open db connection
    surrealClient =
        SurrealDB('${env["SURREAL_HOST"]}:${env["SURREAL_PORT"]}/rpc');
    surrealClient.connect();
    await surrealClient.wait();
    await surrealClient.use('dart_utxo_server', 'utxos');
    await surrealClient.signin(env["SURREAL_USER"]!, env["SURREAL_PASS"]!);
    await checkSchemas();
  }

  Future<void> checkSchemas() async {
    try {
      var res = parseQueryResults(
        await surrealClient.query('INFO FOR TABLE tx_history'),
      );
      if (res["ix"].isEmpty) {
        await surrealClient.query(
          '''
      DEFINE TABLE tx_history SCHEMAFULL PERMISSIONS NONE;
      DEFINE FIELD in ON TABLE tx_history TYPE string;
      DEFINE FIELD out ON TABLE tx_history TYPE string;
      DEFINE INDEX history_index ON TABLE tx_history COLUMNS out UNIQUE;
        ''',
        );
      }
    } catch (e) {
      _console.log(e.toString(), status: LogStatus.error);
    }
  }

  Future<int> getHeightInSurrealDB() async {
    if (env.containsKey('STARTING_POINT')) {
      return int.parse(env['STARTING_POINT']!);
    }
    var res = await surrealClient.select("blockchain:height");
    return res.isEmpty ? 0 : res[0]["height"];
  }

  Map parseQueryResults(Object? result) {
    var asList = result as List;
    if (asList[0] != null) {
      var asMap = asList[0] as Map;
      if (asMap.isNotEmpty) {
        return asMap["result"];
      }
    }
    return {};
  }

  Future<void> createBlock(Block block) async {
    try {
      await surrealClient.create('block:${block.height}', block);
      await surrealClient.query("UPDATE blockchain:height SET height += 1");
    } catch (e) {
      _console.log(e.toString(), status: LogStatus.error);
    }
  }

  Future<void> createTx(Tx tx) async {
    try {
      await surrealClient.create('tx:${tx.txid}', tx);
    } catch (e) {
      _console.log(e.toString(), status: LogStatus.error);
    }
  }

  Future<void> createUtxo(Utxo utxo) async {
    var utxoId = "utxo:${utxo.txid}${utxo.txpos}";
    try {
      await surrealClient.create(utxoId, utxo);
    } catch (e) {
      _console.log(e.toString(), status: LogStatus.error);
    }

    for (var addr in utxo.addresses) {
      try {
        await surrealClient.query(
          'RELATE address:$addr->has_utxo->$utxoId',
        );
      } catch (e) {
        _console.log(e.toString(), status: LogStatus.error);
      }
    }
  }

  Future<void> createAddress(AddressModel addr, String txId) async {
    //check if already exists
    var res = await surrealClient.select("address:${addr.address}");
    if (res.isEmpty) {
      //create new address and relate
      try {
        await surrealClient.query('''
          CREATE address:${addr.address} 
          SET address = "${addr.address}", 
          balance = <future> { math::sum(->has_utxo->utxo.value) }; 
          RELATE address:${addr.address}->tx_history->tx:$txId;
        ''');
      } catch (e) {
        _console.log(e.toString(), status: LogStatus.error);
      }
    } else {
      //relate existing address with txid
      try {
        await surrealClient.query(
          "RELATE address:${addr.address}->tx_history->tx:$txId",
        );
      } catch (e) {
        _console.log(e.toString(), status: LogStatus.error);
      }
    }
  }

  Future<void> deleteUtxo({
    required String utxoId,
  }) async {
    var utxoInDB = await surrealClient.select(utxoId);
    if (utxoInDB.isNotEmpty) {
      List addresses = utxoInDB[0]["addresses"];
      await surrealClient.delete(utxoId);

      for (var addr in addresses) {
        try {
          await surrealClient.query(
            'DELETE has_utxo WHERE in = "address:$addr" AND out = "utxo:$utxoId";',
          );
        } catch (e) {
          _console.log(e.toString(), status: LogStatus.error);
        }
      }
    }
  }
}
