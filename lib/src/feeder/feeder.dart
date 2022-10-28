import 'dart:async';
import 'dart:io';
import 'dart:typed_data';

import 'package:coinslib/coinslib.dart';
import 'package:dart_coin_rpc/dart_coin_rpc.dart';
import 'package:marisma/src/models/address.dart';
import 'package:marisma/src/models/block.dart';
import 'package:marisma/src/models/tx.dart';
import 'package:marisma/src/models/utxo.dart';
import 'package:marisma/src/networks.dart' as networks;
import 'package:marisma/src/orm/surreal_orm.dart';
import 'package:marisma/src/tools/logger.dart';
import 'package:hex/hex.dart';
import 'package:surrealdb/surrealdb.dart';

Map<String, String> env = Platform.environment;
late SurrealDB surrealClient;
Timer? _blockTimer;
late RPCClient _client;
late int _heightInClient;
late int _heightInSurrealDB;
final _logger = LoggerWrapper().logger;
String _nextBlockHash = "";
bool _parsingLocked = false;
Timer? _pingTimer;
bool _rpcConnected = false;

Future<void> connectToRpc() async {
  try {
    _logger.i('Connecting to RPC...');
    _client = RPCClient(
      host: env["COIN_RPC_HOST"]!,
      port: int.parse(env["COIN_RPC_PORT"]!),
      username: env["COIN_RPC_USER"]!,
      password: env["COIN_RPC_PASSWORD"]!,
      useSSL: env["COIN_RPC_USE_SSL"]! == "true",
    );
    _heightInClient = await _client.call('getblockcount');
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
      Duration(seconds: 10),
      (_) async {
        try {
          _heightInClient = await _client.call('getblockcount');
        } catch (e) {
          _logger.e('error calling RPC: ${e.toString()}');
        }

        _logger.d(
          "Timer - surreal: $_heightInSurrealDB, client: $_heightInClient, lock: $_parsingLocked",
        );
        if (_heightInSurrealDB < _heightInClient && _parsingLocked == false) {
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

Future<String> getNextBlockHash(int currentBlockNumber) async {
  return _nextBlockHash.isEmpty
      ? await _client.call('getblockhash', [currentBlockNumber])
      : _nextBlockHash;
}

void _parseBlocks() async {
  if (_parsingLocked == true) return;
  _logger.d(
    'starting at block $_heightInSurrealDB, height in client: $_heightInClient, lock: $_parsingLocked',
  );

  await Future.doWhile(() async {
    _parsingLocked = true;
    _heightInSurrealDB = await SurrealORM().getHeightInSurrealDB();
    var currentBlockNumber = _heightInSurrealDB + 1;

    if (currentBlockNumber > _heightInClient) return false;

    _logger.i(
      "current block $currentBlockNumber of $_heightInClient",
    );
    String blockHash;
    Map block;

    //get block
    try {
      blockHash = await getNextBlockHash(currentBlockNumber);
      block = await _client.call('getblock', [blockHash, 2]);
    } catch (e) {
      _logger.e(
        'error calling RPC: ${e.toString()}',
      );
      _parsingLocked = false;
      return false;
    }

    //get tx
    if (currentBlockNumber > 0) {
      //loop through tx in block
      for (var txDecoded in block["tx"]) {
        await _parseTx(txDecoded, currentBlockNumber);
      }
    }

    //create block
    await SurrealORM().createBlock(
      Block(
        height: currentBlockNumber,
        hash: blockHash,
        blocktime: block["time"] ?? 0,
      ),
    );

    //put nextBlockHash
    _nextBlockHash = block["nextblockhash"] ?? '';
    _heightInSurrealDB = await SurrealORM().getHeightInSurrealDB();

    return currentBlockNumber < _heightInClient;
  });

  //unlock again
  _parsingLocked = false;
}

Future<void> _parseTx(txDecoded, int currentBlockNumber) async {
  _logger.d('tx: ${txDecoded["txid"]}');

  await SurrealORM().createTx(
    Tx(
      txid: txDecoded["txid"],
      block: currentBlockNumber,
      txData: txDecoded,
    ),
  );

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

Future<void> _parseVin(Map tx) async {
  if (!tx.containsKey('coinbase')) {
    var voutIndex = tx["vout"];
    var txId = tx["txid"];

    //vout has been spent
    _logger.d(
      "utxo has been spent: $txId - index: $voutIndex",
    );
    await SurrealORM().deleteUtxo(
      utxoId: 'utxo:$txId$voutIndex',
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

  if (addresses.isNotEmpty) {
    //discard utxos without addresses - coinstake etc. since they are unspendable
    await SurrealORM().createUtxo(
      Utxo(
        txid: txid,
        txpos: vout['n'],
        value: vout['value'],
        addresses: addresses,
        block: blockheight,
      ),
    );
  }

//TODO reorg protection
//TODO mempool
}
