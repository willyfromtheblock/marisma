import 'package:coinlib/coinlib.dart';

/// Returns true if the address is valid for the given network.
bool validateAddress(String address, NetworkParams network) {
  try {
    Address.fromString(address, network);
    return true;
  } catch (e) {
    return false;
  }
}
