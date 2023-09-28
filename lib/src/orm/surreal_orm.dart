import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:grpc/grpc.dart';
import 'package:marisma/src/orm/surreal_schema.dart';
import 'package:marisma/src/tools/decimal_product.dart';
import 'package:surrealdb/surrealdb.dart';

import '../generated/marisma.pb.dart';
import '../models/address.dart';
import '../models/block.dart';
import '../models/utxo.dart';
import '../tools/logger.dart';

class SurrealORM {
  static final Map<String, SurrealORM> _cache = <String, SurrealORM>{};
  late SurrealDB surrealClient;
  final _logger = LoggerWrapper().logger;
  Map<String, String> env = Platform.environment;
  final _blockHashStreamController = StreamController<
      BlockHashStreamReply>.broadcast(); //can be defined globally, same stream for all clients

  factory SurrealORM() {
    return _cache.putIfAbsent('surreal', () => SurrealORM._internal());
  }
  SurrealORM._internal();

  Stream<AddressStatusStreamReply> addressStatusStream(String address) async* {
    final addressStatusStreamController =
        StreamController<AddressStatusStreamReply>();

    _logger.d('addressStatusStream requested: $address');

    if (await getIsAddressKnown(address)) {
      final addrId = "address:$address";
      final liveQuery = await surrealClient.liveQuery(
        "LIVE SELECT status FROM address WHERE id = $addrId",
      );

      liveQuery.stream.listen((event) async {
        final result = event.result as Map;

        addressStatusStreamController.add(
          AddressStatusStreamReply()
            ..status = result['status']
            ..address = address,
        );
      });
    } else {
      addressStatusStreamController.addError(
        GrpcError.notFound('Address not found in database'),
      );
    }
    yield* addressStatusStreamController.stream.distinct();
  }

  Stream<BlockHashStreamReply> blockHashStream() async* {
    yield* _blockHashStreamController.stream.distinct();
  }

  Future<Stream> liveTableStream(String table) async {
    _logger.d('liveTableStream requested: $table');

    final liveTable = await surrealClient.liveTable(table);

    return liveTable.stream;
  }

  Future<void> checkSchemas() async {
    try {
      if (await getHeightInSurrealDB() == 0) {
        //empty db, create schemas
        await surrealClient.query(surrealSchema);
      }
    } catch (e) {
      _logger.e(e.toString());
    }
  }

  Future<void> createBlock(Block block) async {
    try {
      await surrealClient.query(
        '''
        BEGIN TRANSACTION;
        CREATE block:${block.height} 
        SET height = ${block.height}, 
        hash = "${block.hash}";
        UPDATE blockchain:height SET height += 1;
        COMMIT TRANSACTION;
        ''',
      );
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
      //create new address
      try {
        await surrealClient.create('address:${addr.address}', addr);
      } catch (e) {
        _logger.e(e.toString());
      }
    }
  }

  Future<void> updateAddress(AddressModel addr) async {
    _logger.d("updating ${addr.address} with status ${addr.status}");
    try {
      await surrealClient.update(
        "address:${addr.address}",
        addr,
      );
    } catch (e) {
      _logger.e(e.toString());
    }
  }

  Future<void> createUtxo(Utxo utxo) async {
    var utxoId = "utxo:${utxo.txid}${utxo.txpos}";

    //check if utxo already exists
    final res = parseQueryResults(
      await surrealClient.query(
        "SELECT id from $utxoId",
      ),
    );
    if (res.isEmpty) {
      //create new utxo and relate
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
    } else {
      //update existing utxo
      try {
        await surrealClient.update(utxoId, utxo);
      } catch (e) {
        _logger.e(e.toString());
      }
    }
  }

  Future<void> deleteUtxo({
    required String utxoId,
  }) async {
    try {
      _logger.d('Deleting UTXO utxo:$utxoId');
      //check if utxo exists
      final res = parseQueryResults(
        await surrealClient.query(
          "SELECT id from utxo:$utxoId",
        ),
      );

      if (res.isNotEmpty) {
        //does exist, delete!
        await surrealClient.delete('utxo:$utxoId');
      } else {
        //recursion after 100ms until it's there
        await Future.delayed(Duration(milliseconds: 100));
        await deleteUtxo(utxoId: utxoId);
      }
    } catch (e) {
      _logger.e(e.toString());
    }
  }

  Future<List<String>> getAddressUtxoHistory({
    required String address,
    int minimumHeight = 0,
    bool ascending = false,
  }) async {
    //TODO
    return [];
  }

  Future<int> getAddressNumberOfUtxos(
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

  Future<List<String>> getAddressSortedUtxoStrings({
    required String address,
    int minimumHeight = 0,
    bool ascending = false,
  }) async {
    final res = await getAddressUtxos(
      address: address,
      minimumHeight: minimumHeight,
      ascending: ascending,
    );

    List<String> utxoStrings = [];
    for (var utxo in res) {
      utxoStrings.add(
        jsonEncode(
          utxo.toJson(),
        ),
      );
    }

    return utxoStrings;
  }

  Future<List<Utxo>> getAddressUtxos({
    required String address,
    int minimumHeight = 0,
    bool ascending = false,
  }) async {
    var res = parseQueryResults(
      await surrealClient.query(
        r"SELECT ->has_utxo->utxo as utxos FROM $addr FETCH utxos PARALLEL",
        {
          "addr": "address:$address",
        },
      ),
    );
    if (res.isEmpty) return [];

    List utxosInAnswer = res["utxos"];
    List<Utxo> responseUnsorted = [];
    for (var element in utxosInAnswer) {
      List<String> filteredAddresses = [];
      for (var address in element["addresses"]) {
        filteredAddresses.add(address.toString().replaceAll('address:', ''));
      }

      final blockInt = element["block"].toString().replaceAll('block:', ''),
          block = blockInt.isEmpty ? 0 : int.parse(blockInt);

      responseUnsorted.add(
        Utxo.fromJson(
          {
            "txid": element["txid"].toString(),
            "txpos": element["txpos"],
            "addresses": filteredAddresses,
            "block": block,
            "value": (element["value"] ?? 0) * getDecimalProduct().toInt(),
          },
        ),
      );
    }

    //filter minimumHeight
    responseUnsorted = responseUnsorted
        .where((element) => element.block >= minimumHeight)
        .toList();

    //sort
    responseUnsorted.sort(
      ascending
          ? ((a, b) => a.block.compareTo(b.block))
          : ((a, b) => b.block.compareTo(a.block)),
    );

    List<Utxo> responseSorted = [];
    for (var element in responseUnsorted) {
      responseSorted.add(element);
    }

    return responseSorted.toSet().toList(); //filters duplicates
  }

  Future<Map<String, int>> getBalanceForAddress(String address) async {
    var res = parseQueryResults(
      await surrealClient.query(
        r"SELECT confirmed_balance,unconfirmed_balance FROM $addr",
        {"addr": "address:$address"},
      ),
    );
    if (res["confirmed_balance"] != null) {
      return {
        "confirmed": int.tryParse(res["confirmed_balance"].toString()) ?? 0,
        "unconfirmed": int.tryParse(res["unconfirmed"].toString()) ?? 0,
      };
    }
    return {
      "confirmed": 0,
      "unconfirmed": 0,
    };
  }

  Future<Block?> getBlockByHeight(int height) async {
    try {
      var res = parseQueryResults(
        await surrealClient.query(
          "SELECT * FROM block:$height",
        ),
      );
      if (res.isNotEmpty) {
        return Block(
          height: height,
          hash: res["hash"],
        );
      }
    } catch (e) {
      _logger.e(e.toString());
    }
    return null;
  }

  Future<String> getBlockHash(int height) async {
    try {
      var res = parseQueryResults(
        await surrealClient.query(
          "SELECT hash FROM block:$height",
        ),
      );
      if (res.isNotEmpty) {
        return res["hash"];
      }
    } catch (e) {
      _logger.e(e.toString());
    }
    return '';
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

  Future<bool> getIsAddressKnown(String address) async {
    var res = parseQueryResults(
      await surrealClient.query(
        r"SELECT id FROM $addr",
        {"addr": "address:$address"},
      ),
    );

    if (res.containsKey('id')) {
      return true;
    }
    return false;
  }

  Future<int> getNumberOfAddressesThatNeedUpdating() async {
    try {
      final res = parseQueryResults(await surrealClient.query(
          'SELECT count() FROM address WHERE needs_update = true GROUP BY count;'));
      return res["count"];
    } catch (e) {
      _logger.e(e.toString());
    }
    return 0;
  }

  Future<void> init([bool fromIsolate = false]) async {
    //open db connection
    _logger.i(fromIsolate
        ? 'Isolate - Connecting to SurrealDB...'
        : 'Connecting to SurrealDB...');
    surrealClient = SurrealDB(
      '${env["SURREAL_HOST"]}:${env["SURREAL_PORT"]}/rpc',
      options: SurrealDBOptions(
        timeoutDuration: Duration(days: 7),
      ),
    );
    try {
      surrealClient.connect();
    } catch (e) {
      _logger.e(e.toString());
      await init(fromIsolate);
    }
    await surrealClient.wait();
    await surrealClient.use('marisma', 'utxos');
    await surrealClient.signin(
      user: env["SURREAL_USER"]!,
      pass: env["SURREAL_PASS"]!,
    );
    await checkSchemas();
    _logger.i(fromIsolate
        ? 'Isolate - Connected to SurrealDB'
        : 'Connected to SurrealDB');
  }

  Future<void> initBlockHashWatcher() async {
    final blockStream = await liveTableStream('block');
    blockStream.listen(
      (_) async {
        final currentHeight = await getHeightInSurrealDB();
        final latestBlock = await getBlockByHeight(currentHeight);
        if (latestBlock != null) {
          _blockHashStreamController.add(
            BlockHashStreamReply()
              ..height = latestBlock.height
              ..hash = latestBlock.hash,
          );
        }
      },
    );
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

  Future<void> performSurrealReorg(int height) async {
    try {
      await surrealClient.query(
        '''
        BEGIN TRANSACTION;
        DELETE FROM utxo WHERE block.height >= $height; 
        DELETE FROM block WHERE height >= $height; 
        UPDATE blockchain:height SET height = ${height - 1};
        COMMIT TRANSACTION;
        ''',
      );
    } catch (e) {
      _logger.e(e.toString());
    }
  }
}
