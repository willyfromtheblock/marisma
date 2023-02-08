import 'dart:convert';

import 'package:isar/isar.dart';

part 'utxo.g.dart';

@collection
class Utxo {
  Id id = Isar.autoIncrement;

  @Index(composite: [CompositeIndex('txpos')], unique: true)
  String txid;

  int txpos;

  double value;

  int block;

  List<String> addresses;

  bool flaggedForDelete = false;

  Utxo({
    required this.txid,
    required this.txpos,
    required this.value,
    required this.addresses,
    required this.block,
  });

  String toJson() {
    return jsonEncode({
      "txid": txid,
      "tx_pos": txpos,
      "value": value,
      "block": block,
    });
  }
}
