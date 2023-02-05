import 'package:isar/isar.dart';

part 'utxo.g.dart';

@collection
class Utxo {
  Id id = Isar.autoIncrement;

  @Index(composite: [CompositeIndex('txpos')])
  String txid;

  int txpos;

  double value;

  int block;

  List<String> addresses;

  Utxo({
    required this.txid,
    required this.txpos,
    required this.value,
    required this.addresses,
    required this.block,
  });
}
