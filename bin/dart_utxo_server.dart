import 'dart:io';
import 'package:dart_utxo_server/dart_utxo_server.dart' as feeder;
import 'package:dart_utxo_server/src/networks.dart' as networks;
import 'package:dart_utxo_server/src/orm/surreal_orm.dart';

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
    "SURREAL_PASS": ""
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

  //init orm
  await SurrealORM().init();

  //start feeder
  await feeder.connectToRpc();
}
