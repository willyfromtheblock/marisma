import '../tools/decimal_product.dart';

class Utxo {
  String txid;
  int txpos;
  double value;
  int block;
  List<String> addresses;
  bool spent;

  Utxo({
    required this.txid,
    required this.txpos,
    required this.value,
    required this.addresses,
    required this.block,
    required this.spent,
  });

  factory Utxo.fromJson(Map json) {
    final filteredAddresses = <String>[];
    for (var address in json["addresses"]) {
      filteredAddresses.add(address.toString().replaceAll('address:', ''));
    }

    final blockInt = json["block"].toString().replaceAll('block:', ''),
        block = blockInt.isEmpty ? 0 : int.parse(blockInt);

    return Utxo(
      txid: json['txid'],
      txpos: json['txpos'],
      value: (json["value"] ?? 0) * getDecimalProduct().toInt(),
      addresses: filteredAddresses,
      block: block,
      spent: json['spent'],
    );
  }

  Map toJson() {
    return {
      "txpos": txpos,
      "value": value,
      "txid": txid,
      "addresses": addresses.map((e) => "address:$e").toList(),
      "block": "block:$block",
      "spent": spent,
    };
  }
}
