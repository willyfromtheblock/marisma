import 'dart:async';
import 'dart:io';

import '../orm/isar_orm.dart';
import '../tools/height_in_rest.dart';
import '../tools/logger.dart';

import '../http_wrapper/http_wrapper.dart';

Map<String, String> env = Platform.environment;
final _logger = LoggerWrapper().logger;
bool _parsingLocked = false;
late Timer _mempoolTimer;
late IsarORM _isarORM;

Future<void> initMempoolFeeder() async {
  LoggerWrapper().init();
  _logger.i('Init mempoolIsolate');
  HttpWrapper().init();
  _isarORM = IsarORM();
  //init orm
  await IsarORM().init();

  //intercept SIGTERM
  ProcessSignal.sigterm.watch().listen(
    (event) async {
      LoggerWrapper().logger.i('mempoolIsolate SIGTERM received');
      _mempoolTimer.cancel();
    },
  );

  while (await _isarORM.getHeightInIsar() < await heightInRest()) {
    //wait for sync
    _logger.i(
      'mempoolIsolate waiting for sync to be done. Ignoring updates...',
    );
    await Future.delayed(Duration(seconds: 30)); //TODO too long...
  }

  //start timer
  _mempoolTimer = Timer.periodic(Duration(seconds: 5), (_) {
    parseMempool();
  });
}

Future<Map> getMempool() async {
  try {
    final res = await HttpWrapper().get(
      path: "mempool/contents.json",
      requestJson: true,
    );
    return res;
  } catch (e) {
    _logger.e('mempoolIsolate ${e.toString()}');
  }
  return {};
}

void parseMempool() async {
  if (_parsingLocked == true) return;
  //lock parsing
  _logger.d('mempoolIsolate parseMempool started');
  _parsingLocked = true;

  final mempool = await getMempool();

  for (var mempoolItem in mempool.entries) {
    _logger.d(mempoolItem.key);
    await getTransaction(mempoolItem.key);
    //TODO
  }

  //unlock again
  _parsingLocked = false;
  _logger.d('mempoolIsolate parseMempool ended');
}

Future<Map> getTransaction(String hash) async {
  final tx = await HttpWrapper().get(
    path: 'tx/$hash.json',
    requestJson: true,
  );
  print(tx);
  return tx;
}

//TODO how to cache tx in mempool? ask in database isKnown every 5 seconds? 
//cache locally ? how do we now a new block is there to flush cache
//how to extract parseTX from block feeder?