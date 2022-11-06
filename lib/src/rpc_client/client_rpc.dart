import 'dart:io';

import 'package:dart_coin_rpc/dart_coin_rpc.dart';

import '../tools/logger.dart';

Map<String, String> env = Platform.environment;
final _logger = LoggerWrapper().logger;

class ClientRPC extends RPCClient {
  ClientRPC()
      : super(
          host: env["COIN_RPC_HOST"]!,
          port: int.parse(env["COIN_RPC_PORT"]!),
          username: env["COIN_RPC_USER"]!,
          password: env["COIN_RPC_PASSWORD"]!,
          useSSL: env["COIN_RPC_USE_SSL"]! == "true",
        ) {
    _logger.i('Connecting to RPC...');
  }
}
