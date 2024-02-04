import 'dart:async';
import 'dart:io';

import 'package:marisma/src/parsers/coin_parser.dart';
import 'package:marisma/src/parsers/peercoin_parser.dart';

import '../http_wrapper/http_wrapper.dart';
import '../orm/surreal_orm.dart';
import '../tools/logger.dart';

class BlockFeeder {
  Map<String, String> env = Platform.environment;
  Timer? _blockTimer;
  Timer? _mergeUtxoTimer;
  late CoinParser _coinParser;
  late int _heightInClient;
  late int _heightInSurrealDB;
  final _logger = LoggerWrapper().logger;
  final SurrealORM _surrealORM = SurrealORM();
  bool _parsingLocked = false;
  bool _rpcConnected = false;
  bool _sigtermReceived = false;
  bool _utxoMergingInProgress = false;

  Future<void> initBlockFeeder() async {
    //init orm
    await _surrealORM.init();

    //init coinparser
    if (env['COIN_NAME'] == 'peercoin' ||
        env['COIN_NAME'] == 'peercoinTestnet') {
      _coinParser = PeercoinParser();
    }

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

          if (_heightInSurrealDB < _heightInClient && _parsingLocked == false) {
            _startBlockParser();
          }
        },
      );
      //start merge utxo timer
      _mergeUtxoTimer ??= Timer.periodic(
        Duration(minutes: 5),
        (_) async {
          _logger.d('merging utxos');
          _utxoMergingInProgress = true;
          await _surrealORM.computeMergeUtxos();

          _utxoMergingInProgress = false;
          _logger.d('done merging utxos');
        },
      );

      //intercept SIGTERM
      ProcessSignal.sigterm.watch().listen(
        (_) async {
          LoggerWrapper().logger.i('blockFeeder SIGTERM received');
          _sigtermReceived = true;
          _blockTimer!.cancel();
          _mergeUtxoTimer!.cancel();

          while (_parsingLocked == true) {
            await Future.delayed(Duration(seconds: 1));
          }

          exit(1);
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
    if (_parsingLocked == true) return;
    _logger.i(
      "Database: $_heightInSurrealDB, RPC Client: $_heightInClient, parsing in progress: $_parsingLocked",
    );

    while (_heightInSurrealDB < _heightInClient) {
      _parsingLocked = true;
      var currentBlockNumber = _heightInSurrealDB + 1;

      //check _utxoMergingInProgress
      while (_utxoMergingInProgress == true) {
        _logger.i('utxo merging in progress, waiting...');
        await Future.delayed(Duration(seconds: 5));
      }

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
        //parse up to 15 blocks in parallel
        List<Future<void>> parseBlockFutures = [];

        for (int i = 0; i < 15; i++) {
          int blockToParse = currentBlockNumber + i;
          //stop parsing if we reached the client height
          if (blockToParse > _heightInClient) {
            return;
          }

          _logger.i(
            "parsing block $blockToParse of $_heightInClient",
          );
          await _coinParser.parseBlock(blockToParse);
        }

        await Future.wait(parseBlockFutures);

        //update _heightInSurrealDB
        _heightInSurrealDB = await _surrealORM.getHeightInSurrealDB();
      }

      //stop parsing on SIGTERM
      if (_sigtermReceived == true) break;
    }

    //unlock again
    _parsingLocked = false;
  }
}
