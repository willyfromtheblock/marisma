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
  ],
};

/// Descriptor for `AddressBalanceReply`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List addressBalanceReplyDescriptor = $convert.base64Decode('ChNBZGRyZXNzQmFsYW5jZVJlcGx5EhgKB2JhbGFuY2UYASABKAFSB2JhbGFuY2U=');
