import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:grpc/grpc.dart';
import 'package:marisma/src/orm/surreal_schema.dart';
import 'package:surrealdb/surrealdb.dart';

import '../generated/marisma.pb.dart';
import '../models/address.dart';
import '../models/block.dart';
import '../models/utxo.dart';
import '../tools/logger.dart';

class SurrealORM {
  static final Map<String, SurrealORM> _cache = <String, SurrealORM>{};
  late SurrealDB _surrealClient;
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
      //yield current status
      addressStatusStreamController.add(
        AddressStatusStreamReply()
          ..status = await getAddressStatus(address)
          ..address = address,
      );

      //start live query
      final addrId = "address:$address";
      final liveQuery = await _surrealClient.liveQuery(
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

  bool checkForErrorStatus(Object? res) {
    if (res == null) return true; //intercept null

    if (res.runtimeType == Map) {
      return false;
    }

    if (res.runtimeType == List) {
      final asList = res as List;
      if (asList.isNotEmpty) {
        //intercept status: ERR
        final resMap = res[0] as Map;
        if (resMap.containsKey('status') && resMap['status'] == 'ERR') {
          return true;
        }
      }
    }
    return false;
  }

  Future<void> checkSchemas() async {
    try {
      if (await getHeightInSurrealDB() == 0) {
        //empty db, create schemas
        await _surrealClient.query(surrealSchema);
      }
    } catch (e) {
      _logger.e(e.toString());
    }
  }

  Future<void> computeUpdateAddress(String address) async {
    try {
      await _surrealClient.query(
        r"fn::update_address($addr)",
        {
          "addr": "address:$address",
        },
      );
    } catch (e) {
      _logger.e(e.toString());
    }
  }

  Future<void> createAddress(AddressModel addr, String txId) async {
    //create new address
    try {
      final dbRes = await _surrealClient.query(r'INSERT INTO address $addr', {
        "addr": addr.toJson(),
      });
      if (checkForErrorStatus(dbRes) == true) {
        _logger.e(addr.toJson());
        _logger.e(dbRes);
        throw Exception('Failed to create address');
      }
    } catch (e) {
      _logger.e(e.toString());
    }
  }

  Future<void> createBlock(Block block) async {
    try {
      await _surrealClient.query(
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

  Future<void> createOrUpdateUtxo(Utxo utxo, [bool retried = false]) async {
    final utxoId = "utxo:${utxo.txid}${utxo.txpos}";
    try {
      final dbRes = await _surrealClient.query(
        r"INSERT INTO utxo $utxo ON DUPLICATE KEY UPDATE spent_on_block = $spent_on_block, block = $block;",
        {
          "utxo": utxo.toJson(),
          "spent_on_block": "block:${utxo.spentOnBlock}",
          "block": "block:${utxo.block}",
        },
      );

      //intercept status: ERR and retry once
      if (checkForErrorStatus(dbRes) == true) {
        if (retried == false) {
          //retry
          _logger.w(
            'Failed to create or update UTXO $utxoId, retrying...',
          );
          await Future.delayed(Duration(milliseconds: 100));
          await createOrUpdateUtxo(utxo, true);
        } else {
          throw Exception(
            'Failed to create or update UTXO $utxoId after retrying',
          );
        }
      } else {
        _logger.d('Created or updated UTXO $utxoId');
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  /// Limited to 1000 addresses
  Future<List<AddressModel>> getAddressesThatNeedUpdating() async {
    try {
      final res = await _surrealClient.query(
        'SELECT * FROM address WHERE needs_update = true LIMIT 1000;',
      );
      final data = res as List;
      final answer = <AddressModel>[];

      for (Map resultData in data[0]['result']) {
        answer.add(AddressModel.fromJson(resultData));
      }
      return answer;
    } catch (e) {
      _logger.e(e.toString());
    }
    return [];
  }

  Future<int> getAddressNumberOfUtxos(
    String address,
  ) async {
    try {
      final res = parseQueryResults(
        await _surrealClient.query(r"SELECT number_of_utxos FROM $addr", {
          "addr": "address:$address",
        }),
      );

      return res["number_of_utxos"];
    } catch (e) {
      _logger.e(e.toString());
      throw GrpcError.unavailable('Failed to get number of UTXOs');
    }
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
    for (final utxo in res) {
      utxoStrings.add(
        jsonEncode(
          utxo.toGRPCReplyJson(),
        ),
      );
    }

    return utxoStrings;
  }

  Future<String> getAddressStatus(String address) async {
    try {
      final res = parseQueryResults(
        await _surrealClient.query(
          r"SELECT status FROM $addr",
          {"addr": "address:$address"},
        ),
      );

      if (res.containsKey('status')) {
        return res['status'];
      }
      return '';
    } catch (e) {
      _logger.e(e.toString());
      throw GrpcError.unavailable('Failed to get address status');
    }
  }

  Future<List<String>> getAddressUtxoHistory({
    required String address,
    int minimumHeight = 0,
    bool ascending = false,
  }) async {
    final res = await getAddressUtxos(
      address: address,
      minimumHeight: minimumHeight,
      ascending: ascending,
      historyOnly: true,
    );

    List<String> utxoStrings = [];
    for (final utxo in res) {
      utxoStrings.add(
        jsonEncode(
          utxo.toGRPCReplyJson(),
        ),
      );
    }

    return utxoStrings;
  }

  Future<List<Utxo>> getAddressUtxos({
    required String address,
    int minimumHeight = 0,
    bool ascending = false,
    bool historyOnly = false,
  }) async {
    String queryString = historyOnly
        ? r"SELECT * from utxo WHERE address = $addr AND (spent_on_block.height >= 0 AND block.height >= $minimumHeight)" //fetches utxo history
        : r"SELECT * from utxo WHERE address = $addr AND (spent_on_block = 'block:-2' AND block.height >= $minimumHeight)"; //fetches unspent utxos (-2) TODO does not work with mempool

    if (ascending == true) {
      queryString += " ORDER BY block.height ASC";
    } else {
      queryString += " ORDER BY block.height DESC";
    }

    final res = await _surrealClient.query(
      queryString,
      {
        "addr": "address:$address",
        "minimumHeight": minimumHeight,
      },
    ) as List;

    if (res.isEmpty) return [];

    List<Utxo> responseList = [];

    for (final element in res[0]['result']) {
      responseList.add(
        Utxo.fromJson(
          element,
        ),
      );
    }

    return responseList.toSet().toList(); //filters duplicates
  }

  Future<Map<String, int>> getBalanceForAddress(String address) async {
    final res = parseQueryResults(
      await _surrealClient.query(
        r"SELECT confirmed_balance,unconfirmed_balance FROM $addr",
        {"addr": "address:$address"},
      ),
    );
    if (res.containsKey('confirmed_balance') &&
        res.containsKey('unconfirmed_balance')) {
      return {
        "confirmed": int.tryParse(res["confirmed_balance"].toString()) ?? 0,
        "unconfirmed": int.tryParse(res["unconfirmed_balance"].toString()) ?? 0,
      };
    }
    return {
      "confirmed": 0,
      "unconfirmed": 0,
    };
  }

  Future<Block?> getBlockByHeight(int height) async {
    try {
      final res = parseQueryResults(
        await _surrealClient.query(
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
      final res = parseQueryResults(
        await _surrealClient.query(
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

  Future<bool> getDBHasAddressesThatNeedUpdating() async {
    try {
      final res = parseQueryResults(
        await _surrealClient.query(
          'SELECT count() FROM address WHERE needs_update = true LIMIT 1;',
        ),
      );
      if (res.isNotEmpty) return true;
    } catch (e) {
      _logger.e(e.toString());
      rethrow;
    }
    return false;
  }

  Future<int> getHeightInSurrealDB() async {
    if (env.containsKey('STARTING_POINT')) {
      return int.parse(env['STARTING_POINT']!);
    }
    final res = parseQueryResults(
      await _surrealClient.query("SELECT * FROM blockchain:height"),
    );
    return res.isEmpty ? 0 : res["height"];
  }

  Future<bool> getIsAddressKnown(String address) async {
    try {
      final res = parseQueryResults(
        await _surrealClient.query(
          r"SELECT id FROM $addr",
          {"addr": "address:$address"},
        ),
      );

      if (res.containsKey('id')) {
        return true;
      }
      return false;
    } catch (e) {
      _logger.e(e.toString());
      throw GrpcError.unavailable('Failed to check if address is known');
    }
  }

  Future<void> init([bool fromIsolate = false]) async {
    //open db connection
    _logger.i(fromIsolate
        ? 'Isolate - Connecting to SurrealDB...'
        : 'Connecting to SurrealDB...');
    _surrealClient = SurrealDB(
      '${env["SURREAL_HOST"]}:${env["SURREAL_PORT"]}/rpc',
      options: SurrealDBOptions(
        timeoutDuration: Duration(
          minutes: 1,
        ),
      ),
    );
    try {
      _surrealClient.connect();
    } catch (e) {
      _logger.e(e.toString());
      await init(fromIsolate);
    }
    await _surrealClient.wait();
    await _surrealClient.use(
      env['SURREAL_NAME_SPACE']!,
      env['SURREAL_DB_NAME']!,
    );
    await _surrealClient.signin(
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

  Future<Stream> liveTableStream(String table) async {
    _logger.d('liveTableStream requested: $table');

    final liveTable = await _surrealClient.liveTable(table);

    return liveTable.stream;
  }

  Map parseQueryResults(Object? result) {
    final asList = result as List;
    if (asList[0] != null) {
      final asMap = asList[0] as Map;
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
      final queryString = r'''
        BEGIN TRANSACTION;
        DELETE FROM utxo WHERE block.height >= $height; 
        DELETE FROM utxo_spent_before_write WHERE spent_on_block.height >= $height;
        DELETE FROM block WHERE height >= $height; 
        UPDATE blockchain:height SET height = $heightMinusOne;
        FOR $utxo IN (SELECT VALUE id FROM utxo WHERE spent_on_block >= $heightAsString) {
        UPDATE $utxo SET spent_on_block = block:-2;
        };
        COMMIT TRANSACTION;
        ''';
      await _surrealClient.query(
        queryString,
        {
          "height": height,
          "heightAsString": "block:$height",
          "heightMinusOne": height - 1,
        },
      );
    } catch (e) {
      _logger.e(e.toString());
    }
  }

  Future<void> spendUtxo({
    required String utxoId,
    required int blockHeight,
  }) async {
    try {
      _logger.d('Spending UTXO utxo:$utxoId');
      //check if utxo exists
      final res = parseQueryResults(
        await _surrealClient.query(
          "SELECT * from utxo:$utxoId",
        ),
      );

      if (res.isNotEmpty) {
        final utxo = Utxo.fromJson(res);

        if (utxo.block == -1) {
          // -1 = was unconfirmed, now confirmed
          utxo.block = blockHeight;
        }
        if (utxo.spentOnBlock == -2) {
          // -2 = was unspent, now spent
          utxo.spentOnBlock = blockHeight;
        }

        //update utxo
        await createOrUpdateUtxo(utxo);
      } else {
        //utxo not found but spending already requested -> write to separate table, surreal will handle merging
        await _surrealClient.create('utxo_spent_before_write', {
          "utxoId": 'utxo:$utxoId',
          "spent_on_block": 'block:$blockHeight',
        });
      }
    } catch (e) {
      _logger.e(e.toString());
      throw Exception('Failed to spend UTXO');
    }
  }

  Future<void> updateAddress(AddressModel addr) async {
    _logger.d("updating ${addr.address} with status ${addr.status}");
    try {
      await _surrealClient.update(
        "address:${addr.address}",
        addr,
      );
    } catch (e) {
      _logger.e(e.toString());
    }
  }

  Future<void> computeMergeUtxos() async {
    try {
      await _surrealClient.query(
        r"fn::merge_utxos()",
      );
    } catch (e) {
      _logger.e(e.toString());
    }
  }
}
