import 'package:isar/isar.dart';

import 'utxo.dart';

part 'address.g.dart';

@collection
class AddressModel {
  Id id = Isar.autoIncrement;

  @Index(unique: true)
  String address;

  String status = "";

  int confirmedBalance = 0;
  int unconfirmedBalance = 0;

  bool needsUpdating = true;

  final utxos = IsarLinks<Utxo>();
  List<String> utxoHistory = List.empty(growable: true);

  AddressModel({
    required this.address,
  });

  String toHashableString() {
    String str =
        '$address$confirmedBalance$unconfirmedBalance${utxoHistory.toString()}';
    for (var element in utxos) {
      str += element.txid + element.txpos.toString();
    }

    return str;
  }
}
