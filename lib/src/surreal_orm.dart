import 'dart:io';

import 'package:dart_utxo_server/src/models/block.dart';
import 'package:dart_utxo_server/src/models/utxo.dart';
import 'package:surrealdb/surrealdb.dart';

class SurrealORM {
  late SurrealDB surrealClient;
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
    // await surrealClient.create('block:2', Block(height: 2, hash: "fasdf"));
    // print(await getHeightInSurrealDB());
  }

  Future<int> getHeightInSurrealDB() async {
    if (env.containsKey('STARTING_POINT')) {
      return int.parse(env['STARTING_POINT']!);
    }
    var res = parseQueryResults(await surrealClient.query(
      'SELECT height from block ORDER BY height DESC LIMIT 1',
    ));
    return res.isEmpty ? 0 : res[0]["height"];
  }

  List parseQueryResults(Object? result) {
    var asList = result as List;
    if (asList[0] != null) {
      var asMap = asList[0] as Map;
      if (asMap.isNotEmpty) {
        return asMap["result"];
      }
    }
    return [];
  }

  Future<void> createBlock(Block block) async {
    await surrealClient.create('block:${block.height}', block);
  }

  Future<void> createUtxo(Utxo utxo) async {
    await surrealClient.create('utxo:${utxo.hash}-${utxo.txpos}', utxo);
  }
}
