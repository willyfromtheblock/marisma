import 'dart:convert';

import 'package:isar/isar.dart';

part 'utxo.g.dart';

@collection
class Utxo {
  int id;

  @Index(composite: [
    'txpos'
  ], unique: true) //TODO wait for isar v4 implementation to use composite index
  String txid;

  int txpos;
  double value;
  int block;
  List<String> addresses;
  bool flaggedForDelete = false;

  Utxo({
    required this.id,
    required this.txid,
    required this.txpos,
    required this.value,
    required this.addresses,
    required this.block,
  });

  Map toMap() {
    return {
      "txid": txid,
      "tx_pos": txpos,
      "value": value,
      "block": block,
    };
  }

  String toJson() {
    return jsonEncode(toMap());
  }
}
