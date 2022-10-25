///
//  Generated code. Do not modify.
//  source: marisma.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,constant_identifier_names,deprecated_member_use_from_same_package,directives_ordering,library_prefixes,non_constant_identifier_names,prefer_final_fields,return_of_invalid_type,unnecessary_const,unnecessary_import,unnecessary_this,unused_import,unused_shown_name

import 'dart:core' as $core;
import 'dart:convert' as $convert;
import 'dart:typed_data' as $typed_data;
@$core.Deprecated('Use blockHeightRequestDescriptor instead')
const BlockHeightRequest$json = const {
  '1': 'BlockHeightRequest',
};

/// Descriptor for `BlockHeightRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List blockHeightRequestDescriptor = $convert.base64Decode('ChJCbG9ja0hlaWdodFJlcXVlc3Q=');
@$core.Deprecated('Use blockHeightReplyDescriptor instead')
const BlockHeightReply$json = const {
  '1': 'BlockHeightReply',
  '2': const [
    const {'1': 'height', '3': 1, '4': 1, '5': 5, '10': 'height'},
  ],
};

/// Descriptor for `BlockHeightReply`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List blockHeightReplyDescriptor = $convert.base64Decode('ChBCbG9ja0hlaWdodFJlcGx5EhYKBmhlaWdodBgBIAEoBVIGaGVpZ2h0');
@$core.Deprecated('Use addressBalanceRequestDescriptor instead')
const AddressBalanceRequest$json = const {
  '1': 'AddressBalanceRequest',
  '2': const [
    const {'1': 'address', '3': 1, '4': 1, '5': 9, '10': 'address'},
  ],
};

/// Descriptor for `AddressBalanceRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List addressBalanceRequestDescriptor = $convert.base64Decode('ChVBZGRyZXNzQmFsYW5jZVJlcXVlc3QSGAoHYWRkcmVzcxgBIAEoCVIHYWRkcmVzcw==');
@$core.Deprecated('Use addressBalanceReplyDescriptor instead')
const AddressBalanceReply$json = const {
  '1': 'AddressBalanceReply',
  '2': const [
    const {'1': 'balance', '3': 1, '4': 1, '5': 1, '10': 'balance'},
    const {'1': 'balance_sats', '3': 2, '4': 1, '5': 5, '10': 'balanceSats'},
  ],
};

/// Descriptor for `AddressBalanceReply`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List addressBalanceReplyDescriptor = $convert.base64Decode('ChNBZGRyZXNzQmFsYW5jZVJlcGx5EhgKB2JhbGFuY2UYASABKAFSB2JhbGFuY2USIQoMYmFsYW5jZV9zYXRzGAIgASgFUgtiYWxhbmNlU2F0cw==');
@$core.Deprecated('Use addressUtxosRequestDescriptor instead')
const AddressUtxosRequest$json = const {
  '1': 'AddressUtxosRequest',
  '2': const [
    const {'1': 'address', '3': 1, '4': 1, '5': 9, '10': 'address'},
  ],
};

/// Descriptor for `AddressUtxosRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List addressUtxosRequestDescriptor = $convert.base64Decode('ChNBZGRyZXNzVXR4b3NSZXF1ZXN0EhgKB2FkZHJlc3MYASABKAlSB2FkZHJlc3M=');
@$core.Deprecated('Use addressUtxosReplyDescriptor instead')
const AddressUtxosReply$json = const {
  '1': 'AddressUtxosReply',
  '2': const [
    const {'1': 'utxos', '3': 1, '4': 1, '5': 9, '10': 'utxos'},
  ],
};

/// Descriptor for `AddressUtxosReply`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List addressUtxosReplyDescriptor = $convert.base64Decode('ChFBZGRyZXNzVXR4b3NSZXBseRIUCgV1dHhvcxgBIAEoCVIFdXR4b3M=');
