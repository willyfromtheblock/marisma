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

class AddressBalanceRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'AddressBalanceRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'marisma'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'address')
    ..hasRequiredFields = false
  ;

  AddressBalanceRequest._() : super();
  factory AddressBalanceRequest({
    $core.String? address,
  }) {
    final _result = create();
    if (address != null) {
      _result.address = address;
    }
    return _result;
  }
  factory AddressBalanceRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory AddressBalanceRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  AddressBalanceRequest clone() => AddressBalanceRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  AddressBalanceRequest copyWith(void Function(AddressBalanceRequest) updates) => super.copyWith((message) => updates(message as AddressBalanceRequest)) as AddressBalanceRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static AddressBalanceRequest create() => AddressBalanceRequest._();
  AddressBalanceRequest createEmptyInstance() => create();
  static $pb.PbList<AddressBalanceRequest> createRepeated() => $pb.PbList<AddressBalanceRequest>();
  @$core.pragma('dart2js:noInline')
  static AddressBalanceRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<AddressBalanceRequest>(create);
  static AddressBalanceRequest? _defaultInstance;

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
    ..a<$core.double>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'balance', $pb.PbFieldType.OD)
    ..a<$fixnum.Int64>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'balanceSats', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..hasRequiredFields = false
  ;

  AddressBalanceReply._() : super();
  factory AddressBalanceReply({
    $core.double? balance,
    $fixnum.Int64? balanceSats,
  }) {
    final _result = create();
    if (balance != null) {
      _result.balance = balance;
    }
    if (balanceSats != null) {
      _result.balanceSats = balanceSats;
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
  $core.double get balance => $_getN(0);
  @$pb.TagNumber(1)
  set balance($core.double v) { $_setDouble(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasBalance() => $_has(0);
  @$pb.TagNumber(1)
  void clearBalance() => clearField(1);

  @$pb.TagNumber(2)
  $fixnum.Int64 get balanceSats => $_getI64(1);
  @$pb.TagNumber(2)
  set balanceSats($fixnum.Int64 v) { $_setInt64(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasBalanceSats() => $_has(1);
  @$pb.TagNumber(2)
  void clearBalanceSats() => clearField(2);
}

class AddressUtxosRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'AddressUtxosRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'marisma'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'address')
    ..hasRequiredFields = false
  ;

  AddressUtxosRequest._() : super();
  factory AddressUtxosRequest({
    $core.String? address,
  }) {
    final _result = create();
    if (address != null) {
      _result.address = address;
    }
    return _result;
  }
  factory AddressUtxosRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory AddressUtxosRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  AddressUtxosRequest clone() => AddressUtxosRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  AddressUtxosRequest copyWith(void Function(AddressUtxosRequest) updates) => super.copyWith((message) => updates(message as AddressUtxosRequest)) as AddressUtxosRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static AddressUtxosRequest create() => AddressUtxosRequest._();
  AddressUtxosRequest createEmptyInstance() => create();
  static $pb.PbList<AddressUtxosRequest> createRepeated() => $pb.PbList<AddressUtxosRequest>();
  @$core.pragma('dart2js:noInline')
  static AddressUtxosRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<AddressUtxosRequest>(create);
  static AddressUtxosRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get address => $_getSZ(0);
  @$pb.TagNumber(1)
  set address($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasAddress() => $_has(0);
  @$pb.TagNumber(1)
  void clearAddress() => clearField(1);
}

class AddressUtxosReply extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'AddressUtxosReply', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'marisma'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'utxos')
    ..hasRequiredFields = false
  ;

  AddressUtxosReply._() : super();
  factory AddressUtxosReply({
    $core.String? utxos,
  }) {
    final _result = create();
    if (utxos != null) {
      _result.utxos = utxos;
    }
    return _result;
  }
  factory AddressUtxosReply.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory AddressUtxosReply.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  AddressUtxosReply clone() => AddressUtxosReply()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  AddressUtxosReply copyWith(void Function(AddressUtxosReply) updates) => super.copyWith((message) => updates(message as AddressUtxosReply)) as AddressUtxosReply; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static AddressUtxosReply create() => AddressUtxosReply._();
  AddressUtxosReply createEmptyInstance() => create();
  static $pb.PbList<AddressUtxosReply> createRepeated() => $pb.PbList<AddressUtxosReply>();
  @$core.pragma('dart2js:noInline')
  static AddressUtxosReply getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<AddressUtxosReply>(create);
  static AddressUtxosReply? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get utxos => $_getSZ(0);
  @$pb.TagNumber(1)
  set utxos($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasUtxos() => $_has(0);
  @$pb.TagNumber(1)
  void clearUtxos() => clearField(1);
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

