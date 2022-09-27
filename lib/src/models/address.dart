import 'package:dart_utxo_server/src/models/utxo.dart';

class AddressModel {
  String address;
  List<Utxo> utxos = [];
  int balance = 0;

  AddressModel({
    required this.address,
  });

  Map toJson() {
    return {
      "address": address,
      "utxos": utxos,
      "balance": balance,
    };
  }
  //TODO relate tx for tx history
}
