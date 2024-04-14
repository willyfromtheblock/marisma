class Block {
  int height;
  String hash;
  int time;

  Block({
    required this.height,
    required this.hash,
    required this.time,
  });

  Map toJson() {
    return {
      "height": height,
      "hash": hash,
      "time": time,
    };
  }
}
