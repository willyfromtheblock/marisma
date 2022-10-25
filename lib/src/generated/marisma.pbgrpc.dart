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

class MarismaClient extends $grpc.Client {
  static final _$getBlockHeight =
      $grpc.ClientMethod<$0.BlockHeightRequest, $0.BlockHeightReply>(
          '/marisma.Marisma/GetBlockHeight',
          ($0.BlockHeightRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $0.BlockHeightReply.fromBuffer(value));
  static final _$getAdressBalance =
      $grpc.ClientMethod<$0.AddressBalanceRequest, $0.AddressBalanceReply>(
          '/marisma.Marisma/GetAdressBalance',
          ($0.AddressBalanceRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $0.AddressBalanceReply.fromBuffer(value));
  static final _$getAddressUtxos =
      $grpc.ClientMethod<$0.AddressUtxosRequest, $0.AddressUtxosReply>(
          '/marisma.Marisma/GetAddressUtxos',
          ($0.AddressUtxosRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $0.AddressUtxosReply.fromBuffer(value));
  static final _$subscribeTestStream =
      $grpc.ClientMethod<$0.TestStreamRequest, $0.TestStreamReply>(
          '/marisma.Marisma/SubscribeTestStream',
          ($0.TestStreamRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $0.TestStreamReply.fromBuffer(value));

  MarismaClient($grpc.ClientChannel channel,
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

  $grpc.ResponseFuture<$0.AddressUtxosReply> getAddressUtxos(
      $0.AddressUtxosRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getAddressUtxos, request, options: options);
  }

  $grpc.ResponseStream<$0.TestStreamReply> subscribeTestStream(
      $0.TestStreamRequest request,
      {$grpc.CallOptions? options}) {
    return $createStreamingCall(
        _$subscribeTestStream, $async.Stream.fromIterable([request]),
        options: options);
  }
}

abstract class MarismaServiceBase extends $grpc.Service {
  $core.String get $name => 'marisma.Marisma';

  MarismaServiceBase() {
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
    $addMethod(
        $grpc.ServiceMethod<$0.AddressUtxosRequest, $0.AddressUtxosReply>(
            'GetAddressUtxos',
            getAddressUtxos_Pre,
            false,
            false,
            ($core.List<$core.int> value) =>
                $0.AddressUtxosRequest.fromBuffer(value),
            ($0.AddressUtxosReply value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.TestStreamRequest, $0.TestStreamReply>(
        'SubscribeTestStream',
        subscribeTestStream_Pre,
        false,
        true,
        ($core.List<$core.int> value) => $0.TestStreamRequest.fromBuffer(value),
        ($0.TestStreamReply value) => value.writeToBuffer()));
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

  $async.Future<$0.AddressUtxosReply> getAddressUtxos_Pre(
      $grpc.ServiceCall call,
      $async.Future<$0.AddressUtxosRequest> request) async {
    return getAddressUtxos(call, await request);
  }

  $async.Stream<$0.TestStreamReply> subscribeTestStream_Pre(
      $grpc.ServiceCall call,
      $async.Future<$0.TestStreamRequest> request) async* {
    yield* subscribeTestStream(call, await request);
  }

  $async.Future<$0.BlockHeightReply> getBlockHeight(
      $grpc.ServiceCall call, $0.BlockHeightRequest request);
  $async.Future<$0.AddressBalanceReply> getAdressBalance(
      $grpc.ServiceCall call, $0.AddressBalanceRequest request);
  $async.Future<$0.AddressUtxosReply> getAddressUtxos(
      $grpc.ServiceCall call, $0.AddressUtxosRequest request);
  $async.Stream<$0.TestStreamReply> subscribeTestStream(
      $grpc.ServiceCall call, $0.TestStreamRequest request);
}
