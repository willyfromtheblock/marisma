import 'dart:io';

import 'package:grpc/grpc.dart';
import 'package:marisma/src/orm/surreal_orm.dart';

import '../generated/marisma.pbgrpc.dart';

Map<String, String> env = Platform.environment;

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
    port: int.parse(env["GRPC_PORT"]!),
  );
  print('gRPC Server listening on port ${server.port}...');
  //TODO ERROR HANDLING
}
