class Tx {
  String txid;
  int block;

  Tx({
    required this.txid,
    required this.block,
  });

  Map toJson() {
    return {
      "txid": txid,
      "block": "block:$block",
    };
  }
}
