class Tx {
  String txid;
  int block;
  Map txData;

  Tx({
    required this.txid,
    required this.txData,
    required this.block,
  });

  Map toJson() {
    return {
      "txid": txid,
      "block": "block:$block",
      "tx_data": txData.toString(),
    };
  }
}
