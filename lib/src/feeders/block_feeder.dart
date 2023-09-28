import 'dart:async';
import 'dart:io';

import 'package:marisma/src/parsers/coin_parser.dart';
import 'package:marisma/src/parsers/peercoin_parser.dart';

import '../http_wrapper/http_wrapper.dart';
import '../orm/surreal_orm.dart';
import '../tools/logger.dart';

Map<String, String> env = Platform.environment;
Timer? _blockTimer;
late CoinParser _coinParser;
late int _heightInClient;
late int _heightInSurrealDB;
final _logger = LoggerWrapper().logger;
bool _parsingLocked = false;
bool _rpcConnected = false;
bool _sigtermReceived = false;

Future<bool> didChainReorg({
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
        await SurrealORM().getBlockHash(blockNumberToCheck);

    if (surrealDBHashAtReorgDepth != clientHashAtReorgDepth) {
      //drop utxos and history where block hash > reorg depth
      //reset blockheight
      _logger.w(
        'Chain reorg detected at $blockNumberToCheck, should be: $clientHashAtReorgDepth - is: $surrealDBHashAtReorgDepth,  cleaning up...',
      );

      await SurrealORM().performSurrealReorg(blockNumberToCheck);

      //chain reorg detected. resetting height.
      _heightInSurrealDB = await SurrealORM().getHeightInSurrealDB();
      return true;
    }
  }

  return false;
}

Future<void> initBlockFeeder() async {
  //init orm
  await SurrealORM().init();

  //init coinparser
  if (env['COIN_NAME'] == 'peercoin' || env['COIN_NAME'] == 'peercoinTestnet') {
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
    _heightInSurrealDB = await SurrealORM().getHeightInSurrealDB();
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
          _heightInSurrealDB = await SurrealORM().getHeightInSurrealDB();
        } catch (e) {
          _logger.e('error calling RPC: ${e.toString()}');
        }

        if (_heightInSurrealDB < _heightInClient && _parsingLocked == false) {
          _startBlockParser();
        }
      },
    );

    //intercept SIGTERM
    ProcessSignal.sigterm.watch().listen(
      (event) async {
        LoggerWrapper().logger.i('blockFeeder SIGTERM received');
        _sigtermReceived = true;
        _blockTimer!.cancel();

        while (_parsingLocked == true) {
          await Future.delayed(Duration(seconds: 1));
        }

        exit(1);
      },
    );
  }
}

void _startBlockParser() async {
  if (_parsingLocked == true) return;
  _logger.i(
    "Database: $_heightInSurrealDB, RPC Client: $_heightInClient, parsing in progress: $_parsingLocked",
  );

  while (_heightInSurrealDB < _heightInClient) {
    _parsingLocked = true;
    var currentBlockNumber = _heightInSurrealDB + 1;

    //check parsing protections
    if (currentBlockNumber <= _heightInClient &&
        await didChainReorg(blockNumber: currentBlockNumber, reorgDepth: 1) ==
            false &&
        await didChainReorg(blockNumber: currentBlockNumber, reorgDepth: 6) ==
            false &&
        await didChainReorg(blockNumber: currentBlockNumber, reorgDepth: 21) ==
            false) {
      List<Future<void>> futures = [];

      for (var i = 0; i < 10; i++) {
        //parse up to 10 blocks in parallel
        if (currentBlockNumber + i <= _heightInClient) {
          _logger.i(
            "parsing block ${currentBlockNumber + i} of $_heightInClient",
          );
          futures.add(_coinParser.parseBlock(currentBlockNumber + i));
        }
      }
      await Future.wait(futures);

      //update _heightInSurrealDB
      _heightInSurrealDB = await SurrealORM().getHeightInSurrealDB();
    }

    //stop parsing on SIGTERM
    if (_sigtermReceived == true) break;
  }

  //unlock again
  _parsingLocked = false;
}
