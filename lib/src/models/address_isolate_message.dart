import 'utxo.dart';

class AddressIsolateMessage {
  final String address;
  final Utxo utxo;
  final bool spent;

  AddressIsolateMessage({
    required this.address,
    required this.utxo,
    required this.spent,
  });
}
