class Utxo {
  String txid;
  int txpos;
  double value;
  int confirmations = 0;
  int block;
  String hex;
  List<String> addresses;

  Utxo({
    required this.txid,
    required this.txpos,
    required this.value,
    required this.hex,
    required this.addresses,
    required this.block,
  });

  Map toJson() {
    return {
      "confirmations": confirmations,
      "txpos": txpos,
      "value": value,
      "txid": txid,
      "hex": hex,
      "addresses": addresses.map((e) => "address:$e").toList(),
      "block": "block:$block"
    };
  }
}

//UTXOs als utxo:$hash-$txpos speichern
