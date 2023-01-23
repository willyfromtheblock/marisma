import 'package:isar/isar.dart';

part 'tx.g.dart';

@collection
class Tx {
  Id id = Isar.autoIncrement;

  @Index(unique: true)
  String txid;

  int block;

  String rawTx;

  Tx({
    required this.txid,
    required this.block,
    required this.rawTx,
  });
}
