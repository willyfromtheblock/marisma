import 'package:isar/isar.dart';
import 'package:marisma/src/models/tx.dart';
import 'package:marisma/src/models/utxo.dart';

part 'address.g.dart';

@collection
class AddressModel {
  Id id = Isar.autoIncrement;

  @Index(unique: true)
  String address;

  String status = ""; //TODO

  int balance = 0;

  final utxos = IsarLinks<Utxo>();
  final transactions = IsarLinks<Tx>();

  AddressModel({
    required this.address,
  });
}
