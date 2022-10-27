import 'dart:io';

import 'package:marisma/src/feeder/feeder.dart' as feeder;
import 'package:marisma/src/networks.dart' as networks;
import 'package:marisma/src/orm/surreal_orm.dart';
import 'package:marisma/src/tools/logger.dart';
import 'package:marisma/src/server/grpc_server.dart' as server;

void main(List<String> arguments) async {
  Map<String, String> env = Platform.environment;
  Map<String, String> requiredEnvs = {
    "COIN_NAME": "",
    "COIN_RPC_HOST": "",
    "COIN_RPC_PORT": "",
    "COIN_RPC_USER": "",
    "COIN_RPC_PASSWORD": "",
    "COIN_RPC_USE_SSL": "false",
    "SURREAL_HOST": "",
    "SURREAL_PORT": "",
    "SURREAL_USER": "",
    "SURREAL_PASS": "",
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
  await SurrealORM().init();

  //start feeder
  await feeder.connectToRpc();

  //start gRPC server
  await server.serve();
  //TODO run server in isolate
}
