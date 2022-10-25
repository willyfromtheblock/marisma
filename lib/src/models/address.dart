class AddressModel {
  String address;
  String status = "";
  int balance = 0;

  AddressModel({
    required this.address,
  });

  Map toJson() {
    return {
      "address": address,
      "balance": "",
      "status": "",
    };
  }
}
