class AddressModel {
  String address;
  String status;
  int confirmedBalance;
  int unconfirmedBalance;
  int numberOfUtxos;

  AddressModel({
    required this.address,
    this.status = "",
    this.confirmedBalance = 0,
    this.unconfirmedBalance = 0,
    this.numberOfUtxos = 0,
  });

  factory AddressModel.fromJson(Map json) {
    return AddressModel(
      address: json['address'],
      status: json['status'],
      confirmedBalance: json['confirmed_balance'],
      unconfirmedBalance: json['unconfirmed_balance'],
      numberOfUtxos: json['number_of_utxos'],
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
    };
  }
}
