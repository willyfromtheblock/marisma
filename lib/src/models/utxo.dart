class Utxo {
  String txid;
  int txpos;
  double value;
  int block;
  List<String> addresses;

  Utxo({
    required this.txid,
    required this.txpos,
    required this.value,
    required this.addresses,
    required this.block,
  });

  Map toJson() {
    return {
      "txpos": txpos, //TODO consider renaming to index
      "value": value,
      "txid": 'tx:$txid',
      "addresses": addresses.map((e) => "address:$e").toList(),
      "block": "block:$block",
    };
  }
}
