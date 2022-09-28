class AddressModel {
  String address;
  int balance = 0;

  AddressModel({
    required this.address,
  });

  Map toJson() {
    return {
      "address": address,
      "balance": balance,
    };
  }
}
