import 'package:stormberry/stormberry.dart';

part 'utxo.schema.dart';

@Model()
abstract class Utxo {
  @PrimaryKey()
  @AutoIncrement()
  int get id; //TODO combined unique index

  String get txid;
  int get txpos;
  double get value;
  int get block;
  List<String> get addresses;
  bool flaggedForDelete = false;
}
