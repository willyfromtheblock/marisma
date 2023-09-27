class Block {
  int height;
  String hash;
  int blocktime;

  Block({
    required this.height,
    required this.hash,
    required this.blocktime,
  });

  Map toJson() {
    return {
      "height": height,
      "hash": hash,
      "blocktime": blocktime,
    };
  }
}
