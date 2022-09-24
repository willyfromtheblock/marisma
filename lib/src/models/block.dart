class Block {
  int height;
  String hash;

  Block({
    required this.height,
    required this.hash,
  });

  Map toJson() {
    return {
      "height": height,
      "hash": hash,
    };
  }
}

//blocks als block:height speichern