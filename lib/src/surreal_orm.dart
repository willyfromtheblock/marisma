import 'dart:io';

import 'package:color_logger/color_logger.dart';
import 'package:dart_utxo_server/src/models/address.dart';
import 'package:dart_utxo_server/src/models/block.dart';
import 'package:dart_utxo_server/src/models/utxo.dart';
import 'package:surrealdb/surrealdb.dart';

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
    try {
      await surrealClient.create('block:${block.height}', block);
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
          'UPDATE address:$addr SET utxos += $utxoId, balance += ${utxo.value}',
        );
      } catch (e) {
        _console.log(e.toString(), status: LogStatus.error);
      }
    }
  }

  Future<void> createAddress(AddressModel addr, String utxoId) async {
    //check if already exists
    var res = await surrealClient.select("address:${addr.address}");
    if (res.isEmpty) {
      try {
        await surrealClient.query(
            'CREATE address:${addr.address} SET utxos = [], address = "${addr.address}", balance = 0');
      } catch (e) {
        _console.log(e.toString(), status: LogStatus.error);
      }
    }
  }

  Future<void> deleteUtxo({
    required String utxoId,
    required double utxoValue,
  }) async {
    var utxoInDB = await surrealClient.select(utxoId);
    if (utxoInDB.isNotEmpty) {
      List addresses = utxoInDB[0]["addresses"];
      await surrealClient.delete(utxoId);

      for (var addr in addresses) {
        try {
          await surrealClient.query(
              'UPDATE $addr SET utxos -= $utxoId, balance -= $utxoValue');
        } catch (e) {
          _console.log(e.toString(), status: LogStatus.error);
        }
      }
    }
  }
}
