import 'dart:async';
import 'dart:io';

import 'package:marisma/src/parsers/coin_parser.dart';
import 'package:marisma/src/tools/write_orm_writeable.dart';
import 'package:synchronized/synchronized.dart';

import '../http_wrapper/http_wrapper.dart';
import '../orm/surreal_orm.dart';
import '../tools/logger.dart';

class BlockFeeder {
  Map<String, String> env = Platform.environment;
  Timer? _blockTimer;
  Timer? _mergeUtxoTimer;
  Timer? _progressTimer;
  late CoinParser _coinParser;
  late int _heightInClient;
  late int _heightInSurrealDB;
  final _logger = LoggerWrapper().logger;
  final _lock = Lock();
  final SurrealORM _surrealORM = SurrealORM();
  bool _rpcConnected = false;
  bool _sigtermReceived = false;
  String _lastLog = "";

  void _logCurrentStatus() {
    String currentLog =
        'Database: $_heightInSurrealDB, RPC Client: $_heightInClient, ${(_heightInSurrealDB / _heightInClient * 100).toStringAsFixed(2)}%, parsing in progress: ${_lock.inLock}';

    if (_lastLog != currentLog) {
      _logger.i(currentLog);
      _lastLog = currentLog;
    }
  }

  Future<void> initBlockFeeder() async {
    //init orm
    await _surrealORM.init();

    //init coinparser
    _coinParser = CoinParser.fromName(env['COIN_NAME']!);

    try {
      HttpWrapper().init();
      final chainInfo = await HttpWrapper().get(
        path: 'chaininfo.json',
        requestJson: true,
      );
      _heightInClient = chainInfo["blocks"];
      _rpcConnected = true;
      _logger.i(
        'connected to ${env['COIN_NAME']} RPC',
      );
    } catch (e) {
      _rpcConnected = false;
      _logger.e(
        'error connecting to RPC: ${e.toString()}',
      );
      if (_blockTimer != null) {
        _blockTimer!.cancel();
        _blockTimer = null;
      }
      await Future.delayed(
        Duration(seconds: 5),
        () async => await initBlockFeeder(),
      );
      return;
    }

    if (_rpcConnected) {
      _heightInSurrealDB = await _surrealORM.getHeightInSurrealDB();
      if (_heightInSurrealDB < _heightInClient) {
        _startBlockParser();
      }

      //start parse timer
      _blockTimer ??= Timer.periodic(
        Duration(seconds: 10),
        (_) async {
          try {
            final chainInfo = await HttpWrapper().get(
              path: 'chaininfo.json',
              requestJson: true,
            );
            _heightInClient = chainInfo["blocks"];
            _heightInSurrealDB = await _surrealORM.getHeightInSurrealDB();
          } catch (e) {
            _logger.e('error calling RPC: ${e.toString()}');
          }

          if (_heightInSurrealDB < _heightInClient && _lock.inLock == false) {
            _startBlockParser();
          }
        },
      );

      //start merge utxo timer
      _mergeUtxoTimer ??= Timer.periodic(
        Duration(minutes: 5),
        (_) async {
          _logger.d('merging utxos');
          await _lock.synchronized(() async {
            await _surrealORM.computeMergeUtxos();
          });
          _logger.d('done merging utxos');
        },
      );

      //start progress timer
      _progressTimer ??= Timer.periodic(
        Duration(minutes: 1),
        (_) async {
          _logCurrentStatus();

          if (await _surrealORM.checkInitialSyncCompleted() == false &&
              _heightInSurrealDB == _heightInClient) {
            _logger.i('Initial sync completed');
            await _surrealORM.triggerInitialSyncCompleted();
            _logger.i('Initial address write completed, unlocking parsing');
          }
        },
      );

      //intercept SIGTERM
      ProcessSignal.sigterm.watch().listen(
        (_) async {
          LoggerWrapper().logger.i('blockFeeder SIGTERM received');
          _sigtermReceived = true;
          _blockTimer!.cancel();
          _mergeUtxoTimer!.cancel();
          _progressTimer!.cancel();

          await _lock.synchronized(() async {
            exit(1);
          });
        },
      );
    }
  }

  Future<bool> _didChainReorg({
    required int blockNumber,
    int reorgDepth = 21,
  }) async {
    int blockNumberToCheck = blockNumber - reorgDepth;

    if (blockNumberToCheck > 0) {
      String clientHashAtReorgDepth = await HttpWrapper().get(
        path: 'blockhashbyheight/$blockNumberToCheck.hex',
        trimmed: true,
      );

      final surrealDBHashAtReorgDepth =
          await _surrealORM.getBlockHash(blockNumberToCheck);

      if (surrealDBHashAtReorgDepth != clientHashAtReorgDepth) {
        //drop utxos and history where block hash > reorg depth
        //reset blockheight
        _logger.w(
          'Chain reorg detected at $blockNumberToCheck, should be: $clientHashAtReorgDepth - is: $surrealDBHashAtReorgDepth,  cleaning up...',
        );

        await _surrealORM.performSurrealReorg(blockNumberToCheck);

        //chain reorg detected. resetting height.
        _heightInSurrealDB = await _surrealORM.getHeightInSurrealDB();
        return true;
      }
    }

    return false;
  }

  void _startBlockParser() async {
    await _lock.synchronized(() async {
      _logCurrentStatus();

      await _surrealORM.computeMergeUtxos();

      while (_heightInSurrealDB < _heightInClient) {
        var currentBlockNumber = _heightInSurrealDB + 1;

        //check parsing protections
        if (currentBlockNumber <= _heightInClient &&
            await _didChainReorg(
                    blockNumber: currentBlockNumber, reorgDepth: 1) ==
                false &&
            await _didChainReorg(
                    blockNumber: currentBlockNumber, reorgDepth: 6) ==
                false &&
            await _didChainReorg(
                    blockNumber: currentBlockNumber, reorgDepth: 21) ==
                false) {
          List<Future<void>> futures = [];
          int parsedBlocks = 0;

          for (var i = 0; i < 15; i++) {
            //parse up to 15 blocks in parallel
            if (currentBlockNumber + i <= _heightInClient) {
              parsedBlocks++;

              futures.add(_coinParser.parseBlock(currentBlockNumber + i).then(
                (parsed) async {
                  await writeOrmWriteable(_surrealORM, parsed);
                  await _surrealORM.createBlock(parsed.block);
                },
              ));
            }
          }

          try {
            await Future.wait(futures);
          } catch (e) {
            _logger.e('error parsing blocks: ${e.toString()}');
            rethrow;
          }

          //update _heightInSurrealDB if everything went normally
          await _surrealORM.updateBlockHeight(parsedBlocks);
          _heightInSurrealDB = await _surrealORM.getHeightInSurrealDB();
        }

        //stop parsing on SIGTERM
        if (_sigtermReceived == true) break;
      }
    });
  }
}
