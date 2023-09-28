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

  factory Utxo.fromJson(Map json) {
    return Utxo(
      txid: json['txid'],
      txpos: json['txpos'],
      value: json['value'],
      addresses: json['addresses'],
      block: json['block'],
    );
  }

  Map toJson() {
    return {
      "txpos": txpos,
      "value": value,
      "txid": txid,
      "addresses": addresses.map((e) => "address:$e").toList(),
      "block": "block:$block",
    };
  }
}
