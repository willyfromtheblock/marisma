import 'dart:async';
import 'dart:io';

import 'package:marisma/src/parsers/peercoin_parser.dart';

import '../http_wrapper/http_wrapper.dart';
import '../orm/isar_orm.dart';
import '../tools/logger.dart';

Map<String, String> env = Platform.environment;
Timer? _blockTimer;
late int _heightInClient;
late int _heightInIsar;
late IsarORM _isarORM;
final _logger = LoggerWrapper().logger;
bool _parsingLocked = false;
bool _rpcConnected = false;
bool _sigtermReceived = false;

Future<bool> didChainReorg(int currentBlockNumber) async {
  int reorgDepth = env.containsKey('REORG_DEPTH')
      ? int.parse(env['REORG_DEPTH']!)
      : 21; //TODO make argument
  int blockNumberToCheck = currentBlockNumber - reorgDepth;

  if (blockNumberToCheck > 0) {
    String clientHashAtReorgDepth = await HttpWrapper().get(
      path: 'blockhashbyheight/$blockNumberToCheck.hex',
      trimmed: true,
    );

    final isarHashAtReorgDepth =
        await _isarORM.getBlockHash(blockNumberToCheck);

    if (isarHashAtReorgDepth != clientHashAtReorgDepth) {
      //drop utxos and history where block hash > reorg depth
      //reset blockheight
      _logger.w(
        'Chain reorg detected at $blockNumberToCheck, should be: $clientHashAtReorgDepth - is: $isarHashAtReorgDepth,  cleaning up...',
      );
      await _isarORM.performIsarReorg(blockNumberToCheck);

      //chain reorg detected. Quitting.
      exit(2);
    }
  }

  return false;
}

Future<void> initBlockFeeder() async {
  _isarORM = IsarORM();
  //init orm
  await IsarORM().init();

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
    _heightInIsar = await _isarORM.getHeightInIsar();
    if (_heightInIsar < _heightInClient) {
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
          _heightInIsar = await _isarORM.getHeightInIsar();
        } catch (e) {
          _logger.e('error calling RPC: ${e.toString()}');
        }

        _logger.i(
          "Database: $_heightInIsar, RPC Client: $_heightInClient, parsing in progress: $_parsingLocked",
        );

        if (_heightInIsar < _heightInClient && _parsingLocked == false) {
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
  _logger.d(
    'starting at block $_heightInIsar, height in client: $_heightInClient, lock: $_parsingLocked',
  );

  while (_heightInIsar < _heightInClient) {
    _parsingLocked = true;
    var currentBlockNumber = _heightInIsar + 1;

    //check parsing protections
    if (currentBlockNumber < _heightInClient ||
        await didChainReorg(currentBlockNumber) == false) {
      List<Future<void>> futures = [];

      for (var i = 0; i < 15; i++) {
        //parse up to 15 blocks in parallel
        if (currentBlockNumber + i <= _heightInClient) {
          _logger.d(
            "current block ${currentBlockNumber + i} of $_heightInClient",
          );
          futures.add(PeercoinParser().parseBlock(currentBlockNumber + i));
        }
      }
      await Future.wait(futures);

      //update _heightInIsar
      _heightInIsar = await _isarORM.getHeightInIsar();
    }

    //stop parsing on SIGTERM
    if (_sigtermReceived == true) break;
  }

  //unlock again
  _parsingLocked = false;
}
