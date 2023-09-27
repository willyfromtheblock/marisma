import 'dart:io';
import 'dart:isolate';

import 'package:marisma/src/feeders/block_feeder.dart' as block_feeder;
import 'package:marisma/src/isolates/mempool_isolate.dart' as mempool_isolate;
import 'package:marisma/src/networks.dart' as networks;
import 'package:marisma/src/server/grpc_server.dart' as grpc_server;
// import 'package:marisma/src/server/websockets_server.dart' as ws_server;
import 'package:marisma/src/tools/logger.dart';

void main(List<String> arguments) async {
  Map<String, String> env = Platform.environment;
  List<String> requiredEnvs = [
    "COIN_NAME",
    "COIN_RPC_HOST",
    "COIN_RPC_PORT",
    "COIN_RPC_USER",
    "COIN_RPC_PASSWORD",
    "COIN_RPC_USE_SSL",
    "LOG_LEVEL",
    "GRPC_PORT",
    "CLOUDFLARE_MODE",
    "SURREAL_HOST",
    "SURREAL_PORT",
    "SURREAL_USER",
    "SURREAL_PASS",
  ];

  for (var envValue in requiredEnvs) {
    if (!env.containsKey(envValue)) {
      throw Exception("$envValue needs to be in environment");
    } else if (env[envValue]!.isEmpty) {
      throw Exception("$envValue needs to have a value");
    }
  }

  if (!networks.availableNetworks.containsKey(env['COIN_NAME'])) {
    throw Exception("COIN_NAME ${env['COIN_NAME']} is not supported");
  }

  //init logger
  LoggerWrapper().init();

  //start mempool feeder in separate isolate
  await Isolate.spawn(
    (_) {
      mempool_isolate.initMempoolFeeder();
    },
    '',
  );

  //start gRPC server in separate isolate
  await Isolate.spawn(
    (_) {
      grpc_server.serve();
    },
    '',
    errorsAreFatal: false,
  );

  //start ws server in separate isolate
  // await Isolate.spawn(
  //   (_) {
  //     ws_server.serve();
  //   },
  //   '',
  // );

  //start block feeder
  await block_feeder.initBlockFeeder();

  //TODO invesigate what to do when one of the isolates exits
}
