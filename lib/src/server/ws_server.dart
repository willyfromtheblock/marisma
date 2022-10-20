import 'package:dart_utxo_server/src/tools/logger.dart';
import 'package:shelf/shelf_io.dart' as shelf_io;
import 'package:shelf_web_socket/shelf_web_socket.dart';

final _logger = LoggerWrapper().logger;

Future<void> serve() async {
  var handler = webSocketHandler((webSocket) {
    webSocket.stream.listen((message) {
      webSocket.sink.add("echo $message");
    });
  });

  shelf_io.serve(handler, '127.0.0.1', 8081).then((server) {
    _logger.i('Serving at ws://${server.address.host}:${server.port}');
  });
}
