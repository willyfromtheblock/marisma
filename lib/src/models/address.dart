import 'package:dart_utxo_server/src/models/utxo.dart';

class Address {
  String address;
  List<Utxo> utxos;
  int balance;
  Address({
    required this.address,
    required this.utxos,
    required this.balance,
  });

  Map toJson() {
    return {
      "address": address,
      "utxos": utxos,
      "balance": balance,
    };
  }
}
