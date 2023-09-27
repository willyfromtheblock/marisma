class AddressModel {
  String address;
  String status;
  int confirmedBalance;
  int unconfirmedBalance;

  AddressModel({
    required this.address,
    this.status = "",
    this.confirmedBalance = 0,
    this.unconfirmedBalance = 0,
  });

  factory AddressModel.fromJson(Map json) {
    return AddressModel(
      address: json['address'],
      status: json['status'],
      confirmedBalance: json['confirmed_balance'],
      unconfirmedBalance: json['unconfirmed_balance'],
    );
  }

  Map toJson() {
    return {
      "address": address,
      "confirmedBalance": confirmedBalance,
      "unconfirmedBalance": unconfirmedBalance,
      "status": "",
    };
  }
}
