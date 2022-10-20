import 'package:grpc/grpc.dart';

import '../generated/marisma.pbgrpc.dart';

class UTXOServer extends UTXOServerServiceBase {
  @override
  Future<BlockHeightReply> getBlockHeight(
    ServiceCall call,
    BlockHeightRequest request,
  ) async {
    return BlockHeightReply()..height = 123;
  }
}

Future<void> serve() async {
  final server = Server(
    [UTXOServer()],
    const <Interceptor>[],
    CodecRegistry(codecs: const [
      GzipCodec(),
    ]),
  );
  await server.serve(port: 50051);
  print('gRPC Server listening on port ${server.port}...');
}
