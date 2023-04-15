import 'dart:io';
import 'dart:typed_data';

import 'package:coinslib/coinslib.dart';
import 'package:hex/hex.dart';
import 'package:marisma/src/orm/isar_orm.dart';
import 'package:marisma/src/parsers/coin_parser.dart';
import '../http_wrapper/http_wrapper.dart';
import '../models/address.dart';
import '../models/block.dart';
import '../networks.dart' as networks;

import '../models/utxo.dart';
import '../tools/logger.dart';

class PeercoinParser extends CoinParser {
  static final Map<String, PeercoinParser> _cache = <String, PeercoinParser>{};
  final _addressCache = [];
  final _logger = LoggerWrapper().logger;
  final Map _asmStringAddressCache = {};

  factory PeercoinParser() {
    return _cache.putIfAbsent(
      'peercoinParser',
      () => PeercoinParser._internal(),
    );
  }
  PeercoinParser._internal();

  String convertHexToAddress(String asmString) {
    final cleanAsmString = asmString.split(" ")[0];

    //limit _asmStringCache to 500k entries, ~50-75 mb RAM
    if (_asmStringAddressCache.keys.length > 500000) {
      _asmStringAddressCache.remove(_asmStringAddressCache.keys.first);
    }

    return _asmStringAddressCache.putIfAbsent(
      cleanAsmString,
      () {
        _logger.d('$cleanAsmString not in cache');
        var res = P2PKH.fromPublicKey(
          Uint8List.fromList(
            HEX.decode(cleanAsmString),
          ),
        );
        return res.address(
          networks.availableNetworks[Platform.environment["COIN_NAME"]]!,
        );
      },
    );
  }

  void _addToAddressCache(String address) {
    if (_addressCache.length > 1000000) {
      //keep last 1 million addresses in cache (requires ~50 to 100 mb of ram)
      _addressCache.removeAt(0); //remove oldest item
    }
    _addressCache.add(address);
  }

  Future<String> _getBlockHash(int currentBlockNumber) async {
    return await HttpWrapper().get(
      path: 'blockhashbyheight/$currentBlockNumber.hex',
      trimmed: true,
    );
  }

  @override
  Future<void> parseBlock(int currentBlockNumber) async {
    String blockHash;
    Map block;

    //get block
    try {
      blockHash = await _getBlockHash(currentBlockNumber);
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
        futures.add(parseTx(txDecoded, currentBlockNumber));
      }
      await Future.wait(futures).onError(
        (error, _) => throw Exception(
          error.toString(),
        ),
      );
    }

    //create block
    await StormberryORM().createBlock(
      BlockInsertRequest(
        id: currentBlockNumber,
        hash: blockHash,
        blocktime: block["time"] ?? 0,
      ),
    );
  }

  @override
  Future<void> parseTx(Map txDecoded, int currentBlockNumber) async {
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
      await StormberryORM().flagUtxoForDelete(
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
          StormberryORM().createAddress(
            AddressModelInsertRequest(
              address: addr,
              confirmedBalance: 0,
              unconfirmedBalance: 0,
              needsUpdating: true,
              status: '',
              utxoHistory: [],
            ),
          ),
        );
        _addToAddressCache(addr);
      }
    }
    await Future.wait(futures);

    if (addresses.isNotEmpty) {
      //discard utxos without addresses - coinstake etc. since they are unspendable
      await StormberryORM().createUtxo(
        UtxoInsertRequest(
          txid: txid,
          txpos: vout['n'],
          value: vout['value'],
          addresses: addresses,
          block: blockheight,
          flaggedForDelete: false,
        ),
      );
    }
  }
}
