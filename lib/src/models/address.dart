import 'package:isar/isar.dart';

part 'address.g.dart';

@collection
class AddressModel {
  int id;

  @Index(unique: true)
  String address;

  String status = "";

  int confirmedBalance = 0;
  int unconfirmedBalance = 0;

  bool needsUpdating = true;

  List<int> utxos = List.empty(growable: true);
  List<String> utxoHistory = List.empty(growable: true);

  AddressModel({
    required this.id,
    required this.address,
  });

  String toHashableString() {
    String str =
        '$address$confirmedBalance$unconfirmedBalance${utxoHistory.toString()}${utxos.toString()}}';

    return str;
  }
}
