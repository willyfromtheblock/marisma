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
    const {'1': 'height', '3': 1, '4': 1, '5': 13, '10': 'height'},
  ],
};

/// Descriptor for `BlockHeightReply`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List blockHeightReplyDescriptor = $convert.base64Decode('ChBCbG9ja0hlaWdodFJlcGx5EhYKBmhlaWdodBgBIAEoDVIGaGVpZ2h0');
@$core.Deprecated('Use addressRequestDescriptor instead')
const AddressRequest$json = const {
  '1': 'AddressRequest',
  '2': const [
    const {'1': 'address', '3': 1, '4': 1, '5': 9, '10': 'address'},
  ],
};

/// Descriptor for `AddressRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List addressRequestDescriptor = $convert.base64Decode('Cg5BZGRyZXNzUmVxdWVzdBIYCgdhZGRyZXNzGAEgASgJUgdhZGRyZXNz');
@$core.Deprecated('Use addressBalanceReplyDescriptor instead')
const AddressBalanceReply$json = const {
  '1': 'AddressBalanceReply',
  '2': const [
    const {'1': 'balance', '3': 1, '4': 1, '5': 4, '10': 'balance'},
  ],
};

/// Descriptor for `AddressBalanceReply`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List addressBalanceReplyDescriptor = $convert.base64Decode('ChNBZGRyZXNzQmFsYW5jZVJlcGx5EhgKB2JhbGFuY2UYASABKARSB2JhbGFuY2U=');
@$core.Deprecated('Use addressListUtxosReplyDescriptor instead')
const AddressListUtxosReply$json = const {
  '1': 'AddressListUtxosReply',
  '2': const [
    const {'1': 'utxos', '3': 1, '4': 1, '5': 9, '10': 'utxos'},
  ],
};

/// Descriptor for `AddressListUtxosReply`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List addressListUtxosReplyDescriptor = $convert.base64Decode('ChVBZGRyZXNzTGlzdFV0eG9zUmVwbHkSFAoFdXR4b3MYASABKAlSBXV0eG9z');
@$core.Deprecated('Use addressHistoryReplyDescriptor instead')
const AddressHistoryReply$json = const {
  '1': 'AddressHistoryReply',
  '2': const [
    const {'1': 'history', '3': 1, '4': 3, '5': 9, '10': 'history'},
  ],
};

/// Descriptor for `AddressHistoryReply`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List addressHistoryReplyDescriptor = $convert.base64Decode('ChNBZGRyZXNzSGlzdG9yeVJlcGx5EhgKB2hpc3RvcnkYASADKAlSB2hpc3Rvcnk=');
@$core.Deprecated('Use addressHasUtxosReplyDescriptor instead')
const AddressHasUtxosReply$json = const {
  '1': 'AddressHasUtxosReply',
  '2': const [
    const {'1': 'has_utxos', '3': 1, '4': 1, '5': 8, '10': 'hasUtxos'},
  ],
};

/// Descriptor for `AddressHasUtxosReply`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List addressHasUtxosReplyDescriptor = $convert.base64Decode('ChRBZGRyZXNzSGFzVXR4b3NSZXBseRIbCgloYXNfdXR4b3MYASABKAhSCGhhc1V0eG9z');
@$core.Deprecated('Use testStreamRequestDescriptor instead')
const TestStreamRequest$json = const {
  '1': 'TestStreamRequest',
};

/// Descriptor for `TestStreamRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List testStreamRequestDescriptor = $convert.base64Decode('ChFUZXN0U3RyZWFtUmVxdWVzdA==');
@$core.Deprecated('Use testStreamReplyDescriptor instead')
const TestStreamReply$json = const {
  '1': 'TestStreamReply',
  '2': const [
    const {'1': 'name', '3': 1, '4': 1, '5': 9, '10': 'name'},
  ],
};

/// Descriptor for `TestStreamReply`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List testStreamReplyDescriptor = $convert.base64Decode('Cg9UZXN0U3RyZWFtUmVwbHkSEgoEbmFtZRgBIAEoCVIEbmFtZQ==');
