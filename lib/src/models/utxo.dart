class Utxo {
  String txid;
  int txpos;
  double value;
  int block;
  List<String> addresses;
  int spentOnBlock = -1;

  Utxo({
    required this.txid,
    required this.txpos,
    required this.value,
    required this.addresses,
    required this.block,
    required this.spentOnBlock,
  });

  factory Utxo.fromJson(Map json) {
    final filteredAddresses = <String>[];
    for (var address in json["addresses"]) {
      filteredAddresses.add(address.toString().replaceAll('address:', ''));
    }

    final blockInt = json["block"].toString().replaceAll('block:', ''),
        block = blockInt.isEmpty ? 0 : int.parse(blockInt);

    final spentOnBlockInt =
            json["spent_on_block"].toString().replaceAll('block:', ''),
        spentOnBlock = spentOnBlockInt.isEmpty ? 0 : int.parse(spentOnBlockInt);

    return Utxo(
      txid: json['txid'],
      txpos: json['txpos'],
      value: json["value"],
      addresses: filteredAddresses,
      block: block,
      spentOnBlock: spentOnBlock,
    );
  }

  Map toJson() {
    return {
      "txpos": txpos,
      "value": value,
      "txid": txid,
      "addresses": addresses.map((e) => "address:$e").toList(),
      "block": "block:$block",
      "spent_on_block": "block:$spentOnBlock",
    };
  }

  Map toGRPCReplyJson() {
    return {
      "txid": txid,
      "tx_pos": txpos,
      "value": value,
      "block": block,
    };
  }
}
