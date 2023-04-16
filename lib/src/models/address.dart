import 'package:stormberry/stormberry.dart';

import 'utxo.dart';

part 'address.schema.dart';

@Model()
abstract class Address {
  @PrimaryKey()
  String get address;

  String get status;

  int get confirmedBalance;
  int get unconfirmedBalance;

  bool needsUpdating = true;

  List<String> get utxoHistory;

  String toHashableString() {
    String str =
        '$address$confirmedBalance$unconfirmedBalance${utxoHistory.toString()}';

    return str;
  }
}
