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

Future<void> connectToRpc() async {
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
      () async => await connectToRpc(),
    );
    return;
  }

  if (_rpcConnected) {
    _heightInIsar = await IsarORM().getHeightInIsar();
    if (_heightInIsar < _heightInClient) {
      _parseBlocks();
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
          _heightInIsar = await IsarORM().getHeightInIsar();
        } catch (e) {
          _logger.e('error calling RPC: ${e.toString()}');
        }

        _logger.d(
          "Timer - isar: $_heightInIsar, client: $_heightInClient, lock: $_parsingLocked",
        );
        if (_heightInIsar < _heightInClient && _parsingLocked == false) {
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
      ? await HttpWrapper().get(
          path: 'blockhashbyheight/$currentBlockNumber.hex',
          trimmed: true,
        )
      : _nextBlockHash;
}

void _parseBlocks() async {
  if (_parsingLocked == true) return;
  _logger.d(
    'starting at block $_heightInIsar, height in client: $_heightInClient, lock: $_parsingLocked',
  );

  await Future.doWhile(
    () async {
      _parsingLocked = true;
      _heightInIsar = await IsarORM().getHeightInIsar();
      var currentBlockNumber = _heightInIsar + 1;

      //check parsing protections
      if (currentBlockNumber > _heightInClient ||
          await didChainReorg(currentBlockNumber) == true) {
        _parsingLocked = false;
        return false;
      } else {
        _logger.i(
          "current block $currentBlockNumber of $_heightInClient",
        );
        String blockHash;
        Map block;

        //get block
        try {
          blockHash = await getNextBlockHash(currentBlockNumber);
          block = await HttpWrapper().get(
            path: 'block/$blockHash.json',
            requestJson: true,
          );
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
        await IsarORM().createBlock(
          Block(
            id: currentBlockNumber,
            hash: blockHash,
            blocktime: block["time"] ?? 0,
          ),
        );

        //put nextBlockHash
        _nextBlockHash = block["nextblockhash"] ?? '';
        _heightInIsar = await IsarORM().getHeightInIsar();

        return currentBlockNumber < _heightInClient;
      }
    },
  );

  //unlock again
  _parsingLocked = false;
}

Future<void> _parseTx(Map txDecoded, int currentBlockNumber) async {
  _logger.d('tx: ${txDecoded["txid"]}');
  txDecoded["height"] = currentBlockNumber;

  await IsarORM().createTx(
    Tx(
      txid: txDecoded["txid"],
      block: currentBlockNumber,
      rawTx: txDecoded.toString(),
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
    await IsarORM().deleteConfirmedUtxo(
      utxoId: txId,
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

  for (var addr in addresses) {
    await IsarORM().createOrUpdateAddress(
      AddressModel(
        address: addr,
      ),
      txid,
    );
  }

  if (addresses.isNotEmpty) {
    //discard utxos without addresses - coinstake etc. since they are unspendable
    await IsarORM().createConfirmedUtxo(
      Utxo(
        txid: txid,
        txpos: vout['n'],
        value: vout['value'],
        addresses: addresses,
        block: blockheight,
      ),
    );
  }

//TODO mempool
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
        await IsarORM().getBlockHash(blockNumberToCheck);

    if (isarHashAtReorgDepth != clientHashAtReorgDepth) {
      //drop utxos and history where block hash > reorg depth
      //reset blockheight
      _logger.w(
        'Chain reorg detected at $blockNumberToCheck, should be: $clientHashAtReorgDepth - is: $isarHashAtReorgDepth,  cleaning up...',
      );
      await IsarORM().performIsarReorg(blockNumberToCheck);
      throw Error();
    }
  }

  return false;
}
