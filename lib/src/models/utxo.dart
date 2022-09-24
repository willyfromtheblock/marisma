class Utxo {
  String txid;
  int txpos;
  double value;
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
      "txpos": txpos,
      "value": value,
      "txid": txid,
      "hex": hex,
      "addresses": addresses.map((e) => "address:$e").toList(),
      "block": "block:$block"
    };
  }
//TODO provide confirmations in server, storing in db makes no sense
}
