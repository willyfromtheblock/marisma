import 'package:marisma/src/models/address.dart';
import 'package:marisma/src/models/block.dart';
import 'package:marisma/src/models/utxo.dart';

class ParsedTx {
  final List<(String, int)> utxoToSpend;
  final List<AddressModel> addressesToCreate;
  final List<Utxo> utxosToCreateOrUpdate;

  ParsedTx({
    required this.utxoToSpend,
    required this.addressesToCreate,
    required this.utxosToCreateOrUpdate,
  });
}

class ParsedBlock {
  final Block block;
  final List<(String, int)> utxoToSpend;
  final List<AddressModel> addressesToCreate;
  final List<Utxo> utxosToCreateOrUpdate;

  ParsedBlock({
    required this.block,
    required this.utxoToSpend,
    required this.addressesToCreate,
    required this.utxosToCreateOrUpdate,
  });
}
