class AddressModel {
  String address;
  String status = "";
  int confirmedBalance = 0;
  int unconfirmedBalance = 0;

  AddressModel({
    required this.address,
  });

  Map toJson() {
    return {
      "address": address,
      "confirmedBalance": confirmedBalance,
      "unconfirmedBalance": unconfirmedBalance,
      "status": "",
    };
  }
}
