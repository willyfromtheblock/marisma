class Utxo {
  String txid;
  int txpos;
  double value;
  int block;
  String address;
  int spentOnBlock =
      -2; // -2 = unspent, -1 = spent in mempool, 0+ = spent on block

  Utxo({
    required this.txid,
    required this.txpos,
    required this.value,
    required this.address,
    required this.block,
    required this.spentOnBlock,
  });

  factory Utxo.fromJson(Map json) {
    final filteredAddress = json["address"].replaceAll('address:', '');

    final blockInt = json["block"].toString().replaceAll('block:', ''),
        block = blockInt.isEmpty ? 0 : int.parse(blockInt);

    final spentOnBlockInt =
            json["spent_on_block"].toString().replaceAll('block:', ''),
        spentOnBlock = spentOnBlockInt.isEmpty ? 0 : int.parse(spentOnBlockInt);

    return Utxo(
      txid: json['txid'],
      txpos: json['txpos'],
      value: json["value"],
      address: filteredAddress,
      block: block,
      spentOnBlock: spentOnBlock,
    );
  }

  Map toJson() {
    return {
      "txpos": txpos,
      "value": value,
      "txid": txid,
      "address": "address:$address",
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
