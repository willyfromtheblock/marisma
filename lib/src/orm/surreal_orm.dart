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
    _logger.d('Checking schemas');
    try {
      if (await getHeightInSurrealDB() == 0) {
        _logger.i('Writing schemas');
        //empty db, create schemas
        final dbRes = await _surrealClient.query(surrealSchema);
        if (checkForErrorStatus(dbRes) == true) {
          throw Exception(dbRes);
        }
      }
    } catch (e) {
      _logger.e('Failed to write schema');
      _logger.e(e.toString());
      exit(1);
    }
  }

  Future<void> createAddress(AddressModel addr, String txId) async {
    //create new address
    try {
      final dbRes = await _surrealClient.query(r'INSERT INTO address $addr', {
        "addr": addr.toJson(),
      });
      if (checkForErrorStatus(dbRes) == true) {
        throw Exception(dbRes);
      }
    } catch (e) {
      _logger.e('Failed to create address');
      _logger.e(e.toString());
      exit(1);
    }
  }

  Future<void> createBlock(Block block) async {
    try {
      await _surrealClient.create(
        "block:${block.height}",
        block,
      );
    } catch (e) {
      _logger.e('Failed to create block ${block.height}');
      _logger.e(e.toString());
      // no exit(1) here or exception will be thrown sinc this is possible after a restart
    }
  }

  Future<void> updateBlockHeight(int nOfNewBlocks) async {
    try {
      await _surrealClient.query(
        r"UPDATE blockchain:height SET height += $nOfNewBlocks",
        {"nOfNewBlocks": nOfNewBlocks},
      );
    } catch (e) {
      _logger.e('Failed to update block height');
      _logger.e(e.toString());
    }
  }

  Future<void> createOrUpdateUtxo({
    required Utxo utxo,
    bool retried = false,
  }) async {
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
          await Future.delayed(Duration(seconds: 1));
          await createOrUpdateUtxo(
            utxo: utxo,
            retried: true,
          );
        } else {
          throw Exception(dbRes);
        }
      } else {
        _logger.d('Created or updated UTXO $utxoId');
      }
    } catch (e) {
      _logger.e('Failed to create or update UTXO after retrying');
      _logger.e(e.toString());
      exit(1);
    }
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

  Future<void> computeUpdateAddress(String address) async {
    try {
      final dbRes = await _surrealClient.query(
        r"fn::update_address($addr)",
        {
          "addr": "address:$address",
        },
      );
      if (checkForErrorStatus(dbRes) == true) {
        throw Exception(dbRes);
      }
    } catch (e) {
      _logger.e('Failed to compute update address');
      _logger.e(e.toString());
      exit(1);
    }
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
        ? r"SELECT * FROM utxo WHERE address = $addr AND spent_on_block != 'block:-2' AND block != 'block:-1'" //fetches utxo history
        : r"SELECT * FROM utxo WHERE address = $addr AND spent_on_block = 'block:-2'"; //fetches unspent utxos (-2)

    if (minimumHeight == -1) {
      //fetches unspent (-2) or spend in mempool (-1) - minimumHeight is discarded
      queryString =
          r"SELECT * FROM utxo WHERE address = $addr AND (spent_on_block = 'block:-2' OR block = 'block:-1')";
    }

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

    //filter minimumHeight
    if (minimumHeight > 0) {
      responseList = responseList.where((element) {
        return element.block >= minimumHeight;
      }).toList();
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
          time: res["time"],
        );
      }
    } catch (e) {
      _logger.e('getBlockByHeight failed');
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
      _logger.e('getBlockHash failed');
      _logger.e(e.toString());
    }
    return '';
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

  Future<void> init({bool fromIsolate = false}) async {
    //open db connection
    _logger.d(fromIsolate
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
      _logger.e('Failed to connect to SurrealDB');
      _logger.e(e.toString());
      await init(fromIsolate: fromIsolate);
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

    if (fromIsolate == false) {
      await checkSchemas();
    }
    _logger.d(fromIsolate
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
    if (result == []) return {};

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
        DELETE FROM utxo_spent_before_write WHERE spent_on_block.height >= $height;
        DELETE FROM block WHERE height >= $height; 
        UPDATE blockchain:height SET height = $heightMinusOne;
        FOR $utxo IN (SELECT VALUE id FROM utxo WHERE spent_on_block >= $heightAsString) {
        UPDATE $utxo SET spent_on_block = block:-2;
        };
        FOR $utxo_to_delete IN (SELECT VALUE id FROM utxo WHERE block.height >= $height) {
        DELETE $utxo_to_delete;
        };
        COMMIT TRANSACTION;
        ''';
      final res = await _surrealClient.query(
        queryString,
        {
          "height": height,
          "heightAsString": "block:$height",
          "heightMinusOne": height - 1,
        },
      );

      if (checkForErrorStatus(res) == true) {
        throw Exception(res);
      }
    } catch (e) {
      if (e is TimeoutException) {
        _logger.e(e);
        _logger.i('Waiting for reorg to complete');
        _logger.i('Height in db: ${await getHeightInSurrealDB()}');
        _logger.i('Height for reorg: $height');
        while (await getHeightInSurrealDB() >= height) {
          await Future.delayed(Duration(seconds: 5));
        }
        return;
      }
      _logger.e('Failed to perform reorg');
      _logger.e(e.toString());
      exit(1);
    }
  }

  Future<void> spendUtxo({
    required String utxoId,
    required int blockHeight,
  }) async {
    try {
      final dbRes = await _surrealClient.query(
        r"fn::spend_utxo($utxoId, $blockHeight)",
        {
          "utxoId": "utxo:$utxoId",
          "blockHeight": blockHeight,
        },
      );
      if (checkForErrorStatus(dbRes) == true) {
        throw Exception(dbRes);
      }
    } catch (e) {
      _logger.e('Failed to spend UTXO');
      _logger.e(e.toString());
      exit(1);
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
      _logger.e('Failed to updateAddress');
      _logger.e(e.toString());
      exit(1);
    }
  }

  Future<void> computeMergeUtxos() async {
    try {
      final dbRes = await _surrealClient.query(
        r"fn::merge_utxos()",
      );

      if (checkForErrorStatus(dbRes) == true) {
        throw Exception(dbRes);
      }
    } catch (e) {
      _logger.e('Failed to compute merge utxos');
      _logger.e(e.toString());
    }
  }

  Future<void> triggerAddressUpdate(String address) async {
    try {
      final dbRes = await _surrealClient.query(
        r"fn::update_address($addr)",
        {
          "addr": "address:$address",
        },
      );
      if (checkForErrorStatus(dbRes) == true) {
        throw Exception(dbRes);
      }
    } catch (e) {
      _logger.e('Failed to trigger address update');
      _logger.e(e.toString());
    }
  }

  Future<void> triggerInitialSyncCompleted() async {
    try {
      final dbRes = await _surrealClient.query(
        surrealSchemaAfterInitialSync,
      );
      if (checkForErrorStatus(dbRes) == true) {
        throw Exception(dbRes);
      }
    } catch (e) {
      _logger.e('Failed to triggerInitialSyncCompleted');
      _logger.e(e.toString());
      exit(1);
    }

    try {
      await _surrealClient.query(
        surrealSchemaTriggerInitialAddressSync,
      );
    } catch (e) {
      if (e is TimeoutException) {
        while (await checkInitialSyncCompleted() == false) {
          await Future.delayed(Duration(seconds: 5));
        }
        return;
      }
      _logger.e('Failed to trigger initial address sync');
      exit(1);
    }
  }

  Future<bool> checkInitialSyncCompleted() async {
    try {
      final res = parseQueryResults(await _surrealClient.query(
        r"SELECT initial_sync_complete FROM blockchain:initial_sync_complete",
      ));
      return res.isEmpty ? false : res["initial_sync_complete"];
    } catch (e) {
      _logger.e('Failed to check initial sync completed, ${e.toString()}');
      exit(1);
    }
  }
}
