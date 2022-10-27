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
    AddressRequest request,
  ) async {
    var res = await SurrealORM().getBalanceForAddress(request.address);
    return AddressBalanceReply()
      ..balance = Int64((res * getDecimalProduct()).toInt());
  }

  @override
  Future<AddressUtxoListReply> getAddressUtxoList(
    ServiceCall call,
    AddressRequest request,
  ) async {
    return AddressUtxoListReply()
      ..utxos = await SurrealORM().getAdressUtxos(
        request.address,
        getDecimalProduct(),
      );
  }

  @override
  Future<AddressHasUtxosReply> getAddressHasUtxos(
    ServiceCall call,
    AddressRequest request,
  ) async {
    return AddressHasUtxosReply()
      ..hasUtxos = await SurrealORM().getHasAddressUtxos(
        request.address,
      );
  }

  @override
  Future<AddressHistoryReply> getAddressHistory(
    ServiceCall call,
    AddressHistoryRequest request,
  ) async {
    return AddressHistoryReply(
      history: await SurrealORM().getAddressHistory(
        request.address,
        request.ascending,
      ),
    );
  }

  @override
  Future<TxReply> getTransaction(
    ServiceCall call,
    TxRequest request,
  ) async {
    return TxReply()..tx = await SurrealORM().getRawTx(request.txid);
  }

  @override
  Stream<TestStreamReply> subscribeTestStream(
      ServiceCall call, TestStreamRequest request) async* {
    do {
      yield TestStreamReply()..name = "stream reply";
      await Future.delayed(Duration(seconds: 5));
    } while (!call.isTimedOut && !call.isCanceled);
    print('done');
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
  //TODO error handling
  //TODO tests
}
