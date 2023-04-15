import 'package:stormberry/stormberry.dart';

import 'utxo.dart';

part 'address.schema.dart';

@Model()
abstract class AddressModel {
  @PrimaryKey()
  String get address;

  String get status;

  int get confirmedBalance;
  int get unconfirmedBalance;

  bool needsUpdating = true;

  List<Utxo> get utxos;
  List<String> get utxoHistory;

  String toHashableString() {
    String str =
        '$address$confirmedBalance$unconfirmedBalance${utxoHistory.toString()}';
    for (var element in utxos) {
      str += element.txid + element.txpos.toString();
    }

    return str;
  }
}
