import 'dart:async';
import 'dart:io';
import 'dart:typed_data';

import 'package:coinslib/coinslib.dart';
import 'package:color_logger/color_logger.dart';
import 'package:dart_utxo_server/src/models/address.dart';
import 'package:dart_utxo_server/src/models/block.dart';
import 'package:dart_utxo_server/src/models/utxo.dart';
import 'package:dart_utxo_server/src/networks.dart' as networks;
import 'package:dart_coin_rpc/dart_coin_rpc.dart';
import 'package:dart_utxo_server/src/surreal_orm.dart';
import 'package:hex/hex.dart';
import 'package:surrealdb/surrealdb.dart';

final _console = ColorLogger();
late RPCClient _client;
late int _heightInClient;
late int _heightInSurrealDB;
late SurrealDB surrealClient;
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
    _console.log(
      'connected to ${env['COIN_NAME']} RPC',
      status: LogStatus.success,
    );
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
    _heightInSurrealDB = await SurrealORM().getHeightInSurrealDB();
    if (_heightInSurrealDB < _heightInClient) {
      _parseBlocks();
    }
    //start parse timer
    _blockTimer ??= Timer.periodic(
      Duration(seconds: 30),
      (_) async {
        _heightInClient = await _client.call('getblockcount');
        _console.log(
          "Timer - hive: $_heightInSurrealDB, client: $_heightInClient, lock: $_parsingLocked",
          status: LogStatus.info,
        );
        if (_heightInSurrealDB <= _heightInClient && _parsingLocked == false) {
          _parseBlocks();
        }
      },
    );
  }
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
    'starting at block $_heightInSurrealDB, height in client: $_heightInClient, lock: $_parsingLocked',
    status: LogStatus.info,
  );

  if (_parsingLocked == true) return;

  await Future.doWhile(() async {
    _parsingLocked = true;
    _heightInSurrealDB = await SurrealORM().getHeightInSurrealDB();
    var currentBlockNumber = _heightInSurrealDB + 1;

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

    //get tx
    if (currentBlockNumber > 0) {
      //loop through tx in block
      for (var tx in block["tx"]) {
        var txDecoded = await _client.call('getrawtransaction', [tx, 1]);
        _console.log('tx: $tx', status: LogStatus.info);
        for (var vin in txDecoded["vin"]) {
          await _parseVin(vin);
        }

        for (var vout in txDecoded["vout"]) {
          await _parseVout(
            blockheight: currentBlockNumber,
            txid: txDecoded["txid"],
            vout: vout,
          );
        }
      }
    }

    //create block
    await SurrealORM().createBlock(
      Block(
        height: currentBlockNumber,
        hash: blockHash,
      ),
    );

    return _heightInSurrealDB <= _heightInClient;
  });

  //unlock again
  _parsingLocked = false;
}

Future<void> _parseVin(Map tx) async {
  if (!tx.containsKey('coinbase')) {
    var voutIndex = tx["vout"];
    dynamic txDecoded;
    try {
      txDecoded = await _client.call('getrawtransaction', [tx['txid'], 1]);
    } catch (e) {
      Future.delayed(Duration(seconds: 1), () => _parseVin(tx));
      return;
    }
    if (txDecoded == null) {
      _parseVin(tx); //try again
      return;
    }

    List vouts = txDecoded["vout"];
    for (var element in vouts) {
      if (element['n'] == voutIndex) {
        //vout has been spent
        _console.log(
          "utxo has been spent: ${txDecoded["txid"]} - $voutIndex",
          status: LogStatus.info,
        );
        SurrealORM().deleteUtxo(utxoId: 'utxo:${txDecoded["txid"]}$voutIndex');
      }
    }
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
      //loop through array of addresses
      for (var addr in vout["scriptPubKey"]["addresses"]) {
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

  for (var addr in addresses) {
    await SurrealORM().createAddress(
      AddressModel(
        address: addr,
      ),
      txid,
    );
  }

  await SurrealORM().createUtxo(
    Utxo(
      txid: txid,
      txpos: vout['n'],
      value: vout['value'],
      hex: scriptPubKey["hex"],
      addresses: addresses,
      block: blockheight,
    ),
  );

//TODO reorg protection
//TODO mempool
}
