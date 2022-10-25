import 'dart:io';

import 'package:surrealdb/surrealdb.dart';

import '../models/address.dart';
import '../models/block.dart';
import '../models/tx.dart';
import '../models/utxo.dart';
import '../tools/logger.dart';

class SurrealORM {
  static final Map<String, SurrealORM> _cache = <String, SurrealORM>{};
  late SurrealDB surrealClient;
  final _logger = LoggerWrapper().logger;
  Map<String, String> env = Platform.environment;

  factory SurrealORM() {
    return _cache.putIfAbsent('surreal', () => SurrealORM._internal());
  }
  SurrealORM._internal();

  Future<void> checkSchemas() async {
    try {
      var res = parseQueryResults(
        await surrealClient.query('INFO FOR TABLE tx_history'),
      );
      if (res["ix"].isEmpty) {
        // await surrealClient.query(
        //   '''
        //   DEFINE TABLE tx_history SCHEMAFULL PERMISSIONS NONE;
        //   DEFINE FIELD in ON TABLE tx_history TYPE string;
        //   DEFINE FIELD out ON TABLE tx_history TYPE string;
        //   DEFINE INDEX history_index ON TABLE tx_history COLUMNS out UNIQUE;
        //   ''',
        // );
      }
    } catch (e) {
      _logger.e(e.toString());
    }
  }

  Future<void> createAddress(AddressModel addr, String txId) async {
    //check if already exists
    var res = parseQueryResults(
      await surrealClient.query(
        "SELECT id from address:${addr.address}",
      ),
    );

    if (res.isEmpty) {
      //create new address and relate
      try {
        await surrealClient.query(
          '''
          BEGIN TRANSACTION;
          CREATE address:${addr.address} 
          SET address = "${addr.address}", 
          status = rand::uuid(),
          balance = <future> { math::sum(->has_utxo->utxo.value) }; 
          RELATE address:${addr.address}->tx_history->tx:$txId;
          COMMIT TRANSACTION;
          ''',
        );
      } catch (e) {
        _logger.e(e.toString());
      }
    } else {
      //relate existing address with txid
      try {
        await surrealClient.query(
          '''
          BEGIN TRANSACTION;
          RELATE address:${addr.address}->tx_history->tx:$txId;
          UPDATE address:${addr.address} SET status = rand::uuid();
          COMMIT TRANSACTION;
          ''',
        );
      } catch (e) {
        _logger.e(e.toString());
      }
    }
  }

  Future<void> createBlock(Block block) async {
    try {
      await surrealClient.query(
        '''
        BEGIN TRANSACTION;
        CREATE block:${block.height} 
        SET height = ${block.height}, 
        hash = "${block.hash}",
        blocktime = ${block.blocktime};
        UPDATE blockchain:height SET height += 1;
        COMMIT TRANSACTION;
        ''',
      );
    } catch (e) {
      _logger.e(e.toString());
    }
  }

  Future<void> createTx(Tx tx) async {
    try {
      await surrealClient.create('tx:${tx.txid}', tx);
    } catch (e) {
      _logger.e(e.toString());
    }
  }

  Future<void> createUtxo(Utxo utxo) async {
    var utxoId = "utxo:${utxo.txid}${utxo.txpos}";
    try {
      await surrealClient.create(utxoId, utxo);
    } catch (e) {
      _logger.e(e.toString());
    }

    for (var addr in utxo.addresses) {
      try {
        await surrealClient.query(
          'RELATE address:$addr->has_utxo->$utxoId',
        );
      } catch (e) {
        _logger.e(e.toString());
      }
    }
  }

  Future<void> deleteUtxo({
    required String utxoId,
  }) async {
    try {
      await surrealClient.delete(utxoId);
    } catch (e) {
      _logger.e(e.toString());
    }
  }

  Future<int> getHeightInSurrealDB() async {
    if (env.containsKey('STARTING_POINT')) {
      return int.parse(env['STARTING_POINT']!);
    }
    var res = await surrealClient.select("blockchain:height");
    return res.isEmpty ? 0 : res[0]["height"];
  }

  Future<double> getBalanceForAddress(String address) async {
    var res = parseQueryResults(
      await surrealClient.query("SELECT balance FROM address:$address"),
    );
    if (res["balance"] != null) {
      return double.tryParse(res["balance"].toString()) ?? 0.0;
    }
    return 0.0;
  }

  Future<String> getAdressUtxos(String address, int decimalProduct) async {
    var res = parseQueryResults(
      await surrealClient.query(
          "SELECT ->has_utxo->utxo as utxos FROM address:$address fetch utxos"),
    );
    List utxos = res["utxos"];
    List response = [];
    for (var element in utxos) {
      response.add({
        "txid": element["txid"].toString().replaceAll('tx:', ''),
        "value": element["value"],
        "value_sats":
            ((double.tryParse(element["value"]) ?? 0) * decimalProduct).toInt(),
        "index": element["txpos"]
      });
    }
    return response.toString();
  }

  Future<bool> getHasAddressUtxos(
    String address,
  ) async {
    var res = parseQueryResults(
      await surrealClient.query(
        "SELECT ->has_utxo as utxos FROM address:$address", //TODO fetches all ->has_utxo ... find more efficient solution
      ),
    );

    if (res.isEmpty) return false;
    if (res.containsKey('utxos')) {
      var asList = res['utxos'] as List;
      if (asList.isEmpty) {
        return false;
      }
    }
    return true;
  }

  Future<void> init() async {
    //open db connection
    _logger.i('Connecting to SurrealDB...');
    surrealClient =
        SurrealDB('${env["SURREAL_HOST"]}:${env["SURREAL_PORT"]}/rpc');
    surrealClient.connect();
    await surrealClient.wait();
    await surrealClient.use('marisma', 'utxos');
    await surrealClient.signin(env["SURREAL_USER"]!, env["SURREAL_PASS"]!);
    await checkSchemas();
    _logger.i('Connected to SurrealDB');
  }

  Map parseQueryResults(Object? result) {
    var asList = result as List;
    if (asList[0] != null) {
      var asMap = asList[0] as Map;
      if (asMap.isNotEmpty) {
        if (asMap["result"].runtimeType == List<dynamic>) {
          if (asMap["result"].isNotEmpty) {
            return asMap["result"][0];
          } else {
            return {};
          }
        }
        return asMap["result"];
      }
    }
    return {};
  }
}
