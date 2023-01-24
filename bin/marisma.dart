import 'dart:io';
import 'dart:isolate';

import 'package:marisma/src/feeders/block_feeder.dart' as block_feeder;
import 'package:marisma/src/feeders/mempool_feeder.dart' as mempool_feeder;
import 'package:marisma/src/networks.dart' as networks;
import 'package:marisma/src/orm/isar_orm.dart';
import 'package:marisma/src/server/grpc_server.dart' as server;
import 'package:marisma/src/tools/logger.dart';

void main(List<String> arguments) async {
  Map<String, String> env = Platform.environment;
  Map<String, String> requiredEnvs = {
    "COIN_NAME": "",
    "COIN_RPC_HOST": "",
    "COIN_RPC_PORT": "",
    "COIN_RPC_USER": "",
    "COIN_RPC_PASSWORD": "",
    "COIN_RPC_USE_SSL": "false",
    "LOG_LEVEL": "",
    "GRPC_PORT": "",
  };

  requiredEnvs.forEach((key, value) {
    if (!env.containsKey(key)) {
      throw Exception("$key needs to be in environment");
    } else if (env[key]!.isEmpty) {
      throw Exception("$key needs to have a value");
    }
  });

  if (!networks.availableNetworks.containsKey(env['COIN_NAME'])) {
    throw Exception("COIN_NAME ${env['COIN_NAME']} is not supported");
  }

  //init logger
  LoggerWrapper().init();

  //init orm
  await IsarORM().init();

  //start block feeder
  await block_feeder.initBlockFeeder();

  //start mempool feeder in separate isolate
  await Isolate.spawn(
    (_) {
      mempool_feeder.initMempoolFeeder();
    },
    '',
  );

  //start gRPC server in separate isolate
  await Isolate.spawn(
    (_) {
      server.serve();
    },
    '',
  );
}
