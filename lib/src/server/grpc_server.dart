import 'dart:io';
import 'dart:math';

import 'package:fixnum/fixnum.dart';
import 'package:grpc/grpc.dart';

import '../generated/marisma.pbgrpc.dart';
import '../orm/surreal_orm.dart';
import '../tools/logger.dart';

final _logger = LoggerWrapper().logger;
Map<String, String> env = Platform.environment;

class MarismaGRPCServer extends MarismaServiceBase {
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
    var res = await SurrealORM().getBalanceForAddress(request.address);
    return AddressBalanceReply()
      ..balance = res
      ..balanceSats = Int64((res * getDecimalProduct()).toInt());
  }

  @override
  Future<AddressUtxosReply> getAddressUtxos(
    ServiceCall call,
    AddressUtxosRequest request,
  ) async {
    return AddressUtxosReply()
      ..utxos = await SurrealORM().getAdressUtxos(
        request.address,
        getDecimalProduct(),
      );
  }
}

int getDecimalProduct() {
  return pow(10, 6).toInt();
}

Future<void> serve() async {
  final server = Server(
    [MarismaGRPCServer()],
    const <Interceptor>[],
    CodecRegistry(
      codecs: const [
        GzipCodec(),
      ],
    ),
  );

  await server.serve(
    address: "0.0.0.0",
    port: int.parse(env["GRPC_PORT"]!),
  );
  _logger.i('gRPC Server listening on port ${server.port}...');
  //TODO ERROR HANDLING
}
