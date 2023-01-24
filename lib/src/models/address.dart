import 'package:isar/isar.dart';

import 'tx.dart';
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

  final utxos = IsarLinks<Utxo>();
  final transactions = IsarLinks<Tx>();

  AddressModel({
    required this.address,
  });

  String toHashableString() {
    String str = '$address$confirmedBalance$unconfirmedBalance';
    for (var element in utxos) {
      str += element.txid + element.txpos.toString();
    }

    return str;
  }
}
