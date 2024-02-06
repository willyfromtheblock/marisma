import 'dart:async';
import 'dart:io';

import 'package:alfred/alfred.dart';
// ignore: implementation_imports
import 'package:alfred/src/type_handlers/websocket_type_handler.dart';

Future<void> serve() async {
  final app = Alfred();

  // Track connected clients
  var users = <WebSocket>[];

  // WebSocket chat relay implementation
  app.get('/ws', (req, res) {
    return WebSocketSession(
      onOpen: (ws) {
        users.add(ws);
        users
            .where((user) => user != ws)
            .forEach((user) => user.send('A new user joined the chat.'));
      },
      onClose: (ws) {
        users.remove(ws);
        for (var user in users) {
          user.send('A user has left.');
        }
      },
      onMessage: (ws, dynamic data) async {
        for (var user in users) {
          user.send(data);
        }
      },
    );
  });

  final server = await app.listen();

  print('Listening on ${server.port}'); //TODO use logger
  //TODO port from ENV
}

// electrum methods in use by peercoin_flutter
// server.version - todo
// server.features - todo
// server.ping - todo
// blockchain.headers.subscribe - done
// blockchain.scripthash.subscribe - done
// blockchain.scripthash.listunspent - done
// blockchain.transaction.get - done 
// blockchain.transaction.broadcast - done