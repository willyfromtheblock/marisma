import 'dart:async';
import 'dart:io';

import '../orm/surreal_orm.dart';
import '../parsers/coin_parser.dart';
import '../parsers/peercoin_parser.dart';
import '../tools/height_in_rest.dart';
import '../tools/logger.dart';

import '../http_wrapper/http_wrapper.dart';

Map<String, String> env = Platform.environment;
final _logger = LoggerWrapper().logger;
final SurrealORM _surrealORM = SurrealORM();
bool _parsingLocked = false;
List<String> _knownMempoolTransactions = [];
int _latestBlock = 0;
late Timer _mempoolTimer;
late CoinParser _coinParser;

Future<void> initMempoolFeeder() async {
  LoggerWrapper().init();
  _logger.i('Init mempoolIsolate');
  HttpWrapper().init();

  //init orm
  await _surrealORM.init();

  //init coinparser
  if (env['COIN_NAME'] == 'peercoin' || env['COIN_NAME'] == 'peercoinTestnet') {
    _coinParser = PeercoinParser();
  }

  _latestBlock = await _surrealORM.getHeightInSurrealDB();

  while (await _surrealORM.getHeightInSurrealDB() < await heightInRest() ||
      await _surrealORM.getDBHasAddressesThatNeedUpdating() == true) {
    //wait for sync
    _logger.d(
      'mempoolIsolate waiting for sync to be done. Ignoring updates...',
    );
    await Future.delayed(Duration(seconds: 10));
  }

  _logger.i('mempoolIsolate started watching mempool');

  //start timer
  _mempoolTimer = Timer.periodic(Duration(seconds: 5), (_) {
    parseMempool();
  });

  //intercept SIGTERM
  ProcessSignal.sigterm.watch().listen(
    (_) async {
      LoggerWrapper().logger.i('mempoolIsolate SIGTERM received');
      _mempoolTimer.cancel();
    },
  );
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

  //check if knownMempoolTransactions should be purged
  final heightInSurrealDb = await _surrealORM.getHeightInSurrealDB();
  if (heightInSurrealDb > _latestBlock) {
    //new block
    _logger.d('mempoolIsolate parseMempool _knownMempoolTransactions flushed');
    _knownMempoolTransactions =
        []; //TODO if mempool is not emptied completely (mempool > max block size), cache is flushed anyway
    _latestBlock = heightInSurrealDb;
  }

  //load mempool
  final mempool = await getMempool();

  for (var mempoolItem in mempool.entries) {
    final txId = mempoolItem.key;
    if (!_knownMempoolTransactions.contains(txId)) {
      _logger.d('mempoolIsolate parseMempool parsing $txId');

      final txInRest = await getTransaction(mempoolItem.key);

      await _coinParser.parseTx(
        txInRest,
        -1,
      ); //-2 = unspent, -1 = spent in mempool, 0+ = spent on block

      //add to cache
      _knownMempoolTransactions.add(txId);
    } else {
      _logger.d('mempoolIsolate parseMempool $txId already known');
    }
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
  return tx;
}
