import 'package:marisma/src/parsers/parser_models.dart';
import 'package:marisma/src/parsers/peercoin_parser.dart';

class CoinParser {
  Future<ParsedBlock> parseBlock(int currentBlockNumber) async {
    throw UnimplementedError('parseBlock is not yet implemented');
  }

  Future<ParsedTx> parseTx(Map txDecoded, int currentBlockNumber) async {
    throw UnimplementedError('parseTx is not yet implemented');
  }

  factory CoinParser.fromName(String name) => switch (name) {
        "peercoin" || "peercoinTestnet" => PeercoinParser(),
        _ => throw ArgumentError('Unsupported coin name: $name'),
      };
}
