import 'dart:async';
import 'dart:io';
import 'dart:math';

import 'package:coinslib/coinslib.dart';
import 'package:dart_coin_rpc/dart_coin_rpc.dart';
import 'package:fixnum/fixnum.dart';
import 'package:grpc/grpc.dart';
import 'package:marisma/src/networks.dart' as networks;
import 'package:marisma/src/rpc_client/client_rpc.dart';

import '../generated/marisma.pbgrpc.dart';
import '../orm/surreal_orm.dart';
import '../tools/logger.dart';

Map<String, String> env = Platform.environment;
final _logger = LoggerWrapper().logger;
late RPCClient _clientRPC;

int getDecimalProduct() {
  return pow(10, 6).toInt();
}

Future<void> connectToRpc() async {
  try {
    _clientRPC = ClientRPC();
    _logger.i(
      'Server isolate - connected to ${env['COIN_NAME']} RPC',
    );
  } catch (e) {
    _logger.e(
      'Server isolate - error connecting to RPC: ${e.toString()}',
    );
    await Future.delayed(
      Duration(seconds: 5),
      () async => await connectToRpc(),
    );
    return;
  }
}

bool isValidAddress(String address) {
  return Address.validateAddress(
    address,
    networks.availableNetworks[Platform.environment["COIN_NAME"]],
  );
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

  //init logger in isolate
  LoggerWrapper().init();

  //init orm in isolate
  await SurrealORM().init(true);

  //init RPC Client
  await connectToRpc();

  await server.serve(
    address: "0.0.0.0",
    port: int.parse(env["GRPC_PORT"]!),
  );
  _logger.i('gRPC Server listening on port ${server.port}...');
  //TODO error handling
  //TODO tests
}

class MarismaGRPCServer extends MarismaServiceBase {
  @override
  Future<AddressHasUtxosReply> getAddressHasUtxos(
    ServiceCall call,
    AddressRequest request,
  ) async {
    if (isValidAddress(request.address)) {
      return AddressHasUtxosReply()
        ..hasUtxos = await SurrealORM().getHasAddressNumberOfUtxos(
              request.address,
            ) !=
            0;
    }
    return AddressHasUtxosReply()..hasUtxos = false;
  }

  @override
  Future<AddressHistoryReply> getAddressHistory(
    ServiceCall call,
    AddressListRequest request,
  ) async {
    if (isValidAddress(request.address)) {
      return AddressHistoryReply(
        history: await SurrealORM().getAddressHistory(
          request.address,
          request.ascending,
        ),
      );
    }
    return AddressHistoryReply(history: []);
  }

  @override
  Future<AddressNumberOfUtxosReply> getAddressNumberOfUtxos(
    ServiceCall call,
    AddressRequest request,
  ) async {
    if (isValidAddress(request.address)) {
      return AddressNumberOfUtxosReply()
        ..n = await SurrealORM().getHasAddressNumberOfUtxos(
          request.address,
        );
    }
    return AddressNumberOfUtxosReply()..n = 0;
  }

  @override
  Future<AddressUtxoListReply> getAddressUtxoList(
    ServiceCall call,
    AddressListRequest request,
  ) async {
    if (isValidAddress(request.address)) {
      return AddressUtxoListReply()
        ..utxos = await SurrealORM().getAdressUtxos(
          request.address,
          getDecimalProduct(),
          request.ascending,
        );
    }
    return AddressUtxoListReply()..utxos = "";
  }

  @override
  Future<AddressBalanceReply> getAdressBalance(
    ServiceCall call,
    AddressRequest request,
  ) async {
    if (isValidAddress(request.address)) {
      var res = await SurrealORM().getBalanceForAddress(request.address);
      return AddressBalanceReply()
        ..balance = Int64((res * getDecimalProduct()).toInt());
    }
    return AddressBalanceReply()..balance = Int64(0);
  }

  @override
  Future<BlockHeightReply> getBlockHeight(
    ServiceCall call,
    BlockHeightRequest request,
  ) async {
    return BlockHeightReply()
      ..height = await SurrealORM().getHeightInSurrealDB();
  }

  @override
  Future<TxReply> getTransaction(
    ServiceCall call,
    TxRequest request,
  ) async {
    return TxReply()..tx = await SurrealORM().getRawTx(request.txid);
  }

  @override
  Future<BroadCastTransactionReply> broadCastTransaction(
    ServiceCall call,
    BroadCastTransactionRequest request,
  ) async {
    dynamic res;
    try {
      res = await _clientRPC.call('sendrawtransaction', [request.hex]);
    } catch (e) {
      _logger.d("${request.hex} ${e.toString()}");
      return BroadCastTransactionReply()
        ..txid = ""
        ..rpcError = e.toString();
    }
    return BroadCastTransactionReply()..txid = res;
  }

  @override
  Future<EstimateFeeReply> getEstimateFeePerKb(
    ServiceCall call,
    EstimateFeeRequest request,
  ) async {
    dynamic res;
    try {
      res = await _clientRPC.call('estimatesmartfee', [request.blockTarget]);
    } catch (e) {
      _logger.e(e.toString());
      return EstimateFeeReply()..feePerKb = Int64(0);
    }
    return EstimateFeeReply()
      ..feePerKb = Int64(
        (res["feerate"] * getDecimalProduct()).toInt(),
      );
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
