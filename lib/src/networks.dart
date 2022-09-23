import 'package:coinslib/coinslib.dart';

final Map<String, NetworkType> availableNetworks = {
  "peercoin": NetworkType(
    messagePrefix: 'Peercoin Signed Message:\n',
    bech32: 'pc',
    bip32: Bip32Type(public: 0x043587cf, private: 0x04358394),
    pubKeyHash: 0x37,
    scriptHash: 0x75,
    wif: 0xb7,
    opreturnSize: 256,
  ),
  "peercoinTestnet": NetworkType(
    messagePrefix: 'Peercoin Signed Message:\n',
    bech32: 'tpc',
    bip32: Bip32Type(public: 0x043587cf, private: 0x04358394),
    pubKeyHash: 0x6f,
    scriptHash: 0xc4,
    wif: 0xef,
    opreturnSize: 256,
  ),
};
