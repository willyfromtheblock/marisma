import 'dart:convert';
import 'dart:io';

import 'package:stormberry/stormberry.dart';

import '../models/address.dart';
import '../models/block.dart';
import '../models/utxo.dart';
import '../tools/logger.dart';

class StormberryORM {
  static final Map<String, StormberryORM> _cache = <String, StormberryORM>{};
  late Database _db;
  final _logger = LoggerWrapper().logger;
  Map<String, String> env = Platform.environment;

  factory StormberryORM() {
    return _cache.putIfAbsent('isar', () => StormberryORM._internal());
  }
  StormberryORM._internal();

  Future<void> createBlock(BlockInsertRequest block) async {
    try {
      await _db.blocks.insertOne(block);
    } catch (e) {
      _logger.e(e.toString());
      throw Exception(e.toString());
    }
  }

  Future<void> createAddress(AddressModelInsertRequest addr) async {
    try {
      await _db.runTransaction(
        () async {
          final addressInIsar =
              await _db.addressModels.queryAddressModel(addr.address);
          //check if already exists

          if (addressInIsar == null) {
            await _db.addressModels.insertOne(addr);
          }
        },
      );
    } catch (e) {
      _logger.e(e.toString());
      throw Exception(e.toString());
    }
  }

  Future<void> createUtxo(UtxoInsertRequest utxo) async {
    bool updateAddresses = false;
    bool writeUtxoLink = false;
    int utxoId = 0;

    try {
      await _db.runTransaction(
        () async {
          List<UtxoView?> utxoInDb = await _db.utxos.queryUtxos(
            QueryParams(
              where: 'txid=@txid AND txpos=@txpos',
              values: {'txid': utxo.txid, 'txpos': utxo.txpos},
              limit: 1,
            ),
          );

          if (utxoInDb.isEmpty) {
            final storedUtxo = utxoInDb.first;
            utxoId = storedUtxo.id;
            if (storedUtxo.value == -1) {
              //utxo flagged for delete
              await _db.utxos.updateOne(
                UtxoUpdateRequest(
                  id: storedUtxo.id,
                  value: utxo.value,
                  block: utxo.block,
                  addresses: utxo.addresses,
                  flaggedForDelete: true,
                ),
              );
            } else if (storedUtxo.block == -1) {
              //unconfirmed utxo
              if (utxo.block > -1) {
                //utxo has confirmed

                await _db.utxos.updateOne(
                  UtxoUpdateRequest(
                    id: storedUtxo.id,
                    block: utxo.block,
                  ),
                );

                //update addresses
                updateAddresses = true;
                writeUtxoLink = false;
              }
            }
          } else {
            //put new utxo
            writeUtxoLink = true;
            updateAddresses = true;
            utxoId = await _db.utxos.insertOne(
              UtxoInsertRequest(
                flaggedForDelete: utxo.flaggedForDelete,
                txid: utxo.txid,
                txpos: utxo.txpos,
                value: utxo.value,
                block: utxo.block,
                addresses: utxo.addresses,
              ),
            );
          }
        },
      );

      if (updateAddresses == true) {
        await updateAddressesFromUtxo(
          utxoId: utxoId,
          writeUtxoLink: writeUtxoLink,
        );
      }
    } catch (e) {
      _logger.e(e.toString());
      throw Exception(e.toString());
    }
  }

  Future<void> updateAddressesFromUtxo({
    required int utxoId,
    required bool writeUtxoLink,
  }) async {
    List<Future<void>> futures = [];
    final utxo = await _db.utxos.queryUtxo(utxoId);
    if (utxo == null) return;

    for (var addr in utxo.addresses) {
      futures.add(
        _db.runTransaction(
          () async {
            final addrInIsar = await _db.addressModels.queryAddressModel(addr);

            if (addrInIsar != null) {
              if (writeUtxoLink == true) {
                await _db.utxos.updateOne(
                  UtxoUpdateRequest(
                    id: utxo.id,
                    addressModelAddress: addr,
                  ),
                );
              }
              await _db.addressModels.updateOne(
                AddressModelUpdateRequest(
                  address: addr,
                  needsUpdating: true,
                ),
              );
            }
          },
        ),
      );
    }
    await Future.wait(futures);
  }

  Future<void> flagUtxoForDelete({
    required String utxoTxId,
    required int txPos,
  }) async {
    try {
      await _db.runTransaction(() async {
        final utxo = await _db.utxos.queryUtxos(
          QueryParams(
            where: 'txid=@txid AND txpos=@txpos',
            values: {'txid': utxoTxId, 'txpos': txPos},
            limit: 1,
          ),
        );

        if (utxo.isNotEmpty) {
          await _db.utxos.updateOne(
            UtxoUpdateRequest(id: utxo.first.id, flaggedForDelete: true),
          );
        } else {
          //wants to delete an utxo that has not been parsed yet
          //flag it as such so it can be handled on actual creation
          await _db.utxos.insertOne(
            UtxoInsertRequest(
              flaggedForDelete: true,
              txid: utxoTxId,
              txpos: txPos,
              value: -1,
              block: 0,
              addresses: [],
            ),
          );
        }
      });
    } catch (e) {
      _logger.e(e.toString());
      throw Exception(e.toString());
    }
  }

  Future<List<String>> getAddressHistory(
    String address,
    bool ascending,
  ) async {
    final addrInIsar = await _db.addressModels.queryAddressModel(address);
    if (addrInIsar != null) {
      List<Map> responseUnsorted = [];
      for (var tx in addrInIsar.utxoHistory) {
        responseUnsorted.add(jsonDecode(tx));
      }
      responseUnsorted.sort(
        ascending
            ? ((a, b) => a["block"]!.compareTo(b["block"]!))
            : ((a, b) => b["block"]!.compareTo(a["block"]!)),
      );

      List<String> responseSorted = [];
      for (var element in responseUnsorted) {
        responseSorted.add(jsonEncode(element));
      }
      return responseSorted.toSet().toList(); //filters duplicates
    }

    return [];
  }

  Future<int> getAddressNumberOfUtxos(
    String address,
  ) async {
    final addrInIsar = await _db.addressModels.queryAddressModel(address);

    if (addrInIsar != null) {
      return addrInIsar.utxos.length;
    }
    return 0;
  }

  Future<List<String>> getAddressUtxos(
    String address,
    bool ascending,
  ) async {
    final addrInIsar = await _db.addressModels.queryAddressModel(address);
    if (addrInIsar != null) {
      List<Map> responseUnsorted = [];
      for (var utxo in addrInIsar.utxos) {
        responseUnsorted.add(
          {
            "txid": utxo.txid,
            "tx_pos": utxo.txpos,
            "value": utxo.value,
            "block": utxo.block,
          },
        );
      }
      responseUnsorted.sort(
        ascending
            ? ((a, b) => a["block"]!.compareTo(b["block"]!))
            : ((a, b) => b["block"]!.compareTo(a["block"]!)),
      );

      List<String> responseSorted = [];
      for (var element in responseUnsorted) {
        responseSorted.add(jsonEncode(element));
      }
      return responseSorted;
    }
    return [];
  }

  Future<Map<String, int>> getBalanceForAddress(String address) async {
    final addrInIsar = await _db.addressModels.queryAddressModel(address);

    if (addrInIsar != null) {
      return {
        "confirmed": addrInIsar.confirmedBalance,
        "unconfirmed": addrInIsar.unconfirmedBalance,
      };
    }
    return {
      "confirmed": 0,
      "unconfirmed": 0,
    };
  }

  Future<String> getBlockHash(int height) async {
    try {
      var block = await _db.blocks.queryBlocks(
        QueryParams(
          where: 'id=@id',
          values: {'id': height},
          limit: 1,
        ),
      );
      if (block.isNotEmpty) {
        return block.first.hash;
      }
    } catch (e) {
      _logger.e(e.toString());
    }
    return '';
  }

  Future<int> getHeightInPostgres() async {
    final res = await _db.blocks.queryBlocks(QueryParams(
      limit: 1,
      orderBy: 'id DESC',
    ));
    if (res.isNotEmpty) {
      return res.first.id;
    }
    return 0;
  }

  Future<int> getNumberOfAddressesThatNeedUpdating() async {
    final res = await _db.addressModels.queryAddressModels(
      QueryParams(
        where: 'needsUpdating=@needsUpdating',
        values: {'needsUpdating': true},
      ),
    );
    return res.length;
  }

  Future<bool> getIsAddressKnown(String address) async {
    if (await _db.addressModels.queryAddressModel(address) == null) {
      return false;
    }
    return true;
  }

  Future<void> init() async {
    //open db connection
    _logger.i('Init Stormberry');
    _db = Database(
      database: 'postgres',
      host: "127.0.0.1",
      port: 5433,
      password: 'password',
      useSSL: false,
    );

    _logger.i('Stormberry init complete');
  }

  void initWithDBReference(Database db) {
    _db = db;
  }
}
