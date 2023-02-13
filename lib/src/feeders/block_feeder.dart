import 'dart:async';
import 'dart:io';
import 'dart:typed_data';

import 'package:coinslib/coinslib.dart';
import 'package:hex/hex.dart';

import '../http_wrapper/http_wrapper.dart';
import '../models/address.dart';
import '../models/block.dart';
import '../models/utxo.dart';
import '../networks.dart' as networks;
import '../orm/isar_orm.dart';
import '../tools/logger.dart';

Map<String, String> env = Platform.environment;
Map _asmStringAddressCache = {};
final _addressCache = [];
Timer? _blockTimer;
late int _heightInClient;
late int _heightInIsar;
late IsarORM _isarORM;
final _logger = LoggerWrapper().logger;
bool _parsingLocked = false;
bool _rpcConnected = false;
bool _sigtermReceived = false;

void addToAddressCache(String address) {
  if (_addressCache.length > 1000000) {
    //keep last 1 million addresses in cache (requires ~50 to 100 mb of ram)
    _addressCache.removeAt(0); //remove oldest item
  }
  _addressCache.add(address);
}

String convertHexToAddress(String asmString) {
  final cleanAsmString = asmString.split(" ")[0];

  //limit _asmStringCache to 500k entries, ~50-75 mb RAM
  if (_asmStringAddressCache.keys.length > 500000) {
    _asmStringAddressCache.remove(_asmStringAddressCache.keys.first);
  }

  return _asmStringAddressCache.putIfAbsent(cleanAsmString, () {
    _logger.d('$cleanAsmString not in cache');
    var res = P2PKH.fromPublicKey(
      Uint8List.fromList(
        HEX.decode(cleanAsmString),
      ),
    );
    return res.address(
      networks.availableNetworks[Platform.environment["COIN_NAME"]]!,
    );
  });
}

Future<bool> didChainReorg(int currentBlockNumber) async {
  int reorgDepth =
      env.containsKey('REORG_DEPTH') ? int.parse(env['REORG_DEPTH']!) : 21;
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

Future<String> getBlockHash(int currentBlockNumber) async {
  return await HttpWrapper().get(
    path: 'blockhashbyheight/$currentBlockNumber.hex',
    trimmed: true,
  );
}

Future<void> initBlockFeeder() async {
  _isarORM = IsarORM();
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

Future<void> _parseBlock(int currentBlockNumber) async {
  _logger.d(
    "current block $currentBlockNumber of $_heightInClient",
  );
  String blockHash;
  Map block;

  //get block
  try {
    blockHash = await getBlockHash(currentBlockNumber);
    block = await HttpWrapper().get(
      path: 'block/$blockHash.json',
      requestJson: true,
    );
  } catch (e) {
    _logger.e(
      'error calling RPC: ${e.toString()}',
    );
    throw Exception(e.toString());
  }

  //get tx
  if (currentBlockNumber > 0) {
    List<Future<void>> futures = [];
    //loop through tx in block
    for (var txDecoded in block["tx"]) {
      futures.add(_parseTx(txDecoded, currentBlockNumber));
    }
    await Future.wait(futures).onError(
      (error, _) => throw Exception(
        error.toString(),
      ),
    );
  }

  //create block
  await _isarORM.createBlock(
    Block(
      id: currentBlockNumber,
      hash: blockHash,
      blocktime: block["time"] ?? 0,
    ),
  );

  //put nextBlockHash
  _heightInIsar = await _isarORM.getHeightInIsar();
}

Future<void> _parseTx(Map txDecoded, int currentBlockNumber) async {
  _logger.d('tx: ${txDecoded["txid"]}');
  txDecoded["height"] = currentBlockNumber;

  List<Future<void>> futures = [];

  for (var vin in txDecoded["vin"]) {
    futures.add(_parseVin(vin));
  }

  for (var vout in txDecoded["vout"]) {
    futures.add(
      _parseVout(
        blockheight: currentBlockNumber,
        txid: txDecoded["txid"],
        vout: vout,
      ),
    );
  }
  await Future.wait(futures);
}

Future<void> _parseVin(Map tx) async {
  if (!tx.containsKey('coinbase')) {
    var voutIndex = tx["vout"];
    var txId = tx["txid"];

    //vout has been spent
    _logger.d(
      "utxo has been spent: $txId - index: $voutIndex",
    );
    await _isarORM.flagUtxoForDelete(
      utxoTxId: txId,
      txPos: voutIndex,
    );
  }
}

Future<void> _parseVout({
  required blockheight,
  required String txid,
  required Map vout,
}) async {
  List<String> addresses = [];
  var scriptPubKey = vout["scriptPubKey"];
  var type = scriptPubKey["type"];

  if (type != "nonstandard" && type != "nulldata") {
    if (type == "pubkeyhash" ||
        type == "scripthash" ||
        type == "witness_v0_keyhash" ||
        type == "witness_v0_scripthash") {
      if (vout["scriptPubKey"]["addresses"].runtimeType == List) {
        //pre 0.12 backwards compatability
        for (var addr in vout["scriptPubKey"]["addresses"]) {
          if (!addresses.contains(addr)) {
            addresses.add(addr);
          }
        }
      } else {
        var addr = vout["scriptPubKey"]["address"];
        if (!addresses.contains(addr)) {
          addresses.add(addr);
        }
      }
    } else {
      var addrConverted = convertHexToAddress(vout["scriptPubKey"]["asm"]);
      if (!addresses.contains(addrConverted)) {
        addresses.add(addrConverted);
      }
    }
  }

  List<Future<void>> futures = [];
  for (var addr in addresses) {
    if (!_addressCache.contains(addr)) {
      futures.add(
        _isarORM.createAddress(
          AddressModel(
            address: addr,
          ),
        ),
      );
      addToAddressCache(addr);
    }
  }
  await Future.wait(futures);

  if (addresses.isNotEmpty) {
    //discard utxos without addresses - coinstake etc. since they are unspendable
    await _isarORM.createUtxo(
      Utxo(
        txid: txid,
        txpos: vout['n'],
        value: vout['value'],
        addresses: addresses,
        block: blockheight,
      ),
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
          futures.add(_parseBlock(currentBlockNumber + i));
        }
      }
      await Future.wait(futures);
    }

    //stop parsing on SIGTERM
    if (_sigtermReceived == true) break;
  }

  //unlock again
  _parsingLocked = false;
}
