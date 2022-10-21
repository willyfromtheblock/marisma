import 'dart:io';

import 'package:grpc/grpc.dart';

import '../generated/marisma.pbgrpc.dart';
import '../orm/surreal_orm.dart';
import '../tools/logger.dart';

Map<String, String> env = Platform.environment;
final _logger = LoggerWrapper().logger;

class MarismaServer extends MarismaServerServiceBase {
  @override
  Future<BlockHeightReply> getBlockHeight(
    ServiceCall call,
    BlockHeightRequest request,
  ) async {
    return BlockHeightReply()
      ..height = await SurrealORM().getHeightInSurrealDB();
  }

  @override
  Future<AddressBalanceReply> getAdressBalance(
    ServiceCall call,
    AddressBalanceRequest request,
  ) async {
    return AddressBalanceReply()
      ..balance = await SurrealORM().getBalanceForAddress(request.address);
  }
}

Future<void> serve() async {
  final server = Server(
    [MarismaServer()],
    const <Interceptor>[],
    CodecRegistry(codecs: const [
      GzipCodec(),
    ]),
  );
  await server.serve(
    address: "0.0.0.0",
    port: int.parse(env["GRPC_PORT"]!),
  );
  _logger.i('gRPC Server listening on port ${server.port}...');
  //TODO ERROR HANDLING
  //TODO SSL
}
