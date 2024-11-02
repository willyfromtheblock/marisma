import 'package:marisma/src/orm/surreal_orm.dart';
import 'package:marisma/src/parsers/parser_models.dart';

Future<void> writeOrmWriteable(
  SurrealORM orm,
  OrmWriteable parsed,
) async {
  List<Future<void>> futures = [];

  for (var address in parsed.addressesToCreate) {
    futures.add(orm.createAddress(address));
  }

  for (var utxo in parsed.utxosToCreateOrUpdate) {
    futures.add(orm.createOrUpdateUtxo(utxo: utxo));
  }

  for (var utxo in parsed.utxoToSpend) {
    final (id, height) = utxo;
    futures.add(orm.spendUtxo(
      utxoId: id,
      blockHeight: height,
    ));
  }

  await Future.wait(futures);
}
