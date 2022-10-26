///
//  Generated code. Do not modify.
//  source: marisma.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,constant_identifier_names,directives_ordering,library_prefixes,non_constant_identifier_names,prefer_final_fields,return_of_invalid_type,unnecessary_const,unnecessary_import,unnecessary_this,unused_import,unused_shown_name

import 'dart:core' as $core;

import 'package:fixnum/fixnum.dart' as $fixnum;
import 'package:protobuf/protobuf.dart' as $pb;

class BlockHeightRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'BlockHeightRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'marisma'), createEmptyInstance: create)
    ..hasRequiredFields = false
  ;

  BlockHeightRequest._() : super();
  factory BlockHeightRequest() => create();
  factory BlockHeightRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory BlockHeightRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  BlockHeightRequest clone() => BlockHeightRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  BlockHeightRequest copyWith(void Function(BlockHeightRequest) updates) => super.copyWith((message) => updates(message as BlockHeightRequest)) as BlockHeightRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static BlockHeightRequest create() => BlockHeightRequest._();
  BlockHeightRequest createEmptyInstance() => create();
  static $pb.PbList<BlockHeightRequest> createRepeated() => $pb.PbList<BlockHeightRequest>();
  @$core.pragma('dart2js:noInline')
  static BlockHeightRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<BlockHeightRequest>(create);
  static BlockHeightRequest? _defaultInstance;
}

class BlockHeightReply extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'BlockHeightReply', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'marisma'), createEmptyInstance: create)
    ..a<$core.int>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'height', $pb.PbFieldType.OU3)
    ..hasRequiredFields = false
  ;

  BlockHeightReply._() : super();
  factory BlockHeightReply({
    $core.int? height,
  }) {
    final _result = create();
    if (height != null) {
      _result.height = height;
    }
    return _result;
  }
  factory BlockHeightReply.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory BlockHeightReply.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  BlockHeightReply clone() => BlockHeightReply()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  BlockHeightReply copyWith(void Function(BlockHeightReply) updates) => super.copyWith((message) => updates(message as BlockHeightReply)) as BlockHeightReply; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static BlockHeightReply create() => BlockHeightReply._();
  BlockHeightReply createEmptyInstance() => create();
  static $pb.PbList<BlockHeightReply> createRepeated() => $pb.PbList<BlockHeightReply>();
  @$core.pragma('dart2js:noInline')
  static BlockHeightReply getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<BlockHeightReply>(create);
  static BlockHeightReply? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get height => $_getIZ(0);
  @$pb.TagNumber(1)
  set height($core.int v) { $_setUnsignedInt32(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasHeight() => $_has(0);
  @$pb.TagNumber(1)
  void clearHeight() => clearField(1);
}

class AddressRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'AddressRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'marisma'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'address')
    ..hasRequiredFields = false
  ;

  AddressRequest._() : super();
  factory AddressRequest({
    $core.String? address,
  }) {
    final _result = create();
    if (address != null) {
      _result.address = address;
    }
    return _result;
  }
  factory AddressRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory AddressRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  AddressRequest clone() => AddressRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  AddressRequest copyWith(void Function(AddressRequest) updates) => super.copyWith((message) => updates(message as AddressRequest)) as AddressRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static AddressRequest create() => AddressRequest._();
  AddressRequest createEmptyInstance() => create();
  static $pb.PbList<AddressRequest> createRepeated() => $pb.PbList<AddressRequest>();
  @$core.pragma('dart2js:noInline')
  static AddressRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<AddressRequest>(create);
  static AddressRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get address => $_getSZ(0);
  @$pb.TagNumber(1)
  set address($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasAddress() => $_has(0);
  @$pb.TagNumber(1)
  void clearAddress() => clearField(1);
}

class AddressBalanceReply extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'AddressBalanceReply', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'marisma'), createEmptyInstance: create)
    ..a<$fixnum.Int64>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'balance', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..hasRequiredFields = false
  ;

  AddressBalanceReply._() : super();
  factory AddressBalanceReply({
    $fixnum.Int64? balance,
  }) {
    final _result = create();
    if (balance != null) {
      _result.balance = balance;
    }
    return _result;
  }
  factory AddressBalanceReply.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory AddressBalanceReply.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  AddressBalanceReply clone() => AddressBalanceReply()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  AddressBalanceReply copyWith(void Function(AddressBalanceReply) updates) => super.copyWith((message) => updates(message as AddressBalanceReply)) as AddressBalanceReply; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static AddressBalanceReply create() => AddressBalanceReply._();
  AddressBalanceReply createEmptyInstance() => create();
  static $pb.PbList<AddressBalanceReply> createRepeated() => $pb.PbList<AddressBalanceReply>();
  @$core.pragma('dart2js:noInline')
  static AddressBalanceReply getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<AddressBalanceReply>(create);
  static AddressBalanceReply? _defaultInstance;

  @$pb.TagNumber(1)
  $fixnum.Int64 get balance => $_getI64(0);
  @$pb.TagNumber(1)
  set balance($fixnum.Int64 v) { $_setInt64(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasBalance() => $_has(0);
  @$pb.TagNumber(1)
  void clearBalance() => clearField(1);
}

class AddressListUtxosReply extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'AddressListUtxosReply', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'marisma'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'utxos')
    ..hasRequiredFields = false
  ;

  AddressListUtxosReply._() : super();
  factory AddressListUtxosReply({
    $core.String? utxos,
  }) {
    final _result = create();
    if (utxos != null) {
      _result.utxos = utxos;
    }
    return _result;
  }
  factory AddressListUtxosReply.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory AddressListUtxosReply.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  AddressListUtxosReply clone() => AddressListUtxosReply()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  AddressListUtxosReply copyWith(void Function(AddressListUtxosReply) updates) => super.copyWith((message) => updates(message as AddressListUtxosReply)) as AddressListUtxosReply; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static AddressListUtxosReply create() => AddressListUtxosReply._();
  AddressListUtxosReply createEmptyInstance() => create();
  static $pb.PbList<AddressListUtxosReply> createRepeated() => $pb.PbList<AddressListUtxosReply>();
  @$core.pragma('dart2js:noInline')
  static AddressListUtxosReply getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<AddressListUtxosReply>(create);
  static AddressListUtxosReply? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get utxos => $_getSZ(0);
  @$pb.TagNumber(1)
  set utxos($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasUtxos() => $_has(0);
  @$pb.TagNumber(1)
  void clearUtxos() => clearField(1);
}

class AddressHistoryReply extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'AddressHistoryReply', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'marisma'), createEmptyInstance: create)
    ..pPS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'history')
    ..hasRequiredFields = false
  ;

  AddressHistoryReply._() : super();
  factory AddressHistoryReply({
    $core.Iterable<$core.String>? history,
  }) {
    final _result = create();
    if (history != null) {
      _result.history.addAll(history);
    }
    return _result;
  }
  factory AddressHistoryReply.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory AddressHistoryReply.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  AddressHistoryReply clone() => AddressHistoryReply()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  AddressHistoryReply copyWith(void Function(AddressHistoryReply) updates) => super.copyWith((message) => updates(message as AddressHistoryReply)) as AddressHistoryReply; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static AddressHistoryReply create() => AddressHistoryReply._();
  AddressHistoryReply createEmptyInstance() => create();
  static $pb.PbList<AddressHistoryReply> createRepeated() => $pb.PbList<AddressHistoryReply>();
  @$core.pragma('dart2js:noInline')
  static AddressHistoryReply getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<AddressHistoryReply>(create);
  static AddressHistoryReply? _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<$core.String> get history => $_getList(0);
}

class AddressHasUtxosReply extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'AddressHasUtxosReply', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'marisma'), createEmptyInstance: create)
    ..aOB(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'hasUtxos')
    ..hasRequiredFields = false
  ;

  AddressHasUtxosReply._() : super();
  factory AddressHasUtxosReply({
    $core.bool? hasUtxos,
  }) {
    final _result = create();
    if (hasUtxos != null) {
      _result.hasUtxos = hasUtxos;
    }
    return _result;
  }
  factory AddressHasUtxosReply.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory AddressHasUtxosReply.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  AddressHasUtxosReply clone() => AddressHasUtxosReply()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  AddressHasUtxosReply copyWith(void Function(AddressHasUtxosReply) updates) => super.copyWith((message) => updates(message as AddressHasUtxosReply)) as AddressHasUtxosReply; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static AddressHasUtxosReply create() => AddressHasUtxosReply._();
  AddressHasUtxosReply createEmptyInstance() => create();
  static $pb.PbList<AddressHasUtxosReply> createRepeated() => $pb.PbList<AddressHasUtxosReply>();
  @$core.pragma('dart2js:noInline')
  static AddressHasUtxosReply getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<AddressHasUtxosReply>(create);
  static AddressHasUtxosReply? _defaultInstance;

  @$pb.TagNumber(1)
  $core.bool get hasUtxos => $_getBF(0);
  @$pb.TagNumber(1)
  set hasUtxos($core.bool v) { $_setBool(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasHasUtxos() => $_has(0);
  @$pb.TagNumber(1)
  void clearHasUtxos() => clearField(1);
}

class TestStreamRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'TestStreamRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'marisma'), createEmptyInstance: create)
    ..hasRequiredFields = false
  ;

  TestStreamRequest._() : super();
  factory TestStreamRequest() => create();
  factory TestStreamRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory TestStreamRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  TestStreamRequest clone() => TestStreamRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  TestStreamRequest copyWith(void Function(TestStreamRequest) updates) => super.copyWith((message) => updates(message as TestStreamRequest)) as TestStreamRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static TestStreamRequest create() => TestStreamRequest._();
  TestStreamRequest createEmptyInstance() => create();
  static $pb.PbList<TestStreamRequest> createRepeated() => $pb.PbList<TestStreamRequest>();
  @$core.pragma('dart2js:noInline')
  static TestStreamRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<TestStreamRequest>(create);
  static TestStreamRequest? _defaultInstance;
}

class TestStreamReply extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'TestStreamReply', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'marisma'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'name')
    ..hasRequiredFields = false
  ;

  TestStreamReply._() : super();
  factory TestStreamReply({
    $core.String? name,
  }) {
    final _result = create();
    if (name != null) {
      _result.name = name;
    }
    return _result;
  }
  factory TestStreamReply.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory TestStreamReply.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  TestStreamReply clone() => TestStreamReply()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  TestStreamReply copyWith(void Function(TestStreamReply) updates) => super.copyWith((message) => updates(message as TestStreamReply)) as TestStreamReply; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static TestStreamReply create() => TestStreamReply._();
  TestStreamReply createEmptyInstance() => create();
  static $pb.PbList<TestStreamReply> createRepeated() => $pb.PbList<TestStreamReply>();
  @$core.pragma('dart2js:noInline')
  static TestStreamReply getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<TestStreamReply>(create);
  static TestStreamReply? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get name => $_getSZ(0);
  @$pb.TagNumber(1)
  set name($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasName() => $_has(0);
  @$pb.TagNumber(1)
  void clearName() => clearField(1);
}

