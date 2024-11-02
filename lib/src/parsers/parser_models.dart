import 'package:marisma/src/models/address.dart';
import 'package:marisma/src/models/block.dart';
import 'package:marisma/src/models/utxo.dart';

class ParsedTx extends OrmWriteable {
  ParsedTx({
    required super.utxoToSpend,
    required super.addressesToCreate,
    required super.utxosToCreateOrUpdate,
  });
}

class ParsedBlock extends OrmWriteable {
  final Block block;

  ParsedBlock({
    required this.block,
    required super.utxoToSpend,
    required super.addressesToCreate,
    required super.utxosToCreateOrUpdate,
  });
}

class OrmWriteable {
  final List<(String, int)> utxoToSpend;
  final List<AddressModel> addressesToCreate;
  final List<Utxo> utxosToCreateOrUpdate;

  OrmWriteable({
    required this.utxoToSpend,
    required this.addressesToCreate,
    required this.utxosToCreateOrUpdate,
  });
}
