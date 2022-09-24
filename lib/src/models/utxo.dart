import 'package:coinslib/coinslib.dart';

class Utxo {
  String hash;
  int txpos;
  int value;
  int confirmations;
  int blockheight;
  String hex;
  Address address;

  Utxo({
    required this.confirmations,
    required this.hash,
    required this.txpos,
    required this.value,
    required this.hex,
    required this.address,
    required this.blockheight,
  });

  Map toJson() {
    return {
      "confirmations": confirmations,
      "txpos": txpos,
      "value": value,
      "hash": hash,
      "hex": hex,
      "address": address,
      "blockheight": blockheight
    };
  }
}

//UTXOs als utxo:$hash-$txpos speichern
