import 'package:isar/isar.dart';
import 'package:marisma/src/models/tx.dart';
part 'block.g.dart';

@collection
class Block {
  Id id;
  String hash;
  int blocktime;
  final transactions = IsarLinks<Tx>();

  Block({
    required this.id,
    required this.hash,
    required this.blocktime,
  });
}
