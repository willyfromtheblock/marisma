import 'package:marisma/src/parsers/parser_models.dart';
import 'package:marisma/src/parsers/peercoin_parser.dart';

class CoinParser {
  Future<ParsedBlock> parseBlock(int currentBlockNumber) async {
    throw UnimplementedError('parseBlock is not yet implemented');
  }

  Future<void> parseTx(Map txDecoded, int currentBlockNumber) async {}

  factory CoinParser.fromName(String name) {
    if (name == 'peercoin' || name == 'peercoinTestnet') {
      return PeercoinParser();
    } else {
      throw ArgumentError('Unsupported coin name: $name');
    }
  }
}
