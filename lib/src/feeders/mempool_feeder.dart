import 'dart:async';
import 'dart:io';

import '../tools/logger.dart';

import '../http_wrapper/http_wrapper.dart';

Map<String, String> env = Platform.environment;
final _logger = LoggerWrapper().logger;
bool _parsingLocked = false;
late Timer _mempoolTimer;

Future<void> initMempoolFeeder() async {
  LoggerWrapper().init();
  _logger.i('Init mempool feeder');
  HttpWrapper().init();

  //intercept SIGTERM
  ProcessSignal.sigterm.watch().listen(
    (event) async {
      LoggerWrapper().logger.i('mempool SIGTERM received');
      _mempoolTimer.cancel();
    },
  );

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
    _logger.e('parseMempool ${e.toString()}');
  }
  return {};
}

void parseMempool() async {
  if (_parsingLocked == true) return;
  //lock parsing
  _logger.d('parseMempool started');
  _parsingLocked = true;

  final mempool = await getMempool();

  for (var mempoolItem in mempool.entries) {
    //TODO
  }

  //unlock again
  _parsingLocked = false;
  _logger.d('parseMempool ended');
}
