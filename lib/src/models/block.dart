import 'package:stormberry/stormberry.dart';

part 'block.schema.dart';

@Model()
abstract class Block {
  @PrimaryKey()
  int get id;
  String get hash;
  int get blocktime;
}
