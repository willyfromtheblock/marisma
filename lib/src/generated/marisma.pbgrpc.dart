///
//  Generated code. Do not modify.
//  source: marisma.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,constant_identifier_names,directives_ordering,library_prefixes,non_constant_identifier_names,prefer_final_fields,return_of_invalid_type,unnecessary_const,unnecessary_import,unnecessary_this,unused_import,unused_shown_name

import 'dart:async' as $async;

import 'dart:core' as $core;

import 'package:grpc/service_api.dart' as $grpc;
import 'marisma.pb.dart' as $0;
export 'marisma.pb.dart';

class UTXOServerClient extends $grpc.Client {
  static final _$getBlockHeight =
      $grpc.ClientMethod<$0.BlockHeightRequest, $0.BlockHeightReply>(
          '/marisma.UTXOServer/GetBlockHeight',
          ($0.BlockHeightRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $0.BlockHeightReply.fromBuffer(value));

  UTXOServerClient($grpc.ClientChannel channel,
      {$grpc.CallOptions? options,
      $core.Iterable<$grpc.ClientInterceptor>? interceptors})
      : super(channel, options: options, interceptors: interceptors);

  $grpc.ResponseFuture<$0.BlockHeightReply> getBlockHeight(
      $0.BlockHeightRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getBlockHeight, request, options: options);
  }
}

abstract class UTXOServerServiceBase extends $grpc.Service {
  $core.String get $name => 'marisma.UTXOServer';

  UTXOServerServiceBase() {
    $addMethod($grpc.ServiceMethod<$0.BlockHeightRequest, $0.BlockHeightReply>(
        'GetBlockHeight',
        getBlockHeight_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.BlockHeightRequest.fromBuffer(value),
        ($0.BlockHeightReply value) => value.writeToBuffer()));
  }

  $async.Future<$0.BlockHeightReply> getBlockHeight_Pre($grpc.ServiceCall call,
      $async.Future<$0.BlockHeightRequest> request) async {
    return getBlockHeight(call, await request);
  }

  $async.Future<$0.BlockHeightReply> getBlockHeight(
      $grpc.ServiceCall call, $0.BlockHeightRequest request);
}
