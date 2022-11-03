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

  Future<void> createOrUpdateAddress(AddressModel addr, String txId) async {
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
      //relate existing address with txid on existing address
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

  Future<List<String>> getAddressHistory(
    String address,
    bool ascending,
  ) async {
    var res = parseQueryResults(
      await surrealClient.query(
        r"SELECT ->tx_history->tx as txs FROM $addr fetch txs PARALLEL",
        {"addr": "address:$address"},
      ),
    );
    if (res.isEmpty) return [];

    List txids = res["txs"];
    List<Map> responseUnsorted = [];

    for (var element in txids) {
      responseUnsorted.add({
        "txid": element["txid"],
        "block": element["block"].replaceAll('block:', ''),
      });
    }

    responseUnsorted.sort(
      ascending
          ? ((a, b) => a["block"]!.compareTo(b["block"]!))
          : ((a, b) => b["block"]!.compareTo(a["block"]!)),
    );

    List<String> responseSorted = [];
    for (var element in responseUnsorted) {
      responseSorted.add(element.toString());
    }
    return responseSorted.toSet().toList(); //filters duplicates
  }

  Future<String> getAdressUtxos(
    String address,
    int decimalProduct,
    bool ascending,
  ) async {
    var res = parseQueryResults(
      await surrealClient.query(
        r"SELECT ->has_utxo->utxo as utxos FROM $addr FETCH utxos PARALLEL",
        {"addr": "address:$address"},
      ),
    );
    if (res.isEmpty) return "";

    List utxos = res["utxos"];
    List response = [];
    for (var element in utxos) {
      response.add({
        "txid": element["txid"].toString().replaceAll('tx:', ''),
        "block": element["block"].toString().replaceAll('block:', ''),
        "value":
            ((double.tryParse(element["value"]) ?? 0) * decimalProduct).toInt(),
        "index": element["txpos"]
      });
    }

    response.sort(
      ascending
          ? ((a, b) => a["block"]!.compareTo(b["block"]!))
          : ((a, b) => b["block"]!.compareTo(a["block"]!)),
    );

    return response.toString();
  }

  Future<double> getBalanceForAddress(String address) async {
    var res = parseQueryResults(
      await surrealClient.query(
        r"SELECT balance FROM $addr",
        {"addr": "address:$address"},
      ),
    );
    if (res["balance"] != null) {
      return double.tryParse(res["balance"].toString()) ?? 0.0;
    }
    return 0.0;
  }

  Future<String> getRawTx(String txid) async {
    var res = parseQueryResults(
      await surrealClient.query(
        r"SELECT tx_data FROM $tx",
        {"tx": "tx:$txid"},
      ),
    );
    if (res["tx_data"] != null) {
      return res["tx_data"];
    }
    return "";
  }

  Future<bool> getHasAddressUtxos(
    String address,
  ) async {
    var res = parseQueryResults(
      await surrealClient.query(
        r"SELECT count(->has_utxo) FROM $addr",
        {"addr": "address:$address"},
      ),
    );

    if (res.isEmpty) return false;
    print(res);
    if (res.containsKey('count')) {
      if (res['count'] > 0) return true;
    }
    return false;
  }

  Future<int> getHasAddressNumberOfUtxos(
    String address,
  ) async {
    var res = parseQueryResults(
      await surrealClient.query(
        r"SELECT count(->has_utxo) FROM $addr",
        {"addr": "address:$address"},
      ),
    );

    if (res.containsKey('count')) {
      return res['count'];
    }
    return 0;
  }

  Future<int> getHeightInSurrealDB() async {
    if (env.containsKey('STARTING_POINT')) {
      return int.parse(env['STARTING_POINT']!);
    }
    var res = parseQueryResults(
      await surrealClient.query("SELECT * FROM blockchain:height"),
    );
    return res.isEmpty ? 0 : res["height"];
  }

  Future<void> init([bool fromIsolate = false]) async {
    //open db connection
    _logger.i(fromIsolate
        ? 'Server isolate - Connecting to SurrealDB...'
        : 'Connecting to SurrealDB...');
    surrealClient =
        SurrealDB('${env["SURREAL_HOST"]}:${env["SURREAL_PORT"]}/rpc');
    surrealClient.connect();
    await surrealClient.wait();
    await surrealClient.use('marisma', 'utxos');
    await surrealClient.signin(env["SURREAL_USER"]!, env["SURREAL_PASS"]!);
    await checkSchemas();
    _logger.i(fromIsolate
        ? 'Server isolate - Connected to SurrealDB'
        : 'Connected to SurrealDB');
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
