class AddressModel {
  String address;
  String status;
  int confirmedBalance;
  int unconfirmedBalance;
  bool needsUpdate;

  AddressModel({
    required this.address,
    this.status = "",
    this.confirmedBalance = 0,
    this.unconfirmedBalance = 0,
    this.needsUpdate = false,
  });

  factory AddressModel.fromJson(Map json) {
    return AddressModel(
      address: json['address'],
      status: json['status'],
      confirmedBalance: json['confirmed_balance'],
      unconfirmedBalance: json['unconfirmed_balance'],
      needsUpdate: json['needs_update'],
    );
  }

  Map toJson() {
    return {
      "address": address,
      "status": status,
      "confirmed_balance": confirmedBalance,
      "unconfirmed_balance": unconfirmedBalance,
      "needs_update": needsUpdate,
    };
  }
}
