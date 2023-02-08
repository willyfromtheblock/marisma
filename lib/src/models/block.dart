import 'package:isar/isar.dart';

part 'block.g.dart';

@collection
class Block {
  Id id;
  String hash;
  int blocktime;

  Block({
    required this.id,
    required this.hash,
    required this.blocktime,
  });
}
