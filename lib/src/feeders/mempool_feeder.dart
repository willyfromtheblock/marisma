import 'dart:async';
import 'dart:io';

import '../tools/logger.dart';

import '../http_wrapper/http_wrapper.dart';

Map<String, String> env = Platform.environment;
final _logger = LoggerWrapper().logger;
bool _parsingLocked = false;

Future<void> initMempoolFeeder() async {
  LoggerWrapper().init();
  HttpWrapper().init();
  _logger.i('Init mempool feeder');

  //start timer
  Timer.periodic(Duration(seconds: 5), (_) {
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
  _logger.i('parseMempool started');
  _parsingLocked = true;

  final mempool = await getMempool();

  for (var mempoolItem in mempool.entries) {
    //parse here
  }

  //unlock again
  _parsingLocked = false;
  _logger.i('parseMempool ended');
}
