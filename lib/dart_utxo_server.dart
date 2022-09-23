import 'dart:async';
import 'dart:io';
import 'dart:typed_data';

import 'package:coinslib/coinslib.dart';
import 'package:color_logger/color_logger.dart';
import 'package:dart_utxo_server/src/networks.dart' as networks;
import 'package:dart_coin_rpc/dart_coin_rpc.dart';
import 'package:hex/hex.dart';

var _console = ColorLogger();
late RPCClient _client;
late int _heightInClient;
late int _heightInHive;
bool _parsingLocked = false;
bool _rpcConnected = false;
Timer? _blockTimer;
Timer? _pingTimer;
Map<String, String> env = Platform.environment;

Future<void> connectToRpc() async {
  try {
    _console.log('trying to connect to RPC...', status: LogStatus.info);
    _client = RPCClient(
      host: env["COIN_RPC_HOST"]!,
      port: int.parse(env["COIN_RPC_PORT"]!),
      username: env["COIN_RPC_USER"]!,
      password: env["COIN_RPC_PASSWORD"]!,
      useSSL: env["COIN_RPC_USE_SSL"]! == "true",
    );
    _heightInClient = await _client.call('getblockcount');
    _rpcConnected = true;
    _console.log('connected to ${env['COIN_NAME']} RPC',
        status: LogStatus.success);
  } catch (e) {
    _rpcConnected = false;
    _console.log(
      'error connecting to RPC: ${e.toString()}',
      status: LogStatus.error,
    );
    if (_blockTimer != null) {
      _blockTimer!.cancel();
      _blockTimer = null;
    }
    if (_pingTimer != null) {
      _pingTimer!.cancel();
      _pingTimer = null;
    }
    await Future.delayed(
      Duration(seconds: 5),
      () async => await connectToRpc(),
    );
    return;
  }

  if (_rpcConnected) {
    _heightInHive = await _getHeightInHive();
    // _heightInHive = 500000;
    if (_heightInHive < _heightInClient) {
      _parseBlocks();
    }
    //start parse timer
    _blockTimer ??= Timer.periodic(
      Duration(seconds: 30),
      (_) async {
        _heightInClient = await _client.call('getblockcount');
        _console.log(
          "Timer - hive: $_heightInHive, client: $_heightInClient, lock: $_parsingLocked",
          status: LogStatus.info,
        );
        if (_heightInHive <= _heightInClient && _parsingLocked == false) {
          _parseBlocks();
        }
      },
    );
  }
}

Future<int> _getHeightInHive() async {
  // _blockCountHiveBox = await Hive.openBox('blockCountBox');
  if (env.containsKey('STARTING_POINT')) {
    return int.parse(env['STARTING_POINT']!);
  }
  return 0;
  // return _blockCountHiveBox.get(_fieldNameInHive) ?? 0;
}

String convertHexToAddress(String asmString) {
  var res = P2PKH(
    data: PaymentData(
      pubkey: Uint8List.fromList(
        HEX.decode(
          asmString.split(" ")[0],
        ),
      ),
    ),
    network: networks.availableNetworks[Platform.environment["COIN_NAME"]],
  );
  return res.data.address ?? "?";
}

void _parseBlocks() async {
  _console.log(
    'starting at block $_heightInHive, height in client: $_heightInClient, lock: $_parsingLocked',
    status: LogStatus.info,
  );

  if (_parsingLocked == true) return;

  await Future.doWhile(() async {
    _parsingLocked = true;
    var currentBlockNumber = _heightInHive;
    if (currentBlockNumber == 0) currentBlockNumber++;
    _console.log(
      "current block $currentBlockNumber of $_heightInClient",
      status: LogStatus.info,
    );
    String blockHash;
    Map block;

    //get block
    try {
      blockHash = await _client.call('getblockhash', [currentBlockNumber]);
      block = await _client.call('getblock', [blockHash]);
    } catch (e) {
      _console.log(
        'error connecting to RPC: ${e.toString()}',
        status: LogStatus.error,
      );
      _parsingLocked = false;
      return false;
    }

    //get addresses
    if (currentBlockNumber > 0) {
      //loop through tx in block
      for (var tx in block["tx"]) {
        var txDecoded = await _client.call('getrawtransaction', [tx, 1]);
        //only count addresses once per transaction
        Map<String, bool> addressesFoundInOutputs =
            await _parseVouts(txDecoded["vout"]);
        _console.log('tx: $tx', status: LogStatus.info);

        for (var vin in txDecoded["vin"]) {
          _pingVin(vin);
        }

        addressesFoundInOutputs.forEach(
          (address, value) {
            _pingVout(address);
          },
        );
      }
    }

    //update blockheight
    _heightInHive++;
    // _blockCountHiveBox.put(_fieldNameInHive, _heightInHive);

    return _heightInHive <= _heightInClient;
  });

  //unlock again
  _parsingLocked = false;
}

void _pingVout(String address) async {
  // await CloudFlareKV().incrementNumberOfTxInHive(address);

  // if (await CloudFlareKV().shouldUpdateUtxo(address, _heightInClient)) {
  //   ElectrumxRPC().sendMessage(
  //     'query',
  //     address,
  //     {
  //       "limit": 1,
  //       "items": [address]
  //     },
  //   );
  // }
  return;
}

void _pingVin(Map tx) async {
  if (!tx.containsKey('coinbase')) {
    var addressesInVin = {};
    var voutIndex = tx["vout"];
    dynamic txDecoded;
    try {
      txDecoded = await _client.call('getrawtransaction', [tx['txid'], 1]);
    } catch (e) {
      Future.delayed(Duration(seconds: 1), () => _pingVin(tx));
      return;
    }
    if (txDecoded == null) {
      _pingVin(tx); //try again
      return;
    }

    List vouts = txDecoded["vout"];
    for (var element in vouts) {
      if (element['n'] == voutIndex) {
        addressesInVin = await _parseVouts([element]);
      }
    }
    addressesInVin.forEach(
      (addr, value) async {
        // if (await CloudFlareKV().shouldUpdateUtxo(addr, _heightInClient)) {
        //   ElectrumxRPC().sendMessage(
        //     'query',
        //     addr,
        //     {
        //       "limit": 1,
        //       "items": [addr]
        //     },
        //   );
        // }
      },
    );
  }
}

Future<Map<String, bool>> _parseVouts(vouts) async {
  Map<String, bool> addressesFoundInOutputs = {};

  //loop through vouts (we only count vouts)
  for (var vout in vouts) {
    var scriptPubKey = vout["scriptPubKey"];
    var type = scriptPubKey["type"];

    if (type != "nonstandard" && type != "nulldata") {
      if (type == "pubkeyhash" ||
          type == "scripthash" ||
          type == "witness_v0_keyhash" ||
          type == "witness_v0_scripthash") {
        //loop through array of addresses
        for (var addr in vout["scriptPubKey"]["addresses"]) {
          if (!addressesFoundInOutputs.containsKey(addr)) {
            addressesFoundInOutputs[addr] = true;
          }
        }
      } else {
        var addrConverted = convertHexToAddress(vout["scriptPubKey"]["asm"]);
        if (!addressesFoundInOutputs.containsKey(addrConverted)) {
          addressesFoundInOutputs[addrConverted] = true;
        }
      }
    }
  }
  return addressesFoundInOutputs;
}
