import 'dart:convert';
import 'dart:io';

import '../generated/prisma/prisma_client.dart';
import '../tools/logger.dart';

class PrismaORM {
  static final Map<String, PrismaORM> _cache = <String, PrismaORM>{};
  late PrismaClient _prisma;
  final _logger = LoggerWrapper().logger;
  Map<String, String> env = Platform.environment;
  final _globalTransactionTimeOut = Duration(minutes: 1);

  factory PrismaORM() {
    return _cache.putIfAbsent('prisma', () => PrismaORM._internal());
  }
  PrismaORM._internal();

  Future<void> createBlock(PrismaBlockCreateInput block) async {
    final transaction = await _prisma.$startTransaction(
      timeout: _globalTransactionTimeOut,
      maxWait: _globalTransactionTimeOut,
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
      maxWait: _globalTransactionTimeOut,
    );
    try {
      final addressInPrisma = await transaction.prismaAddress.findUnique(
        where: PrismaAddressWhereUniqueInput(
          address: addr.address,
        ),
      );
      //check if already exists

      if (addressInPrisma == null) {
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
      maxWait: _globalTransactionTimeOut,
    );

    try {
      final utxoInDb = await _findUtxoByTxidAndTxpos(
        client: transaction,
        txPos: utxo.txpos,
        txId: utxo.txid,
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
              where: PrismaUtxoWhereUniqueInput(
                txidTxpos: PrismaUtxoTxidTxposCompoundUniqueInput(
                  txid: utxo.txid,
                  txpos: utxo.txpos,
                ),
              ),
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
          final addrInPrisma = await transaction.prismaAddress.findUnique(
            where: PrismaAddressWhereUniqueInput(
              address: addr,
            ),
          );

          if (addrInPrisma != null) {
            await transaction.prismaAddress.update(
              data: PrismaAddressUpdateInput(
                needsUpdating: BoolFieldUpdateOperationsInput(set: true),
              ),
              where: PrismaAddressWhereUniqueInput(
                address: addrInPrisma.address,
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

  Future<void> deleteUtxo({
    required String utxoTxId,
    required int txPos,
  }) async {
    final transaction = await _prisma.$startTransaction(
      timeout: _globalTransactionTimeOut,
      maxWait: _globalTransactionTimeOut,
    );

    try {
      await transaction.prismaUtxo.deleteMany(
        where: PrismaUtxoWhereInput(
          AND: [
            PrismaUtxoWhereInput(
              txpos: IntFilter(equals: txPos),
            ),
            PrismaUtxoWhereInput(
              txid: StringFilter(equals: utxoTxId),
            )
          ],
        ),
      );

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
    final addrInPrisma = await _prisma.prismaAddress.findUnique(
      where: PrismaAddressWhereUniqueInput(
        address: address,
      ),
    );
    if (addrInPrisma != null && addrInPrisma.utxoHistory != null) {
      List<Map> responseUnsorted = [];
      for (var tx in addrInPrisma.utxoHistory!) {
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
    final addrInPrisma = await _prisma.prismaAddress.findUnique(
      where: PrismaAddressWhereUniqueInput(
        address: address,
      ),
    );

    if (addrInPrisma != null) {
      return {
        "confirmed": addrInPrisma.confirmedBalance,
        "unconfirmed": addrInPrisma.unconfirmedBalance,
      };
    }
    return {
      "confirmed": 0,
      "unconfirmed": 0,
    };
  }

  Future<String> getBlockHash(int height) async {
    return await _prisma.$transaction(
      (transaction) async {
        try {
          var block = await _prisma.prismaBlock.findUnique(
            where: PrismaBlockWhereUniqueInput(
              id: height,
            ),
          );
          if (block != null) {
            return block.hash;
          }
        } catch (e) {
          _logger.e(e.toString());
        }
        return '';
      },
      maxWait: _globalTransactionTimeOut,
      timeout: _globalTransactionTimeOut,
    );
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
    if (await _prisma.prismaAddress.findUnique(
          where: PrismaAddressWhereUniqueInput(
            address: address,
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

    _prisma = PrismaClient(
      datasources: Datasources(
        db: Platform.environment['DATABASE_URL'],
      ),
    );

    _logger.i('Prisma init complete');
  }

  void initWithPrismaReference(PrismaClient prisma) {
    _prisma = prisma;
  }

  Future<PrismaUtxo?> _findUtxoByTxidAndTxpos({
    required PrismaClient client,
    required int txPos,
    required String txId,
  }) async {
    return await client.prismaUtxo.findFirst(
      where: PrismaUtxoWhereInput(
        AND: [
          PrismaUtxoWhereInput(
            txpos: IntFilter(equals: txPos),
          ),
          PrismaUtxoWhereInput(
            txid: StringFilter(equals: txId),
          )
        ],
      ),
    );
  }
}
