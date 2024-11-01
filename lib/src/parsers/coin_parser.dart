import 'package:marisma/src/parsers/peercoin_parser.dart';

class CoinParser {
  Future<void> parseBlock(int currentBlockNumber) async {}
  Future<void> parseTx(Map txDecoded, int currentBlockNumber) async {}

  factory CoinParser.fromName(String name) {
    if (name == 'peercoin' || name == 'peercoinTestnet') {
      return PeercoinParser();
    } else {
      throw ArgumentError('Unsupported coin name: $name');
    }
  }
}
