class Tx {
  String txid;
  int block;
  String txData;

  Tx({
    required this.txid,
    required this.block,
    required this.txData,
  });

  Map toJson() {
    return {
      "txid": txid,
      "block": "block:$block",
      "tx_data": txData.toString(),
    };
  }
}
