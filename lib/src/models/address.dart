class AddressModel {
  String address;
  String status;
  int confirmedBalance;
  int unconfirmedBalance;
  int numberOfUtxos;
  bool needsUpdate;

  AddressModel({
    required this.address,
    this.status = "",
    this.confirmedBalance = 0,
    this.unconfirmedBalance = 0,
    this.numberOfUtxos = 0,
    this.needsUpdate = true,
  });

  factory AddressModel.fromJson(Map json) {
    return AddressModel(
      address: json['address'],
      status: json['status'],
      confirmedBalance: json['confirmed_balance'],
      unconfirmedBalance: json['unconfirmed_balance'],
      numberOfUtxos: json['number_of_utxos'],
      needsUpdate: json['needs_update'],
    );
  }

  Map toJson() {
    return {
      "address": address,
      "id": "address:$address",
      "status": status,
      "confirmed_balance": confirmedBalance,
      "unconfirmed_balance": unconfirmedBalance,
      "number_of_utxos": numberOfUtxos,
      "needs_update": needsUpdate,
    };
  }
}
