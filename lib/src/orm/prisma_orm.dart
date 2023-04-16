import 'dart:convert';
import 'dart:io';

import 'package:coinslib/coinslib.dart';
import 'package:orm/logger.dart';

import '../generated/prisma/prisma_client.dart';
import '../tools/logger.dart';

class PrismaORM {
  static final Map<String, PrismaORM> _cache = <String, PrismaORM>{};
  late PrismaClient _prisma;
  final _logger = LoggerWrapper().logger;
  Map<String, String> env = Platform.environment;
  final _globalTransactionTimeOut = Duration(minutes: 1);

  factory PrismaORM() {
    return _cache.putIfAbsent('isar', () => PrismaORM._internal());
  }
  PrismaORM._internal();

  Future<void> createBlock(PrismaBlockCreateInput block) async {
    final transaction = await _prisma.$startTransaction(
      timeout: _globalTransactionTimeOut,
    );
    try {
      await transaction.prismaBlock.create(
        data: block,
      );
      transaction.$commitTransaction();
    } catch (e) {
      transaction.$rollbackTransaction();
      _logger.e(e.toString());
    }
  }

  Future<void> createAddress(PrismaAddressCreateInput addr) async {
    final transaction = await _prisma.$startTransaction(
      timeout: _globalTransactionTimeOut,
    );
    try {
      final addressInIsar = await transaction.prismaAddress.findFirst(
        where: PrismaAddressWhereInput(
          address: StringFilter(equals: addr.address),
        ),
      );
      //check if already exists

      if (addressInIsar == null) {
        await transaction.prismaAddress.create(data: addr);
      }
      await transaction.$commitTransaction();
    } catch (e) {
      await transaction.$rollbackTransaction();
      _logger.e(e.toString());
      throw Exception(e.toString());
    }
  }

  Future<void> createUtxo(PrismaUtxoCreateInput utxo) async {
    bool updateAddresses = false;
    final transaction = await _prisma.$startTransaction(
      timeout: _globalTransactionTimeOut,
    );

    try {
      final utxoInDb = await _findUtxoByTxidAndTxpos(
        client: transaction,
        txpos: utxo.txpos,
        txid: utxo.txid,
      );
      if (utxoInDb != null) {
        if (utxoInDb.block == -1) {
          //unconfirmed utxo
          if (utxo.block > -1) {
            //utxo has confirmed
            //put updated utxo

            await transaction.prismaUtxo.update(
              data: PrismaUtxoUpdateInput(
                block: IntFieldUpdateOperationsInput(set: utxo.block),
              ),
              where: PrismaUtxoWhereUniqueInput(id: utxoInDb.id),
            );

            //update addresses
            updateAddresses = true;
          }
        }
      } else {
        //put new utxo
        updateAddresses = true;
        await transaction.prismaUtxo.create(data: utxo);
      }

      if (updateAddresses == true && utxo.addresses != null) {
        for (var addr in utxo.addresses!) {
          final addrInIsar = await transaction.prismaAddress.findFirst(
            where: PrismaAddressWhereInput(
              address: StringFilter(equals: addr),
            ),
          );

          if (addrInIsar != null) {
            await transaction.prismaAddress.update(
              data: PrismaAddressUpdateInput(
                  needsUpdating: BoolFieldUpdateOperationsInput(set: true)),
              where: PrismaAddressWhereUniqueInput(
                address: addrInIsar.address,
              ),
            );
          }
        }
      }
      await transaction.$commitTransaction();
    } catch (e) {
      await transaction.$rollbackTransaction();
      _logger.e(e.toString());
      throw Exception(e.toString());
    }
  }

  Future<void> flagUtxoForDelete({
    required String utxoTxId,
    required int txPos,
  }) async {
    final transaction = await _prisma.$startTransaction(
      timeout: _globalTransactionTimeOut,
    );

    try {
      final utxo = await _findUtxoByTxidAndTxpos(
        client: transaction,
        txpos: txPos,
        txid: utxoTxId,
      );

      if (utxo == null) {
        await transaction.prismaUtxo.create(
          data: PrismaUtxoCreateInput(
            txid: utxoTxId,
            txpos: txPos,
            block: 0,
            value: -1, //flags utxo that needs to be deleted
            flaggedForDelete: true,
          ),
        );
      } else {
        await transaction.prismaUtxo.update(
          data: PrismaUtxoUpdateInput(
            flaggedForDelete: BoolFieldUpdateOperationsInput(
              set: true,
            ),
          ),
          where: PrismaUtxoWhereUniqueInput(id: utxo.id),
        );
      }

      await transaction.$commitTransaction();
    } catch (e) {
      await transaction.$rollbackTransaction();

      _logger.e(e.toString());
      throw Exception(e.toString());
    }
  }

  Future<List<String>> getAddressHistory(
    String address,
    bool ascending,
  ) async {
    final addrInIsar = await _prisma.prismaAddress.findFirst(
      where: PrismaAddressWhereInput(
        address: StringFilter(equals: address),
      ),
    );
    if (addrInIsar != null && addrInIsar.utxoHistory != null) {
      List<Map> responseUnsorted = [];
      for (var tx in addrInIsar.utxoHistory!) {
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
    final res = await _prisma.prismaUtxo.findMany(
      where: PrismaUtxoWhereInput(
        addresses: StringNullableListFilter(
          has: address,
        ),
      ),
    ); //TODO count in DB

    if (res.isNotEmpty) {
      return res.length;
    }
    return 0;
  }

  Future<List<String>> getAddressUtxos(
    String address,
    bool ascending,
  ) async {
    final res = await _prisma.prismaUtxo.findMany(
      where: PrismaUtxoWhereInput(
        addresses: StringNullableListFilter(
          has: address,
        ),
      ),
    );
    if (res.isNotEmpty) {
      List<Map> responseUnsorted = [];
      for (var utxo in res) {
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
    final addrInIsar = await _prisma.prismaAddress.findFirst(
      where: PrismaAddressWhereInput(
        address: StringFilter(equals: address),
      ),
    );

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
      var block = await _prisma.prismaBlock.findFirst(
        where: PrismaBlockWhereInput(
          id: IntFilter(equals: height),
        ),
      );
      if (block != null) {
        return block.hash;
      }
    } catch (e) {
      _logger.e(e.toString());
    }
    return '';
  }

  Future<int> getHeightInPrisma() async {
    try {
      final res = await _prisma.$queryRaw('SELECT COUNT(*) FROM "PrismaBlock"');
      Map map = res.first;
      return (map["count"] as BigInt).toInt();
    } catch (e) {
      _logger.e(e.toString());
      throw Exception(e.toString());
    }
  }

  Future<int> getNumberOfAddressesThatNeedUpdating() async {
    return await _prisma.prismaAddress
        .findMany(
            where: PrismaAddressWhereInput(
          needsUpdating: BoolFilter(equals: true),
        ))
        .then(
          (value) => value.length,
        ); //TODO count in DB
  }

  Future<bool> getIsAddressKnown(String address) async {
    if (await _prisma.prismaAddress.findFirst(
          where: PrismaAddressWhereInput(
            address: StringFilter(equals: address),
          ),
        ) ==
        null) {
      return false;
    }
    return true;
  }

  Future<void> init() async {
    //open db connection
    _logger.i('Init Prisma');

    /* */
    _prisma = PrismaClient(
      stdout: Event.values, // print all events to the console
      datasources: Datasources(
        db: Platform.environment['DATABASE_URL'],
      ),
    );

    _logger.i('Prisma init complete');

    //intercept SIGTERM
    ProcessSignal.sigterm.watch().listen(
      (event) async {
        LoggerWrapper().logger.i('Prisma SIGTERM received');
        await _prisma.$disconnect();
      },
    );
  }

  void initWithPrismaReference(PrismaClient prisma) {
    _prisma = prisma;
  }

  Future<PrismaUtxo?> _findUtxoByTxidAndTxpos({
    required PrismaClient client,
    required int txpos,
    required String txid,
  }) async {
    return await client.prismaUtxo.findFirst(
      where: PrismaUtxoWhereInput(
        AND: [
          PrismaUtxoWhereInput(
            txpos: IntFilter(equals: txpos),
          ),
          PrismaUtxoWhereInput(
            txid: StringFilter(equals: txid),
          )
        ],
      ),
    );
  }
}
