import 'dart:io';

import 'package:coinlib/coinlib.dart';
import 'package:marisma/src/parsers/coin_parser.dart';
import 'package:marisma/src/parsers/parser_models.dart';
import '../http_wrapper/http_wrapper.dart';
import '../models/address.dart';
import '../models/block.dart';
import '../networks.dart' as networks;

import '../models/utxo.dart';
import '../tools/logger.dart';

class PeercoinParser implements CoinParser {
  static final Map<String, PeercoinParser> _cache = <String, PeercoinParser>{};
  final _addressCache = [];
  final _logger = LoggerWrapper().logger;
  final Map _asmStringAddressCache = {};
  final _p2pkhPrefix = networks
      .availableNetworks[Platform.environment["COIN_NAME"]]!.p2pkhPrefix;

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
        try {
          return P2PKHAddress.fromHash(
            hash160(
              hexToBytes(cleanAsmString),
            ),
            version: _p2pkhPrefix,
          ).toString();
        } catch (e) {
          throw Exception(e.toString());
        }
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
  Future<ParsedBlock> parseBlock(int currentBlockNumber) async {
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

    List<ParsedTx> txs = [];

    //get tx
    if (currentBlockNumber > 0) {
      List<Future<ParsedTx>> futures = [];

      //loop through tx in block
      for (var txDecoded in block["tx"]) {
        futures.add(parseTx(txDecoded, currentBlockNumber));
      }

      txs = await Future.wait(futures);
    }

    //create block
    return ParsedBlock(
      block: Block(
        height: currentBlockNumber,
        hash: blockHash,
        time: block["time"],
      ),
      utxoToSpend: txs.expand((tx) => tx.utxoToSpend).toList(),
      addressesToCreate: txs.expand((tx) => tx.addressesToCreate).toList(),
      utxosToCreateOrUpdate:
          txs.expand((tx) => tx.utxosToCreateOrUpdate).toList(),
    );
  }

  @override
  Future<ParsedTx> parseTx(Map txDecoded, int currentBlockNumber) async {
    _logger.d('tx: ${txDecoded["txid"]}');
    txDecoded["height"] = currentBlockNumber;

    List<Future<(String, int)>> utxoToSpendFutures = [];

    for (var vin in txDecoded["vin"]) {
      utxoToSpendFutures.add(
        _parseVin(tx: vin, blockHeight: currentBlockNumber),
      );
    }

    List<Future<(List<AddressModel>, List<Utxo>)>> addressAndUtxoFutures = [];

    for (var vout in txDecoded["vout"]) {
      addressAndUtxoFutures.add(
        _parseVout(
          blockHeight: currentBlockNumber,
          txid: txDecoded["txid"],
          vout: vout,
        ),
      );
    }

    final res = await Future.wait(addressAndUtxoFutures);
    List<AddressModel> addressesToCreate = [];
    List<Utxo> utxosToCreateOrUpdate = [];

    for (var element in res) {
      final (addresses, utxos) = element;
      addressesToCreate.addAll(addresses);
      utxosToCreateOrUpdate.addAll(utxos);
    }

    return ParsedTx(
      utxoToSpend: (await Future.wait(utxoToSpendFutures))
          .where((e) => e != ('', 0)) // filter out coinbase
          .toList(),
      addressesToCreate: addressesToCreate,
      utxosToCreateOrUpdate: utxosToCreateOrUpdate,
    );
  }

  Future<(String, int)> _parseVin({
    required Map tx,
    required int blockHeight,
  }) async {
    if (!tx.containsKey('coinbase')) {
      var voutIndex = tx["vout"];
      var txId = tx["txid"].toString();

      //vout has been spent
      _logger.d(
        "utxo has been spent: $txId - index: $voutIndex",
      );
      return (
        txId + voutIndex.toString(),
        blockHeight,
      );
    }
    return ('', 0);
  }

  Future<(List<AddressModel>, List<Utxo>)> _parseVout({
    required int blockHeight,
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
          type == "witness_v0_scripthash" ||
          type == "witness_v1_taproot") {
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

    List<AddressModel> addressesToCreate = [];
    List<Utxo> utxosToCreateOrUpdate = [];

    for (var addr in addresses) {
      if (!_addressCache.contains(addr)) {
        addressesToCreate.add(
          AddressModel(
            address: addr,
          ),
        );
        _addToAddressCache(addr);
      }
    }

    if (addresses.isNotEmpty) {
      //discard utxos without addresses - coinstake etc. since they are unspendable
      utxosToCreateOrUpdate.add(
        Utxo(
          txid: txid,
          txpos: vout['n'],
          value: vout['value'],
          address: addresses
              .first, //only one address per vout - there is no case atm where there are multiple addresses per vout
          block: blockHeight,
          spentOnBlock:
              -2, // -2 = unspent, -1 = spent in mempool, 0+ = spent on block
        ),
      );
    }
    return (addressesToCreate, utxosToCreateOrUpdate);
  }
}
