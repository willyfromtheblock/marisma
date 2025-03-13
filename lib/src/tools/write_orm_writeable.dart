import 'package:marisma/src/orm/surreal_orm.dart';
import 'package:marisma/src/parsers/parser_models.dart';

Future<void> writeOrmWriteable(
  SurrealORM orm,
  OrmWriteable parsed,
) =>
    Future.wait([
      ...parsed.addressesToCreate.map(orm.createAddress),
      ...parsed.utxosToCreateOrUpdate
          .map((utxo) => orm.createOrUpdateUtxo(utxo: utxo)),
      ...parsed.utxoToSpend.map(
        (utxo) => orm.spendUtxo(utxoId: utxo.$1, blockHeight: utxo.$2),
      ),
    ]);
