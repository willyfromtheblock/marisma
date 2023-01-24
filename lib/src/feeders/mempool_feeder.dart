import 'dart:async';
import 'dart:io';
import 'dart:typed_data';

import 'package:coinslib/coinslib.dart';
import '../models/address.dart';
import '../models/block.dart';
import '../models/tx.dart';
import '../models/utxo.dart';
import '../networks.dart' as networks;
import '../orm/isar_orm.dart';
import '../tools/logger.dart';
import 'package:hex/hex.dart';

import '../http_wrapper/http_wrapper.dart';

Map<String, String> env = Platform.environment;
Timer? _blockTimer;
late int _heightInClient;
late int _heightInIsar;
final _logger = LoggerWrapper().logger;
String _nextBlockHash = "";
bool _parsingLocked = false;
bool _rpcConnected = false;

Future<void> initMempoolFeeder() async {}
