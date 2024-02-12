import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:async/async.dart';
import 'package:dart_coin_rpc/dart_coin_rpc.dart';
import 'package:fixnum/fixnum.dart';
import 'package:grpc/grpc.dart';
import 'package:marisma/src/tools/validators.dart';

import '../http_wrapper/http_wrapper.dart';
import '../networks.dart' as networks;
import '../generated/marisma.pbgrpc.dart';
import '../orm/surreal_orm.dart';
import '../rpc_client/client_rpc.dart';
import '../tools/decimal_product.dart';
import '../tools/logger.dart';

Map<String, String> env = Platform.environment;
final _cloudflareMode = env['CLOUDFLARE_MODE'] == "true";
final _cloudflarePingInterval = 90;
final _logger = LoggerWrapper().logger;
final SurrealORM _surrealORM = SurrealORM();
late RPCClient _clientRPC;
bool sigtermReceived = false;

Future<void> connectToRpc() async {
  try {
    HttpWrapper().init();
    _clientRPC = ClientRPC();
    _logger.d(
      'gRPC isolate - connected to ${env['COIN_NAME']} RPC',
    );
  } catch (e) {
    _logger.e(
      'gRPC isolate - error connecting to RPC: ${e.toString()}',
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
    networks.availableNetworks[Platform.environment["COIN_NAME"]]!,
  );
}

Future<void> serve() async {
  final server = Server.create(
    services: [MarismaGRPCServer()],
    interceptors: const <Interceptor>[],
    codecRegistry: CodecRegistry(
      codecs: const [
        GzipCodec(),
      ],
    ),
    keepAliveOptions: ServerKeepAliveOptions(
      minIntervalBetweenPingsWithoutData: Duration(seconds: 30),
    ),
  );

  //init logger in isolate
  LoggerWrapper().init();

  //init orm in isolate
  await _surrealORM.init();

  //init block hash watcher
  await _surrealORM.initBlockHashWatcher();

  //init RPC Client
  await connectToRpc();

  //intercept sigterm
  ProcessSignal.sigterm.watch().listen(
    (_) async {
      LoggerWrapper().logger.i('gRPC Server SIGTERM received');
      sigtermReceived = true;
      server.shutdown();
    },
  );

  //don't serve if sync is still in progress
  while (await _surrealORM.checkInitialSyncCompleted() == false) {
    //wait for sync
    _logger.d(
      'gRPC Server waiting for initial parsing to end or address update to finish...',
    );
    await Future.delayed(Duration(seconds: 10));
  }

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

class MarismaGRPCServer extends MarismaServiceBase {
  @override
  Future<AddressHasUtxosReply> getAddressHasUtxos(
    ServiceCall call,
    AddressRequest request,
  ) async {
    if (isValidAddress(request.address)) {
      return AddressHasUtxosReply()
        ..hasUtxos = await _surrealORM.getAddressNumberOfUtxos(
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
        history: await _surrealORM.getAddressUtxoHistory(
          address: request.address,
          minimumHeight: request.minimumHeight,
          ascending: request.ascending,
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
        ..n = await _surrealORM.getAddressNumberOfUtxos(
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
        utxos: await _surrealORM.getAddressSortedUtxoStrings(
          address: request.address,
          minimumHeight: request.minimumHeight,
          ascending: request.ascending,
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
      var res = await _surrealORM.getBalanceForAddress(request.address);
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
        ..isKnown = await _surrealORM.getIsAddressKnown(request.address);
    }
    return AddressIsKnownReply()..isKnown = false;
  }

  @override
  Future<BlockHeightReply> getBlockHeight(
    ServiceCall call,
    EmptyRequest request,
  ) async {
    return BlockHeightReply()
      ..height = await _surrealORM.getHeightInSurrealDB();
  }

  @override
  Future<TxReply> getTransaction(
    ServiceCall call,
    TxRequest request,
  ) async {
    dynamic res;
    try {
      res = await HttpWrapper().get(
        path: 'tx/${request.txid}.json',
        requestJson: true,
      );
    } catch (e) {
      _logger.d("${request.txid} ${e.toString()}");
      return TxReply()
        ..tx = ""
        ..rpcError = e.toString();
    }
    return TxReply()..tx = jsonEncode(res);
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

  // Server-side streaming RPC of new block hashes
  @override
  Stream<BlockHashStreamReply> blockHashStream(
    ServiceCall call,
    BlockHashStreamRequest request,
  ) async* {
    final streamGroup = StreamGroup<BlockHashStreamReply>();

    //add pong to keep connection alive in cloudflare mode
    if (_cloudflareMode == true) {
      streamGroup.add(
        Stream<BlockHashStreamReply>.periodic(
          Duration(seconds: _cloudflarePingInterval),
          (count) => BlockHashStreamReply()..pong = 'pong',
        ),
      );
    }

    //return latest block as stream event as broadcast stream won't return the latest event to new subscribers
    final currentHeight = await _surrealORM.getHeightInSurrealDB();
    final latestBlock = await _surrealORM.getBlockByHeight(currentHeight);
    if (latestBlock != null) {
      streamGroup.add(
        Stream.value(
          BlockHashStreamReply()
            ..height = latestBlock.height
            ..hash = latestBlock.hash,
        ),
      );
    }

    //add new block hashes from surrealDB to stream
    streamGroup.add(
      _surrealORM.blockHashStream(),
    );

    yield* streamGroup.stream;
  }

  // Bi-directional streaming RPC of address status
  // Will continiously stream back the status of the address (with changes) until the client closes the connection
  @override
  Stream<AddressStatusStreamReply> addressStatusStream(
    ServiceCall call,
    Stream<AddressRequest> request,
  ) async* {
    final streamGroup = StreamGroup<AddressStatusStreamReply>();

    //add pong to keep connection alive in cloudflare mode
    if (_cloudflareMode == true) {
      streamGroup.add(
        Stream<AddressStatusStreamReply>.periodic(
          Duration(seconds: _cloudflarePingInterval),
          (count) => AddressStatusStreamReply()..pong = 'pong',
        ),
      );
    }

    request.listen(
      (event) {
        if (event.address.isNotEmpty) {
          streamGroup.add(
            _surrealORM.addressStatusStream(
              event.address,
            ),
          );
        }
      },
    );

    yield* streamGroup.stream;
  }

  // Bi-directional streaming RPC of address is_known
  // Will stream back the is_known for every requested address until the client closes the connection
  @override
  Stream<AddressScanStreamReply> addressScanStream(
    ServiceCall call,
    Stream<AddressRequest> request,
  ) async* {
    await for (final event in request) {
      yield AddressScanStreamReply()
        ..address = event.address
        ..isKnown = await _surrealORM.getIsAddressKnown(event.address);
    }
  }

  // Bi-directional streaming RPC of address utxos
  // Will stream back the utxos for every requested address until the client closes the connection
  @override
  Stream<AddressUtxosStreamReply> addressUtxosStream(
    ServiceCall call,
    Stream<AddressListRequest> request,
  ) async* {
    await for (final event in request) {
      yield AddressUtxosStreamReply(
        address: event.address,
        utxos: await _surrealORM.getAddressSortedUtxoStrings(
          address: event.address,
          minimumHeight: event.minimumHeight,
          ascending: event.ascending,
        ),
      );
    }
  }
}
