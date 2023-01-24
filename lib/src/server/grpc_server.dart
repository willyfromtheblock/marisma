import 'dart:async';
import 'dart:io';

import 'package:coinslib/coinslib.dart';
import 'package:dart_coin_rpc/dart_coin_rpc.dart';
import 'package:fixnum/fixnum.dart';
import 'package:grpc/grpc.dart';

import '../http_wrapper/http_wrapper.dart';
import '../networks.dart' as networks;
import '../generated/marisma.pbgrpc.dart';
import '../orm/isar_orm.dart';
import '../rpc_client/client_rpc.dart';
import '../tools/decimal_product.dart';
import '../tools/logger.dart';

Map<String, String> env = Platform.environment;
final _logger = LoggerWrapper().logger;
late RPCClient _clientRPC;

Future<void> connectToRpc() async {
  try {
    HttpWrapper().init();
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
  return validateAddress(
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
  await IsarORM().init();

  //init RPC Client
  await connectToRpc();

  //don't serve if sync is still in progress
  await checkSyncedUp();

  //serve
  await server.serve(
    address: "0.0.0.0",
    port: int.parse(env["GRPC_PORT"]!),
  );
  _logger.i('gRPC Server listening on port ${server.port}...');
  //TODO error handling
  //TODO tests
  //TODO pagination
  // https://stackoverflow.com/questions/36993720/pagination-in-grpc
}

Future<void> checkSyncedUp() async {
  final chainInfo = await HttpWrapper().get(
    path: 'chaininfo.json',
    requestJson: true,
  );
  final heightInRest = chainInfo["blocks"];

  if (await IsarORM().getHeightInIsar() < heightInRest) {
    _logger.i('gRPC Server waiting for chain sync...');

    return Future.delayed(
      Duration(seconds: 10),
      () async => await checkSyncedUp(),
    );
  }
}

class MarismaGRPCServer extends MarismaServiceBase {
  @override
  Future<AddressHasUtxosReply> getAddressHasUtxos(
    ServiceCall call,
    AddressRequest request,
  ) async {
    if (isValidAddress(request.address)) {
      return AddressHasUtxosReply()
        ..hasUtxos = await IsarORM().getAddressNumberOfUtxos(
              request.address,
            ) !=
            0;
    }
    return AddressHasUtxosReply()..hasUtxos = false;
  }

  @override
  Future<AddressUtxoHistoryReply> getAddressUtxoHistoryList(
    ServiceCall call,
    AddressListRequest request,
  ) async {
    if (isValidAddress(request.address)) {
      return AddressUtxoHistoryReply(
        history: await IsarORM().getAddressHistory(
          request.address,
          request.ascending,
        ),
      );
    }
    return AddressUtxoHistoryReply(history: []);
  }

  @override
  Future<AddressNumberOfUtxosReply> getAddressNumberOfUtxos(
    ServiceCall call,
    AddressRequest request,
  ) async {
    if (isValidAddress(request.address)) {
      return AddressNumberOfUtxosReply()
        ..n = await IsarORM().getAddressNumberOfUtxos(
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
      return AddressUtxoListReply(
        utxos: await IsarORM().getAddressUtxos(
          request.address,
          request.ascending,
        ),
      );
    }
    return AddressUtxoListReply(utxos: []);
  }

  @override
  Future<AddressBalanceReply> getAdressBalance(
    ServiceCall call,
    AddressRequest request,
  ) async {
    if (isValidAddress(request.address)) {
      var res = await IsarORM().getBalanceForAddress(request.address);
      return AddressBalanceReply()
        ..confirmed = Int64(
          res["confirmed"]!,
        )
        ..unconfirmed = Int64(
          res["unconfirmed"]!,
        );
    }
    return AddressBalanceReply()
      ..confirmed
      ..unconfirmed = Int64(0);
  }

  @override
  Future<AddressIsKnownReply> getAddressIsKnown(
    ServiceCall call,
    AddressRequest request,
  ) async {
    if (isValidAddress(request.address)) {
      return AddressIsKnownReply()
        ..isKnown = await IsarORM().getIsAddressKnown(request.address);
    }
    return AddressIsKnownReply()..isKnown = false;
  }

  @override
  Future<BlockHeightReply> getBlockHeight(
    ServiceCall call,
    BlockHeightRequest request,
  ) async {
    return BlockHeightReply()..height = await IsarORM().getHeightInIsar();
  }

  @override
  Future<TxReply> getTransaction(
    ServiceCall call,
    TxRequest request,
  ) async {
    return TxReply()..tx = await IsarORM().getTransaction(request.txid);
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
