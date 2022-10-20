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

class MarismaServerClient extends $grpc.Client {
  static final _$getBlockHeight =
      $grpc.ClientMethod<$0.BlockHeightRequest, $0.BlockHeightReply>(
          '/marisma.MarismaServer/GetBlockHeight',
          ($0.BlockHeightRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $0.BlockHeightReply.fromBuffer(value));
  static final _$getAdressBalance =
      $grpc.ClientMethod<$0.AddressBalanceRequest, $0.AddressBalanceReply>(
          '/marisma.MarismaServer/GetAdressBalance',
          ($0.AddressBalanceRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $0.AddressBalanceReply.fromBuffer(value));

  MarismaServerClient($grpc.ClientChannel channel,
      {$grpc.CallOptions? options,
      $core.Iterable<$grpc.ClientInterceptor>? interceptors})
      : super(channel, options: options, interceptors: interceptors);

  $grpc.ResponseFuture<$0.BlockHeightReply> getBlockHeight(
      $0.BlockHeightRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getBlockHeight, request, options: options);
  }

  $grpc.ResponseFuture<$0.AddressBalanceReply> getAdressBalance(
      $0.AddressBalanceRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getAdressBalance, request, options: options);
  }
}

abstract class MarismaServerServiceBase extends $grpc.Service {
  $core.String get $name => 'marisma.MarismaServer';

  MarismaServerServiceBase() {
    $addMethod($grpc.ServiceMethod<$0.BlockHeightRequest, $0.BlockHeightReply>(
        'GetBlockHeight',
        getBlockHeight_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.BlockHeightRequest.fromBuffer(value),
        ($0.BlockHeightReply value) => value.writeToBuffer()));
    $addMethod(
        $grpc.ServiceMethod<$0.AddressBalanceRequest, $0.AddressBalanceReply>(
            'GetAdressBalance',
            getAdressBalance_Pre,
            false,
            false,
            ($core.List<$core.int> value) =>
                $0.AddressBalanceRequest.fromBuffer(value),
            ($0.AddressBalanceReply value) => value.writeToBuffer()));
  }

  $async.Future<$0.BlockHeightReply> getBlockHeight_Pre($grpc.ServiceCall call,
      $async.Future<$0.BlockHeightRequest> request) async {
    return getBlockHeight(call, await request);
  }

  $async.Future<$0.AddressBalanceReply> getAdressBalance_Pre(
      $grpc.ServiceCall call,
      $async.Future<$0.AddressBalanceRequest> request) async {
    return getAdressBalance(call, await request);
  }

  $async.Future<$0.BlockHeightReply> getBlockHeight(
      $grpc.ServiceCall call, $0.BlockHeightRequest request);
  $async.Future<$0.AddressBalanceReply> getAdressBalance(
      $grpc.ServiceCall call, $0.AddressBalanceRequest request);
}
