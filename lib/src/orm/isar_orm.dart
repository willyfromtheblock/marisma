import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:grpc/grpc.dart';
import 'package:isar/isar.dart';

import '../generated/marisma.pb.dart';
import '../models/address.dart';
import '../models/block.dart';
import '../models/utxo.dart';
import '../tools/logger.dart';

class IsarORM {
  static final Map<String, IsarORM> _cache = <String, IsarORM>{};
  late Isar _isar;
  final _logger = LoggerWrapper().logger;
  Map<String, String> env = Platform.environment;
  final _blockHashStreamController = StreamController<
      BlockHashStreamReply>.broadcast(); //can be defined globally, same stream for all clients

  factory IsarORM() {
    return _cache.putIfAbsent('isar', () => IsarORM._internal());
  }
  IsarORM._internal();

  Future<void> createBlock(Block block) async {
    try {
      await _isar.writeTxn(() async {
        await _isar.blocks.put(block);
      });
    } catch (e) {
      _logger.e(e.toString());
      throw Exception(e.toString());
    }
  }

  Stream<BlockHashStreamReply> blockHashStream() async* {
    yield* _blockHashStreamController.stream.distinct();
  }

  Stream<AddressStatusStreamReply> addressStatusStream(String address) async* {
    final addressStatusStreamController =
        StreamController<AddressStatusStreamReply>();

    _logger.d('addressStatusStream requested: $address');

    final addressInIsar = await _isar.addressModels.getByAddress(address);
    if (addressInIsar != null) {
      _isar.addressModels
          .watchObject(
        addressInIsar.id,
        fireImmediately: true,
      )
          .listen((address) async {
        addressStatusStreamController.add(
          AddressStatusStreamReply()
            ..status = address!.status
            ..address = address.address,
        );
      });
    } else {
      addressStatusStreamController.addError(
        GrpcError.notFound('Address not found in database'),
      );
    }
    yield* addressStatusStreamController.stream.distinct();
  }

  Future<void> createAddress(AddressModel addr) async {
    try {
      await _isar.writeTxn(
        () async {
          final addressInIsar =
              await _isar.addressModels.getByAddress(addr.address);
          //check if already exists

          if (addressInIsar == null) {
            await _isar.addressModels.put(addr);
          }
        },
      );
    } catch (e) {
      _logger.e(e.toString());
      throw Exception(e.toString());
    }
  }

  Future<void> createUtxo(Utxo utxo) async {
    bool updateAddresses = false;
    bool writeUtxoLink = false;

    try {
      await _isar.writeTxn(
        () async {
          final utxoInDb =
              await _isar.utxos.getByTxidTxpos(utxo.txid, utxo.txpos);

          if (utxoInDb != null) {
            if (utxoInDb.value == -1) {
              //utxo flagged for delete
              //update values for history
              utxoInDb.value = utxo.value;
              utxoInDb.block = utxo.block;
              utxoInDb.addresses = utxo.addresses;
              //flag for delete
              utxoInDb.flaggedForDelete = true;

              //put updated utxo
              await _isar.utxos.put(utxoInDb);
            } else if (utxoInDb.block == -1) {
              //unconfirmed utxo
              if (utxo.block > -1) {
                //utxo has confirmed
                utxoInDb.block = utxo.block;

                //put updated utxo
                await _isar.utxos.put(utxoInDb);

                //update addresses
                updateAddresses = true;
                writeUtxoLink = false;
              }
            }
          } else {
            //put new utxo
            writeUtxoLink = true;
            updateAddresses = true;
            await _isar.utxos.put(utxo);
          }
        },
      );

      if (updateAddresses == true) {
        await updateAddressesFromUtxo(
          utxo: utxo,
          writeUtxoLink: writeUtxoLink,
        );
      }
    } catch (e) {
      _logger.e(e.toString());
      throw Exception(e.toString());
    }
  }

  Future<void> updateAddressesFromUtxo({
    required Utxo utxo,
    required bool writeUtxoLink,
  }) async {
    List<Future<void>> futures = [];

    for (var addr in utxo.addresses) {
      futures.add(
        _isar.writeTxn(
          () async {
            final addrInIsar = await _isar.addressModels.getByAddress(addr);

            if (addrInIsar != null) {
              addrInIsar.needsUpdating = true;

              if (writeUtxoLink == false) {
                await _isar.addressModels.put(addrInIsar);
              } else {
                addrInIsar.utxos.add(utxo);
                await _isar.addressModels.put(addrInIsar);
                await addrInIsar.utxos.save();
              }
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
      await _isar.writeTxn(() async {
        final utxo = await _isar.utxos.getByTxidTxpos(utxoTxId, txPos);

        if (utxo != null) {
          utxo.flaggedForDelete = true;
          await _isar.utxos.put(utxo);
        } else {
          //wants to delete an utxo that has not been parsed yet
          //flag it as such so it can be handled on actual creation
          await _isar.utxos.put(
            Utxo(
              txid: utxoTxId,
              txpos: txPos,
              value: -1, //flags utxo that needs to be deleted
              addresses: [],
              block: 0,
            ),
          );
        }
      });
    } catch (e) {
      _logger.e(e.toString());
      throw Exception(e.toString());
    }
  }

  Future<List<String>> getAddressHistory({
    required String address,
    int minimumHeight = 0,
    bool ascending = false,
  }) async {
    final addrInIsar = await _isar.addressModels.getByAddress(address);
    if (addrInIsar != null) {
      List<Map> responseUnsorted = [];
      for (var tx in addrInIsar.utxoHistory) {
        final decoded = jsonDecode(tx);
        if (decoded["block"]! >= minimumHeight) {
          responseUnsorted.add(decoded);
        }
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
    final addrInIsar = await _isar.addressModels.getByAddress(address);

    if (addrInIsar != null) {
      return addrInIsar.utxos.count();
    }
    return 0;
  }

  Future<List<String>> getAddressUtxos({
    required String address,
    int minimumHeight = 0,
    bool ascending = false,
  }) async {
    final addrInIsar = await _isar.addressModels.getByAddress(address);
    if (addrInIsar != null) {
      List<Map> responseUnsorted = [];
      for (var utxo in addrInIsar.utxos.where(
        (element) => element.block >= minimumHeight,
      )) {
        responseUnsorted.add(utxo.toMap());
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
    final addrInIsar = await _isar.addressModels.getByAddress(address);

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
      var block = await _isar.blocks.where().idEqualTo(height).findFirst();
      if (block != null) {
        return block.hash;
      }
    } catch (e) {
      _logger.e(e.toString());
    }
    return '';
  }

  Future<int> getHeightInIsar() async {
    return await _isar.blocks.count();
  }

  Future<int> getNumberOfAddressesThatNeedUpdating() async {
    return await _isar.addressModels
        .filter()
        .needsUpdatingEqualTo(true)
        .count();
  }

  Future<bool> getIsAddressKnown(String address) async {
    if (await _isar.addressModels.getByAddress(address) == null) {
      return false;
    }
    return true;
  }

  Future<void> init() async {
    //open db connection
    _logger.i('Init Isar');
    await Isar.initializeIsarCore(download: true);
    _isar = await Isar.open(
      [
        AddressModelSchema,
        BlockSchema,
        UtxoSchema,
      ],
      directory: env["LOCAL_TESTING"] == "true" ? 'isar' : '/app/isar/',
      maxSizeMiB: 4000, //TODO 4 GB is a placeholder here
      compactOnLaunch: CompactCondition(minRatio: 1.5),
    );

    _logger.i('Isar init complete');
  }

  void initWithIsarReference(Isar isar) {
    _isar = isar;
  }

  void initBlockHashWatcher() {
    _isar.blocks.watchLazy(fireImmediately: true).listen(
      (_) async {
        final currentHeight = await getHeightInIsar();
        final latestBlock = await _isar.blocks.get(currentHeight);
        if (latestBlock != null) {
          _blockHashStreamController.add(
            BlockHashStreamReply()
              ..height = latestBlock.id
              ..hash = latestBlock.hash,
          );
        }
      },
    );
  }
}
