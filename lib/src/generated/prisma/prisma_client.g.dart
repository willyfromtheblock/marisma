// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'prisma_client.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PrismaAddressWhereInput _$PrismaAddressWhereInputFromJson(
        Map<String, dynamic> json) =>
    PrismaAddressWhereInput(
      AND: (json['AND'] as List<dynamic>?)?.map(
          (e) => PrismaAddressWhereInput.fromJson(e as Map<String, dynamic>)),
      OR: (json['OR'] as List<dynamic>?)?.map(
          (e) => PrismaAddressWhereInput.fromJson(e as Map<String, dynamic>)),
      NOT: (json['NOT'] as List<dynamic>?)?.map(
          (e) => PrismaAddressWhereInput.fromJson(e as Map<String, dynamic>)),
      address: json['address'] == null
          ? null
          : StringFilter.fromJson(json['address'] as Map<String, dynamic>),
      status: json['status'] == null
          ? null
          : StringFilter.fromJson(json['status'] as Map<String, dynamic>),
      confirmedBalance: json['confirmedBalance'] == null
          ? null
          : IntFilter.fromJson(
              json['confirmedBalance'] as Map<String, dynamic>),
      unconfirmedBalance: json['unconfirmedBalance'] == null
          ? null
          : IntFilter.fromJson(
              json['unconfirmedBalance'] as Map<String, dynamic>),
      utxoHistory: json['utxoHistory'] == null
          ? null
          : StringNullableListFilter.fromJson(
              json['utxoHistory'] as Map<String, dynamic>),
      needsUpdating: json['needsUpdating'] == null
          ? null
          : BoolFilter.fromJson(json['needsUpdating'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$PrismaAddressWhereInputToJson(
    PrismaAddressWhereInput instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('AND', instance.AND?.map((e) => e.toJson()).toList());
  writeNotNull('OR', instance.OR?.map((e) => e.toJson()).toList());
  writeNotNull('NOT', instance.NOT?.map((e) => e.toJson()).toList());
  writeNotNull('address', instance.address?.toJson());
  writeNotNull('status', instance.status?.toJson());
  writeNotNull('confirmedBalance', instance.confirmedBalance?.toJson());
  writeNotNull('unconfirmedBalance', instance.unconfirmedBalance?.toJson());
  writeNotNull('utxoHistory', instance.utxoHistory?.toJson());
  writeNotNull('needsUpdating', instance.needsUpdating?.toJson());
  return val;
}

PrismaAddressOrderByWithRelationInput
    _$PrismaAddressOrderByWithRelationInputFromJson(
            Map<String, dynamic> json) =>
        PrismaAddressOrderByWithRelationInput(
          address: $enumDecodeNullable(_$SortOrderEnumMap, json['address']),
          status: $enumDecodeNullable(_$SortOrderEnumMap, json['status']),
          confirmedBalance:
              $enumDecodeNullable(_$SortOrderEnumMap, json['confirmedBalance']),
          unconfirmedBalance: $enumDecodeNullable(
              _$SortOrderEnumMap, json['unconfirmedBalance']),
          utxoHistory:
              $enumDecodeNullable(_$SortOrderEnumMap, json['utxoHistory']),
          needsUpdating:
              $enumDecodeNullable(_$SortOrderEnumMap, json['needsUpdating']),
        );

Map<String, dynamic> _$PrismaAddressOrderByWithRelationInputToJson(
    PrismaAddressOrderByWithRelationInput instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('address', _$SortOrderEnumMap[instance.address]);
  writeNotNull('status', _$SortOrderEnumMap[instance.status]);
  writeNotNull(
      'confirmedBalance', _$SortOrderEnumMap[instance.confirmedBalance]);
  writeNotNull(
      'unconfirmedBalance', _$SortOrderEnumMap[instance.unconfirmedBalance]);
  writeNotNull('utxoHistory', _$SortOrderEnumMap[instance.utxoHistory]);
  writeNotNull('needsUpdating', _$SortOrderEnumMap[instance.needsUpdating]);
  return val;
}

const _$SortOrderEnumMap = {
  SortOrder.asc: 'asc',
  SortOrder.desc: 'desc',
};

PrismaAddressWhereUniqueInput _$PrismaAddressWhereUniqueInputFromJson(
        Map<String, dynamic> json) =>
    PrismaAddressWhereUniqueInput(
      address: json['address'] as String?,
    );

Map<String, dynamic> _$PrismaAddressWhereUniqueInputToJson(
    PrismaAddressWhereUniqueInput instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('address', instance.address);
  return val;
}

PrismaAddressOrderByWithAggregationInput
    _$PrismaAddressOrderByWithAggregationInputFromJson(
            Map<String, dynamic> json) =>
        PrismaAddressOrderByWithAggregationInput(
          address: $enumDecodeNullable(_$SortOrderEnumMap, json['address']),
          status: $enumDecodeNullable(_$SortOrderEnumMap, json['status']),
          confirmedBalance:
              $enumDecodeNullable(_$SortOrderEnumMap, json['confirmedBalance']),
          unconfirmedBalance: $enumDecodeNullable(
              _$SortOrderEnumMap, json['unconfirmedBalance']),
          utxoHistory:
              $enumDecodeNullable(_$SortOrderEnumMap, json['utxoHistory']),
          needsUpdating:
              $enumDecodeNullable(_$SortOrderEnumMap, json['needsUpdating']),
          $count: json['_count'] == null
              ? null
              : PrismaAddressCountOrderByAggregateInput.fromJson(
                  json['_count'] as Map<String, dynamic>),
          $avg: json['_avg'] == null
              ? null
              : PrismaAddressAvgOrderByAggregateInput.fromJson(
                  json['_avg'] as Map<String, dynamic>),
          $max: json['_max'] == null
              ? null
              : PrismaAddressMaxOrderByAggregateInput.fromJson(
                  json['_max'] as Map<String, dynamic>),
          $min: json['_min'] == null
              ? null
              : PrismaAddressMinOrderByAggregateInput.fromJson(
                  json['_min'] as Map<String, dynamic>),
          $sum: json['_sum'] == null
              ? null
              : PrismaAddressSumOrderByAggregateInput.fromJson(
                  json['_sum'] as Map<String, dynamic>),
        );

Map<String, dynamic> _$PrismaAddressOrderByWithAggregationInputToJson(
    PrismaAddressOrderByWithAggregationInput instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('address', _$SortOrderEnumMap[instance.address]);
  writeNotNull('status', _$SortOrderEnumMap[instance.status]);
  writeNotNull(
      'confirmedBalance', _$SortOrderEnumMap[instance.confirmedBalance]);
  writeNotNull(
      'unconfirmedBalance', _$SortOrderEnumMap[instance.unconfirmedBalance]);
  writeNotNull('utxoHistory', _$SortOrderEnumMap[instance.utxoHistory]);
  writeNotNull('needsUpdating', _$SortOrderEnumMap[instance.needsUpdating]);
  writeNotNull('_count', instance.$count?.toJson());
  writeNotNull('_avg', instance.$avg?.toJson());
  writeNotNull('_max', instance.$max?.toJson());
  writeNotNull('_min', instance.$min?.toJson());
  writeNotNull('_sum', instance.$sum?.toJson());
  return val;
}

PrismaAddressScalarWhereWithAggregatesInput
    _$PrismaAddressScalarWhereWithAggregatesInputFromJson(
            Map<String, dynamic> json) =>
        PrismaAddressScalarWhereWithAggregatesInput(
          AND: (json['AND'] as List<dynamic>?)?.map((e) =>
              PrismaAddressScalarWhereWithAggregatesInput.fromJson(
                  e as Map<String, dynamic>)),
          OR: (json['OR'] as List<dynamic>?)?.map((e) =>
              PrismaAddressScalarWhereWithAggregatesInput.fromJson(
                  e as Map<String, dynamic>)),
          NOT: (json['NOT'] as List<dynamic>?)?.map((e) =>
              PrismaAddressScalarWhereWithAggregatesInput.fromJson(
                  e as Map<String, dynamic>)),
          address: json['address'] == null
              ? null
              : StringWithAggregatesFilter.fromJson(
                  json['address'] as Map<String, dynamic>),
          status: json['status'] == null
              ? null
              : StringWithAggregatesFilter.fromJson(
                  json['status'] as Map<String, dynamic>),
          confirmedBalance: json['confirmedBalance'] == null
              ? null
              : IntWithAggregatesFilter.fromJson(
                  json['confirmedBalance'] as Map<String, dynamic>),
          unconfirmedBalance: json['unconfirmedBalance'] == null
              ? null
              : IntWithAggregatesFilter.fromJson(
                  json['unconfirmedBalance'] as Map<String, dynamic>),
          utxoHistory: json['utxoHistory'] == null
              ? null
              : StringNullableListFilter.fromJson(
                  json['utxoHistory'] as Map<String, dynamic>),
          needsUpdating: json['needsUpdating'] == null
              ? null
              : BoolWithAggregatesFilter.fromJson(
                  json['needsUpdating'] as Map<String, dynamic>),
        );

Map<String, dynamic> _$PrismaAddressScalarWhereWithAggregatesInputToJson(
    PrismaAddressScalarWhereWithAggregatesInput instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('AND', instance.AND?.map((e) => e.toJson()).toList());
  writeNotNull('OR', instance.OR?.map((e) => e.toJson()).toList());
  writeNotNull('NOT', instance.NOT?.map((e) => e.toJson()).toList());
  writeNotNull('address', instance.address?.toJson());
  writeNotNull('status', instance.status?.toJson());
  writeNotNull('confirmedBalance', instance.confirmedBalance?.toJson());
  writeNotNull('unconfirmedBalance', instance.unconfirmedBalance?.toJson());
  writeNotNull('utxoHistory', instance.utxoHistory?.toJson());
  writeNotNull('needsUpdating', instance.needsUpdating?.toJson());
  return val;
}

PrismaBlockWhereInput _$PrismaBlockWhereInputFromJson(
        Map<String, dynamic> json) =>
    PrismaBlockWhereInput(
      AND: (json['AND'] as List<dynamic>?)?.map(
          (e) => PrismaBlockWhereInput.fromJson(e as Map<String, dynamic>)),
      OR: (json['OR'] as List<dynamic>?)?.map(
          (e) => PrismaBlockWhereInput.fromJson(e as Map<String, dynamic>)),
      NOT: (json['NOT'] as List<dynamic>?)?.map(
          (e) => PrismaBlockWhereInput.fromJson(e as Map<String, dynamic>)),
      id: json['id'] == null
          ? null
          : IntFilter.fromJson(json['id'] as Map<String, dynamic>),
      hash: json['hash'] == null
          ? null
          : StringFilter.fromJson(json['hash'] as Map<String, dynamic>),
      blocktime: json['blocktime'] == null
          ? null
          : IntFilter.fromJson(json['blocktime'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$PrismaBlockWhereInputToJson(
    PrismaBlockWhereInput instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('AND', instance.AND?.map((e) => e.toJson()).toList());
  writeNotNull('OR', instance.OR?.map((e) => e.toJson()).toList());
  writeNotNull('NOT', instance.NOT?.map((e) => e.toJson()).toList());
  writeNotNull('id', instance.id?.toJson());
  writeNotNull('hash', instance.hash?.toJson());
  writeNotNull('blocktime', instance.blocktime?.toJson());
  return val;
}

PrismaBlockOrderByWithRelationInput
    _$PrismaBlockOrderByWithRelationInputFromJson(Map<String, dynamic> json) =>
        PrismaBlockOrderByWithRelationInput(
          id: $enumDecodeNullable(_$SortOrderEnumMap, json['id']),
          hash: $enumDecodeNullable(_$SortOrderEnumMap, json['hash']),
          blocktime: $enumDecodeNullable(_$SortOrderEnumMap, json['blocktime']),
        );

Map<String, dynamic> _$PrismaBlockOrderByWithRelationInputToJson(
    PrismaBlockOrderByWithRelationInput instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('id', _$SortOrderEnumMap[instance.id]);
  writeNotNull('hash', _$SortOrderEnumMap[instance.hash]);
  writeNotNull('blocktime', _$SortOrderEnumMap[instance.blocktime]);
  return val;
}

PrismaBlockWhereUniqueInput _$PrismaBlockWhereUniqueInputFromJson(
        Map<String, dynamic> json) =>
    PrismaBlockWhereUniqueInput(
      id: json['id'] as int?,
    );

Map<String, dynamic> _$PrismaBlockWhereUniqueInputToJson(
    PrismaBlockWhereUniqueInput instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('id', instance.id);
  return val;
}

PrismaBlockOrderByWithAggregationInput
    _$PrismaBlockOrderByWithAggregationInputFromJson(
            Map<String, dynamic> json) =>
        PrismaBlockOrderByWithAggregationInput(
          id: $enumDecodeNullable(_$SortOrderEnumMap, json['id']),
          hash: $enumDecodeNullable(_$SortOrderEnumMap, json['hash']),
          blocktime: $enumDecodeNullable(_$SortOrderEnumMap, json['blocktime']),
          $count: json['_count'] == null
              ? null
              : PrismaBlockCountOrderByAggregateInput.fromJson(
                  json['_count'] as Map<String, dynamic>),
          $avg: json['_avg'] == null
              ? null
              : PrismaBlockAvgOrderByAggregateInput.fromJson(
                  json['_avg'] as Map<String, dynamic>),
          $max: json['_max'] == null
              ? null
              : PrismaBlockMaxOrderByAggregateInput.fromJson(
                  json['_max'] as Map<String, dynamic>),
          $min: json['_min'] == null
              ? null
              : PrismaBlockMinOrderByAggregateInput.fromJson(
                  json['_min'] as Map<String, dynamic>),
          $sum: json['_sum'] == null
              ? null
              : PrismaBlockSumOrderByAggregateInput.fromJson(
                  json['_sum'] as Map<String, dynamic>),
        );

Map<String, dynamic> _$PrismaBlockOrderByWithAggregationInputToJson(
    PrismaBlockOrderByWithAggregationInput instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('id', _$SortOrderEnumMap[instance.id]);
  writeNotNull('hash', _$SortOrderEnumMap[instance.hash]);
  writeNotNull('blocktime', _$SortOrderEnumMap[instance.blocktime]);
  writeNotNull('_count', instance.$count?.toJson());
  writeNotNull('_avg', instance.$avg?.toJson());
  writeNotNull('_max', instance.$max?.toJson());
  writeNotNull('_min', instance.$min?.toJson());
  writeNotNull('_sum', instance.$sum?.toJson());
  return val;
}

PrismaBlockScalarWhereWithAggregatesInput
    _$PrismaBlockScalarWhereWithAggregatesInputFromJson(
            Map<String, dynamic> json) =>
        PrismaBlockScalarWhereWithAggregatesInput(
          AND: (json['AND'] as List<dynamic>?)?.map((e) =>
              PrismaBlockScalarWhereWithAggregatesInput.fromJson(
                  e as Map<String, dynamic>)),
          OR: (json['OR'] as List<dynamic>?)?.map((e) =>
              PrismaBlockScalarWhereWithAggregatesInput.fromJson(
                  e as Map<String, dynamic>)),
          NOT: (json['NOT'] as List<dynamic>?)?.map((e) =>
              PrismaBlockScalarWhereWithAggregatesInput.fromJson(
                  e as Map<String, dynamic>)),
          id: json['id'] == null
              ? null
              : IntWithAggregatesFilter.fromJson(
                  json['id'] as Map<String, dynamic>),
          hash: json['hash'] == null
              ? null
              : StringWithAggregatesFilter.fromJson(
                  json['hash'] as Map<String, dynamic>),
          blocktime: json['blocktime'] == null
              ? null
              : IntWithAggregatesFilter.fromJson(
                  json['blocktime'] as Map<String, dynamic>),
        );

Map<String, dynamic> _$PrismaBlockScalarWhereWithAggregatesInputToJson(
    PrismaBlockScalarWhereWithAggregatesInput instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('AND', instance.AND?.map((e) => e.toJson()).toList());
  writeNotNull('OR', instance.OR?.map((e) => e.toJson()).toList());
  writeNotNull('NOT', instance.NOT?.map((e) => e.toJson()).toList());
  writeNotNull('id', instance.id?.toJson());
  writeNotNull('hash', instance.hash?.toJson());
  writeNotNull('blocktime', instance.blocktime?.toJson());
  return val;
}

PrismaUtxoWhereInput _$PrismaUtxoWhereInputFromJson(
        Map<String, dynamic> json) =>
    PrismaUtxoWhereInput(
      AND: (json['AND'] as List<dynamic>?)?.map(
          (e) => PrismaUtxoWhereInput.fromJson(e as Map<String, dynamic>)),
      OR: (json['OR'] as List<dynamic>?)?.map(
          (e) => PrismaUtxoWhereInput.fromJson(e as Map<String, dynamic>)),
      NOT: (json['NOT'] as List<dynamic>?)?.map(
          (e) => PrismaUtxoWhereInput.fromJson(e as Map<String, dynamic>)),
      txid: json['txid'] == null
          ? null
          : StringFilter.fromJson(json['txid'] as Map<String, dynamic>),
      txpos: json['txpos'] == null
          ? null
          : IntFilter.fromJson(json['txpos'] as Map<String, dynamic>),
      block: json['block'] == null
          ? null
          : IntFilter.fromJson(json['block'] as Map<String, dynamic>),
      value: json['value'] == null
          ? null
          : FloatFilter.fromJson(json['value'] as Map<String, dynamic>),
      address: json['address'] == null
          ? null
          : StringFilter.fromJson(json['address'] as Map<String, dynamic>),
      flaggedForDelete: json['flaggedForDelete'] == null
          ? null
          : BoolFilter.fromJson(
              json['flaggedForDelete'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$PrismaUtxoWhereInputToJson(
    PrismaUtxoWhereInput instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('AND', instance.AND?.map((e) => e.toJson()).toList());
  writeNotNull('OR', instance.OR?.map((e) => e.toJson()).toList());
  writeNotNull('NOT', instance.NOT?.map((e) => e.toJson()).toList());
  writeNotNull('txid', instance.txid?.toJson());
  writeNotNull('txpos', instance.txpos?.toJson());
  writeNotNull('block', instance.block?.toJson());
  writeNotNull('value', instance.value?.toJson());
  writeNotNull('address', instance.address?.toJson());
  writeNotNull('flaggedForDelete', instance.flaggedForDelete?.toJson());
  return val;
}

PrismaUtxoOrderByWithRelationInput _$PrismaUtxoOrderByWithRelationInputFromJson(
        Map<String, dynamic> json) =>
    PrismaUtxoOrderByWithRelationInput(
      txid: $enumDecodeNullable(_$SortOrderEnumMap, json['txid']),
      txpos: $enumDecodeNullable(_$SortOrderEnumMap, json['txpos']),
      block: $enumDecodeNullable(_$SortOrderEnumMap, json['block']),
      value: $enumDecodeNullable(_$SortOrderEnumMap, json['value']),
      address: $enumDecodeNullable(_$SortOrderEnumMap, json['address']),
      flaggedForDelete:
          $enumDecodeNullable(_$SortOrderEnumMap, json['flaggedForDelete']),
    );

Map<String, dynamic> _$PrismaUtxoOrderByWithRelationInputToJson(
    PrismaUtxoOrderByWithRelationInput instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('txid', _$SortOrderEnumMap[instance.txid]);
  writeNotNull('txpos', _$SortOrderEnumMap[instance.txpos]);
  writeNotNull('block', _$SortOrderEnumMap[instance.block]);
  writeNotNull('value', _$SortOrderEnumMap[instance.value]);
  writeNotNull('address', _$SortOrderEnumMap[instance.address]);
  writeNotNull(
      'flaggedForDelete', _$SortOrderEnumMap[instance.flaggedForDelete]);
  return val;
}

PrismaUtxoWhereUniqueInput _$PrismaUtxoWhereUniqueInputFromJson(
        Map<String, dynamic> json) =>
    PrismaUtxoWhereUniqueInput(
      txidTxpos: json['txid_txpos'] == null
          ? null
          : PrismaUtxoTxidTxposCompoundUniqueInput.fromJson(
              json['txid_txpos'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$PrismaUtxoWhereUniqueInputToJson(
    PrismaUtxoWhereUniqueInput instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('txid_txpos', instance.txidTxpos?.toJson());
  return val;
}

PrismaUtxoOrderByWithAggregationInput
    _$PrismaUtxoOrderByWithAggregationInputFromJson(
            Map<String, dynamic> json) =>
        PrismaUtxoOrderByWithAggregationInput(
          txid: $enumDecodeNullable(_$SortOrderEnumMap, json['txid']),
          txpos: $enumDecodeNullable(_$SortOrderEnumMap, json['txpos']),
          block: $enumDecodeNullable(_$SortOrderEnumMap, json['block']),
          value: $enumDecodeNullable(_$SortOrderEnumMap, json['value']),
          address: $enumDecodeNullable(_$SortOrderEnumMap, json['address']),
          flaggedForDelete:
              $enumDecodeNullable(_$SortOrderEnumMap, json['flaggedForDelete']),
          $count: json['_count'] == null
              ? null
              : PrismaUtxoCountOrderByAggregateInput.fromJson(
                  json['_count'] as Map<String, dynamic>),
          $avg: json['_avg'] == null
              ? null
              : PrismaUtxoAvgOrderByAggregateInput.fromJson(
                  json['_avg'] as Map<String, dynamic>),
          $max: json['_max'] == null
              ? null
              : PrismaUtxoMaxOrderByAggregateInput.fromJson(
                  json['_max'] as Map<String, dynamic>),
          $min: json['_min'] == null
              ? null
              : PrismaUtxoMinOrderByAggregateInput.fromJson(
                  json['_min'] as Map<String, dynamic>),
          $sum: json['_sum'] == null
              ? null
              : PrismaUtxoSumOrderByAggregateInput.fromJson(
                  json['_sum'] as Map<String, dynamic>),
        );

Map<String, dynamic> _$PrismaUtxoOrderByWithAggregationInputToJson(
    PrismaUtxoOrderByWithAggregationInput instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('txid', _$SortOrderEnumMap[instance.txid]);
  writeNotNull('txpos', _$SortOrderEnumMap[instance.txpos]);
  writeNotNull('block', _$SortOrderEnumMap[instance.block]);
  writeNotNull('value', _$SortOrderEnumMap[instance.value]);
  writeNotNull('address', _$SortOrderEnumMap[instance.address]);
  writeNotNull(
      'flaggedForDelete', _$SortOrderEnumMap[instance.flaggedForDelete]);
  writeNotNull('_count', instance.$count?.toJson());
  writeNotNull('_avg', instance.$avg?.toJson());
  writeNotNull('_max', instance.$max?.toJson());
  writeNotNull('_min', instance.$min?.toJson());
  writeNotNull('_sum', instance.$sum?.toJson());
  return val;
}

PrismaUtxoScalarWhereWithAggregatesInput
    _$PrismaUtxoScalarWhereWithAggregatesInputFromJson(
            Map<String, dynamic> json) =>
        PrismaUtxoScalarWhereWithAggregatesInput(
          AND: (json['AND'] as List<dynamic>?)?.map((e) =>
              PrismaUtxoScalarWhereWithAggregatesInput.fromJson(
                  e as Map<String, dynamic>)),
          OR: (json['OR'] as List<dynamic>?)?.map((e) =>
              PrismaUtxoScalarWhereWithAggregatesInput.fromJson(
                  e as Map<String, dynamic>)),
          NOT: (json['NOT'] as List<dynamic>?)?.map((e) =>
              PrismaUtxoScalarWhereWithAggregatesInput.fromJson(
                  e as Map<String, dynamic>)),
          txid: json['txid'] == null
              ? null
              : StringWithAggregatesFilter.fromJson(
                  json['txid'] as Map<String, dynamic>),
          txpos: json['txpos'] == null
              ? null
              : IntWithAggregatesFilter.fromJson(
                  json['txpos'] as Map<String, dynamic>),
          block: json['block'] == null
              ? null
              : IntWithAggregatesFilter.fromJson(
                  json['block'] as Map<String, dynamic>),
          value: json['value'] == null
              ? null
              : FloatWithAggregatesFilter.fromJson(
                  json['value'] as Map<String, dynamic>),
          address: json['address'] == null
              ? null
              : StringWithAggregatesFilter.fromJson(
                  json['address'] as Map<String, dynamic>),
          flaggedForDelete: json['flaggedForDelete'] == null
              ? null
              : BoolWithAggregatesFilter.fromJson(
                  json['flaggedForDelete'] as Map<String, dynamic>),
        );

Map<String, dynamic> _$PrismaUtxoScalarWhereWithAggregatesInputToJson(
    PrismaUtxoScalarWhereWithAggregatesInput instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('AND', instance.AND?.map((e) => e.toJson()).toList());
  writeNotNull('OR', instance.OR?.map((e) => e.toJson()).toList());
  writeNotNull('NOT', instance.NOT?.map((e) => e.toJson()).toList());
  writeNotNull('txid', instance.txid?.toJson());
  writeNotNull('txpos', instance.txpos?.toJson());
  writeNotNull('block', instance.block?.toJson());
  writeNotNull('value', instance.value?.toJson());
  writeNotNull('address', instance.address?.toJson());
  writeNotNull('flaggedForDelete', instance.flaggedForDelete?.toJson());
  return val;
}

PrismaAddressCreateInput _$PrismaAddressCreateInputFromJson(
        Map<String, dynamic> json) =>
    PrismaAddressCreateInput(
      address: json['address'] as String,
      status: json['status'] as String,
      confirmedBalance: json['confirmedBalance'] as int,
      unconfirmedBalance: json['unconfirmedBalance'] as int,
      utxoHistory:
          (json['utxoHistory'] as List<dynamic>?)?.map((e) => e as String),
      needsUpdating: json['needsUpdating'] as bool,
    );

Map<String, dynamic> _$PrismaAddressCreateInputToJson(
    PrismaAddressCreateInput instance) {
  final val = <String, dynamic>{
    'address': instance.address,
    'status': instance.status,
    'confirmedBalance': instance.confirmedBalance,
    'unconfirmedBalance': instance.unconfirmedBalance,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('utxoHistory', instance.utxoHistory?.toList());
  val['needsUpdating'] = instance.needsUpdating;
  return val;
}

PrismaAddressUncheckedCreateInput _$PrismaAddressUncheckedCreateInputFromJson(
        Map<String, dynamic> json) =>
    PrismaAddressUncheckedCreateInput(
      address: json['address'] as String,
      status: json['status'] as String,
      confirmedBalance: json['confirmedBalance'] as int,
      unconfirmedBalance: json['unconfirmedBalance'] as int,
      utxoHistory:
          (json['utxoHistory'] as List<dynamic>?)?.map((e) => e as String),
      needsUpdating: json['needsUpdating'] as bool,
    );

Map<String, dynamic> _$PrismaAddressUncheckedCreateInputToJson(
    PrismaAddressUncheckedCreateInput instance) {
  final val = <String, dynamic>{
    'address': instance.address,
    'status': instance.status,
    'confirmedBalance': instance.confirmedBalance,
    'unconfirmedBalance': instance.unconfirmedBalance,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('utxoHistory', instance.utxoHistory?.toList());
  val['needsUpdating'] = instance.needsUpdating;
  return val;
}

PrismaAddressUpdateInput _$PrismaAddressUpdateInputFromJson(
        Map<String, dynamic> json) =>
    PrismaAddressUpdateInput(
      address: json['address'] == null
          ? null
          : StringFieldUpdateOperationsInput.fromJson(
              json['address'] as Map<String, dynamic>),
      status: json['status'] == null
          ? null
          : StringFieldUpdateOperationsInput.fromJson(
              json['status'] as Map<String, dynamic>),
      confirmedBalance: json['confirmedBalance'] == null
          ? null
          : IntFieldUpdateOperationsInput.fromJson(
              json['confirmedBalance'] as Map<String, dynamic>),
      unconfirmedBalance: json['unconfirmedBalance'] == null
          ? null
          : IntFieldUpdateOperationsInput.fromJson(
              json['unconfirmedBalance'] as Map<String, dynamic>),
      utxoHistory:
          (json['utxoHistory'] as List<dynamic>?)?.map((e) => e as String),
      needsUpdating: json['needsUpdating'] == null
          ? null
          : BoolFieldUpdateOperationsInput.fromJson(
              json['needsUpdating'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$PrismaAddressUpdateInputToJson(
    PrismaAddressUpdateInput instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('address', instance.address?.toJson());
  writeNotNull('status', instance.status?.toJson());
  writeNotNull('confirmedBalance', instance.confirmedBalance?.toJson());
  writeNotNull('unconfirmedBalance', instance.unconfirmedBalance?.toJson());
  writeNotNull('utxoHistory', instance.utxoHistory?.toList());
  writeNotNull('needsUpdating', instance.needsUpdating?.toJson());
  return val;
}

PrismaAddressUncheckedUpdateInput _$PrismaAddressUncheckedUpdateInputFromJson(
        Map<String, dynamic> json) =>
    PrismaAddressUncheckedUpdateInput(
      address: json['address'] == null
          ? null
          : StringFieldUpdateOperationsInput.fromJson(
              json['address'] as Map<String, dynamic>),
      status: json['status'] == null
          ? null
          : StringFieldUpdateOperationsInput.fromJson(
              json['status'] as Map<String, dynamic>),
      confirmedBalance: json['confirmedBalance'] == null
          ? null
          : IntFieldUpdateOperationsInput.fromJson(
              json['confirmedBalance'] as Map<String, dynamic>),
      unconfirmedBalance: json['unconfirmedBalance'] == null
          ? null
          : IntFieldUpdateOperationsInput.fromJson(
              json['unconfirmedBalance'] as Map<String, dynamic>),
      utxoHistory:
          (json['utxoHistory'] as List<dynamic>?)?.map((e) => e as String),
      needsUpdating: json['needsUpdating'] == null
          ? null
          : BoolFieldUpdateOperationsInput.fromJson(
              json['needsUpdating'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$PrismaAddressUncheckedUpdateInputToJson(
    PrismaAddressUncheckedUpdateInput instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('address', instance.address?.toJson());
  writeNotNull('status', instance.status?.toJson());
  writeNotNull('confirmedBalance', instance.confirmedBalance?.toJson());
  writeNotNull('unconfirmedBalance', instance.unconfirmedBalance?.toJson());
  writeNotNull('utxoHistory', instance.utxoHistory?.toList());
  writeNotNull('needsUpdating', instance.needsUpdating?.toJson());
  return val;
}

PrismaAddressCreateManyInput _$PrismaAddressCreateManyInputFromJson(
        Map<String, dynamic> json) =>
    PrismaAddressCreateManyInput(
      address: json['address'] as String,
      status: json['status'] as String,
      confirmedBalance: json['confirmedBalance'] as int,
      unconfirmedBalance: json['unconfirmedBalance'] as int,
      utxoHistory:
          (json['utxoHistory'] as List<dynamic>?)?.map((e) => e as String),
      needsUpdating: json['needsUpdating'] as bool,
    );

Map<String, dynamic> _$PrismaAddressCreateManyInputToJson(
    PrismaAddressCreateManyInput instance) {
  final val = <String, dynamic>{
    'address': instance.address,
    'status': instance.status,
    'confirmedBalance': instance.confirmedBalance,
    'unconfirmedBalance': instance.unconfirmedBalance,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('utxoHistory', instance.utxoHistory?.toList());
  val['needsUpdating'] = instance.needsUpdating;
  return val;
}

PrismaAddressUpdateManyMutationInput
    _$PrismaAddressUpdateManyMutationInputFromJson(Map<String, dynamic> json) =>
        PrismaAddressUpdateManyMutationInput(
          address: json['address'] == null
              ? null
              : StringFieldUpdateOperationsInput.fromJson(
                  json['address'] as Map<String, dynamic>),
          status: json['status'] == null
              ? null
              : StringFieldUpdateOperationsInput.fromJson(
                  json['status'] as Map<String, dynamic>),
          confirmedBalance: json['confirmedBalance'] == null
              ? null
              : IntFieldUpdateOperationsInput.fromJson(
                  json['confirmedBalance'] as Map<String, dynamic>),
          unconfirmedBalance: json['unconfirmedBalance'] == null
              ? null
              : IntFieldUpdateOperationsInput.fromJson(
                  json['unconfirmedBalance'] as Map<String, dynamic>),
          utxoHistory:
              (json['utxoHistory'] as List<dynamic>?)?.map((e) => e as String),
          needsUpdating: json['needsUpdating'] == null
              ? null
              : BoolFieldUpdateOperationsInput.fromJson(
                  json['needsUpdating'] as Map<String, dynamic>),
        );

Map<String, dynamic> _$PrismaAddressUpdateManyMutationInputToJson(
    PrismaAddressUpdateManyMutationInput instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('address', instance.address?.toJson());
  writeNotNull('status', instance.status?.toJson());
  writeNotNull('confirmedBalance', instance.confirmedBalance?.toJson());
  writeNotNull('unconfirmedBalance', instance.unconfirmedBalance?.toJson());
  writeNotNull('utxoHistory', instance.utxoHistory?.toList());
  writeNotNull('needsUpdating', instance.needsUpdating?.toJson());
  return val;
}

PrismaAddressUncheckedUpdateManyInput
    _$PrismaAddressUncheckedUpdateManyInputFromJson(
            Map<String, dynamic> json) =>
        PrismaAddressUncheckedUpdateManyInput(
          address: json['address'] == null
              ? null
              : StringFieldUpdateOperationsInput.fromJson(
                  json['address'] as Map<String, dynamic>),
          status: json['status'] == null
              ? null
              : StringFieldUpdateOperationsInput.fromJson(
                  json['status'] as Map<String, dynamic>),
          confirmedBalance: json['confirmedBalance'] == null
              ? null
              : IntFieldUpdateOperationsInput.fromJson(
                  json['confirmedBalance'] as Map<String, dynamic>),
          unconfirmedBalance: json['unconfirmedBalance'] == null
              ? null
              : IntFieldUpdateOperationsInput.fromJson(
                  json['unconfirmedBalance'] as Map<String, dynamic>),
          utxoHistory:
              (json['utxoHistory'] as List<dynamic>?)?.map((e) => e as String),
          needsUpdating: json['needsUpdating'] == null
              ? null
              : BoolFieldUpdateOperationsInput.fromJson(
                  json['needsUpdating'] as Map<String, dynamic>),
        );

Map<String, dynamic> _$PrismaAddressUncheckedUpdateManyInputToJson(
    PrismaAddressUncheckedUpdateManyInput instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('address', instance.address?.toJson());
  writeNotNull('status', instance.status?.toJson());
  writeNotNull('confirmedBalance', instance.confirmedBalance?.toJson());
  writeNotNull('unconfirmedBalance', instance.unconfirmedBalance?.toJson());
  writeNotNull('utxoHistory', instance.utxoHistory?.toList());
  writeNotNull('needsUpdating', instance.needsUpdating?.toJson());
  return val;
}

PrismaBlockCreateInput _$PrismaBlockCreateInputFromJson(
        Map<String, dynamic> json) =>
    PrismaBlockCreateInput(
      id: json['id'] as int,
      hash: json['hash'] as String,
      blocktime: json['blocktime'] as int,
    );

Map<String, dynamic> _$PrismaBlockCreateInputToJson(
        PrismaBlockCreateInput instance) =>
    <String, dynamic>{
      'id': instance.id,
      'hash': instance.hash,
      'blocktime': instance.blocktime,
    };

PrismaBlockUncheckedCreateInput _$PrismaBlockUncheckedCreateInputFromJson(
        Map<String, dynamic> json) =>
    PrismaBlockUncheckedCreateInput(
      id: json['id'] as int,
      hash: json['hash'] as String,
      blocktime: json['blocktime'] as int,
    );

Map<String, dynamic> _$PrismaBlockUncheckedCreateInputToJson(
        PrismaBlockUncheckedCreateInput instance) =>
    <String, dynamic>{
      'id': instance.id,
      'hash': instance.hash,
      'blocktime': instance.blocktime,
    };

PrismaBlockUpdateInput _$PrismaBlockUpdateInputFromJson(
        Map<String, dynamic> json) =>
    PrismaBlockUpdateInput(
      id: json['id'] == null
          ? null
          : IntFieldUpdateOperationsInput.fromJson(
              json['id'] as Map<String, dynamic>),
      hash: json['hash'] == null
          ? null
          : StringFieldUpdateOperationsInput.fromJson(
              json['hash'] as Map<String, dynamic>),
      blocktime: json['blocktime'] == null
          ? null
          : IntFieldUpdateOperationsInput.fromJson(
              json['blocktime'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$PrismaBlockUpdateInputToJson(
    PrismaBlockUpdateInput instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('id', instance.id?.toJson());
  writeNotNull('hash', instance.hash?.toJson());
  writeNotNull('blocktime', instance.blocktime?.toJson());
  return val;
}

PrismaBlockUncheckedUpdateInput _$PrismaBlockUncheckedUpdateInputFromJson(
        Map<String, dynamic> json) =>
    PrismaBlockUncheckedUpdateInput(
      id: json['id'] == null
          ? null
          : IntFieldUpdateOperationsInput.fromJson(
              json['id'] as Map<String, dynamic>),
      hash: json['hash'] == null
          ? null
          : StringFieldUpdateOperationsInput.fromJson(
              json['hash'] as Map<String, dynamic>),
      blocktime: json['blocktime'] == null
          ? null
          : IntFieldUpdateOperationsInput.fromJson(
              json['blocktime'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$PrismaBlockUncheckedUpdateInputToJson(
    PrismaBlockUncheckedUpdateInput instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('id', instance.id?.toJson());
  writeNotNull('hash', instance.hash?.toJson());
  writeNotNull('blocktime', instance.blocktime?.toJson());
  return val;
}

PrismaBlockCreateManyInput _$PrismaBlockCreateManyInputFromJson(
        Map<String, dynamic> json) =>
    PrismaBlockCreateManyInput(
      id: json['id'] as int,
      hash: json['hash'] as String,
      blocktime: json['blocktime'] as int,
    );

Map<String, dynamic> _$PrismaBlockCreateManyInputToJson(
        PrismaBlockCreateManyInput instance) =>
    <String, dynamic>{
      'id': instance.id,
      'hash': instance.hash,
      'blocktime': instance.blocktime,
    };

PrismaBlockUpdateManyMutationInput _$PrismaBlockUpdateManyMutationInputFromJson(
        Map<String, dynamic> json) =>
    PrismaBlockUpdateManyMutationInput(
      id: json['id'] == null
          ? null
          : IntFieldUpdateOperationsInput.fromJson(
              json['id'] as Map<String, dynamic>),
      hash: json['hash'] == null
          ? null
          : StringFieldUpdateOperationsInput.fromJson(
              json['hash'] as Map<String, dynamic>),
      blocktime: json['blocktime'] == null
          ? null
          : IntFieldUpdateOperationsInput.fromJson(
              json['blocktime'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$PrismaBlockUpdateManyMutationInputToJson(
    PrismaBlockUpdateManyMutationInput instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('id', instance.id?.toJson());
  writeNotNull('hash', instance.hash?.toJson());
  writeNotNull('blocktime', instance.blocktime?.toJson());
  return val;
}

PrismaBlockUncheckedUpdateManyInput
    _$PrismaBlockUncheckedUpdateManyInputFromJson(Map<String, dynamic> json) =>
        PrismaBlockUncheckedUpdateManyInput(
          id: json['id'] == null
              ? null
              : IntFieldUpdateOperationsInput.fromJson(
                  json['id'] as Map<String, dynamic>),
          hash: json['hash'] == null
              ? null
              : StringFieldUpdateOperationsInput.fromJson(
                  json['hash'] as Map<String, dynamic>),
          blocktime: json['blocktime'] == null
              ? null
              : IntFieldUpdateOperationsInput.fromJson(
                  json['blocktime'] as Map<String, dynamic>),
        );

Map<String, dynamic> _$PrismaBlockUncheckedUpdateManyInputToJson(
    PrismaBlockUncheckedUpdateManyInput instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('id', instance.id?.toJson());
  writeNotNull('hash', instance.hash?.toJson());
  writeNotNull('blocktime', instance.blocktime?.toJson());
  return val;
}

PrismaUtxoCreateInput _$PrismaUtxoCreateInputFromJson(
        Map<String, dynamic> json) =>
    PrismaUtxoCreateInput(
      txid: json['txid'] as String,
      txpos: json['txpos'] as int,
      block: json['block'] as int,
      value: (json['value'] as num).toDouble(),
      address: json['address'] as String,
      flaggedForDelete: json['flaggedForDelete'] as bool?,
    );

Map<String, dynamic> _$PrismaUtxoCreateInputToJson(
    PrismaUtxoCreateInput instance) {
  final val = <String, dynamic>{
    'txid': instance.txid,
    'txpos': instance.txpos,
    'block': instance.block,
    'value': instance.value,
    'address': instance.address,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('flaggedForDelete', instance.flaggedForDelete);
  return val;
}

PrismaUtxoUncheckedCreateInput _$PrismaUtxoUncheckedCreateInputFromJson(
        Map<String, dynamic> json) =>
    PrismaUtxoUncheckedCreateInput(
      txid: json['txid'] as String,
      txpos: json['txpos'] as int,
      block: json['block'] as int,
      value: (json['value'] as num).toDouble(),
      address: json['address'] as String,
      flaggedForDelete: json['flaggedForDelete'] as bool?,
    );

Map<String, dynamic> _$PrismaUtxoUncheckedCreateInputToJson(
    PrismaUtxoUncheckedCreateInput instance) {
  final val = <String, dynamic>{
    'txid': instance.txid,
    'txpos': instance.txpos,
    'block': instance.block,
    'value': instance.value,
    'address': instance.address,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('flaggedForDelete', instance.flaggedForDelete);
  return val;
}

PrismaUtxoUpdateInput _$PrismaUtxoUpdateInputFromJson(
        Map<String, dynamic> json) =>
    PrismaUtxoUpdateInput(
      txid: json['txid'] == null
          ? null
          : StringFieldUpdateOperationsInput.fromJson(
              json['txid'] as Map<String, dynamic>),
      txpos: json['txpos'] == null
          ? null
          : IntFieldUpdateOperationsInput.fromJson(
              json['txpos'] as Map<String, dynamic>),
      block: json['block'] == null
          ? null
          : IntFieldUpdateOperationsInput.fromJson(
              json['block'] as Map<String, dynamic>),
      value: json['value'] == null
          ? null
          : FloatFieldUpdateOperationsInput.fromJson(
              json['value'] as Map<String, dynamic>),
      address: json['address'] == null
          ? null
          : StringFieldUpdateOperationsInput.fromJson(
              json['address'] as Map<String, dynamic>),
      flaggedForDelete: json['flaggedForDelete'] == null
          ? null
          : BoolFieldUpdateOperationsInput.fromJson(
              json['flaggedForDelete'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$PrismaUtxoUpdateInputToJson(
    PrismaUtxoUpdateInput instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('txid', instance.txid?.toJson());
  writeNotNull('txpos', instance.txpos?.toJson());
  writeNotNull('block', instance.block?.toJson());
  writeNotNull('value', instance.value?.toJson());
  writeNotNull('address', instance.address?.toJson());
  writeNotNull('flaggedForDelete', instance.flaggedForDelete?.toJson());
  return val;
}

PrismaUtxoUncheckedUpdateInput _$PrismaUtxoUncheckedUpdateInputFromJson(
        Map<String, dynamic> json) =>
    PrismaUtxoUncheckedUpdateInput(
      txid: json['txid'] == null
          ? null
          : StringFieldUpdateOperationsInput.fromJson(
              json['txid'] as Map<String, dynamic>),
      txpos: json['txpos'] == null
          ? null
          : IntFieldUpdateOperationsInput.fromJson(
              json['txpos'] as Map<String, dynamic>),
      block: json['block'] == null
          ? null
          : IntFieldUpdateOperationsInput.fromJson(
              json['block'] as Map<String, dynamic>),
      value: json['value'] == null
          ? null
          : FloatFieldUpdateOperationsInput.fromJson(
              json['value'] as Map<String, dynamic>),
      address: json['address'] == null
          ? null
          : StringFieldUpdateOperationsInput.fromJson(
              json['address'] as Map<String, dynamic>),
      flaggedForDelete: json['flaggedForDelete'] == null
          ? null
          : BoolFieldUpdateOperationsInput.fromJson(
              json['flaggedForDelete'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$PrismaUtxoUncheckedUpdateInputToJson(
    PrismaUtxoUncheckedUpdateInput instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('txid', instance.txid?.toJson());
  writeNotNull('txpos', instance.txpos?.toJson());
  writeNotNull('block', instance.block?.toJson());
  writeNotNull('value', instance.value?.toJson());
  writeNotNull('address', instance.address?.toJson());
  writeNotNull('flaggedForDelete', instance.flaggedForDelete?.toJson());
  return val;
}

PrismaUtxoCreateManyInput _$PrismaUtxoCreateManyInputFromJson(
        Map<String, dynamic> json) =>
    PrismaUtxoCreateManyInput(
      txid: json['txid'] as String,
      txpos: json['txpos'] as int,
      block: json['block'] as int,
      value: (json['value'] as num).toDouble(),
      address: json['address'] as String,
      flaggedForDelete: json['flaggedForDelete'] as bool?,
    );

Map<String, dynamic> _$PrismaUtxoCreateManyInputToJson(
    PrismaUtxoCreateManyInput instance) {
  final val = <String, dynamic>{
    'txid': instance.txid,
    'txpos': instance.txpos,
    'block': instance.block,
    'value': instance.value,
    'address': instance.address,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('flaggedForDelete', instance.flaggedForDelete);
  return val;
}

PrismaUtxoUpdateManyMutationInput _$PrismaUtxoUpdateManyMutationInputFromJson(
        Map<String, dynamic> json) =>
    PrismaUtxoUpdateManyMutationInput(
      txid: json['txid'] == null
          ? null
          : StringFieldUpdateOperationsInput.fromJson(
              json['txid'] as Map<String, dynamic>),
      txpos: json['txpos'] == null
          ? null
          : IntFieldUpdateOperationsInput.fromJson(
              json['txpos'] as Map<String, dynamic>),
      block: json['block'] == null
          ? null
          : IntFieldUpdateOperationsInput.fromJson(
              json['block'] as Map<String, dynamic>),
      value: json['value'] == null
          ? null
          : FloatFieldUpdateOperationsInput.fromJson(
              json['value'] as Map<String, dynamic>),
      address: json['address'] == null
          ? null
          : StringFieldUpdateOperationsInput.fromJson(
              json['address'] as Map<String, dynamic>),
      flaggedForDelete: json['flaggedForDelete'] == null
          ? null
          : BoolFieldUpdateOperationsInput.fromJson(
              json['flaggedForDelete'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$PrismaUtxoUpdateManyMutationInputToJson(
    PrismaUtxoUpdateManyMutationInput instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('txid', instance.txid?.toJson());
  writeNotNull('txpos', instance.txpos?.toJson());
  writeNotNull('block', instance.block?.toJson());
  writeNotNull('value', instance.value?.toJson());
  writeNotNull('address', instance.address?.toJson());
  writeNotNull('flaggedForDelete', instance.flaggedForDelete?.toJson());
  return val;
}

PrismaUtxoUncheckedUpdateManyInput _$PrismaUtxoUncheckedUpdateManyInputFromJson(
        Map<String, dynamic> json) =>
    PrismaUtxoUncheckedUpdateManyInput(
      txid: json['txid'] == null
          ? null
          : StringFieldUpdateOperationsInput.fromJson(
              json['txid'] as Map<String, dynamic>),
      txpos: json['txpos'] == null
          ? null
          : IntFieldUpdateOperationsInput.fromJson(
              json['txpos'] as Map<String, dynamic>),
      block: json['block'] == null
          ? null
          : IntFieldUpdateOperationsInput.fromJson(
              json['block'] as Map<String, dynamic>),
      value: json['value'] == null
          ? null
          : FloatFieldUpdateOperationsInput.fromJson(
              json['value'] as Map<String, dynamic>),
      address: json['address'] == null
          ? null
          : StringFieldUpdateOperationsInput.fromJson(
              json['address'] as Map<String, dynamic>),
      flaggedForDelete: json['flaggedForDelete'] == null
          ? null
          : BoolFieldUpdateOperationsInput.fromJson(
              json['flaggedForDelete'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$PrismaUtxoUncheckedUpdateManyInputToJson(
    PrismaUtxoUncheckedUpdateManyInput instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('txid', instance.txid?.toJson());
  writeNotNull('txpos', instance.txpos?.toJson());
  writeNotNull('block', instance.block?.toJson());
  writeNotNull('value', instance.value?.toJson());
  writeNotNull('address', instance.address?.toJson());
  writeNotNull('flaggedForDelete', instance.flaggedForDelete?.toJson());
  return val;
}

StringFilter _$StringFilterFromJson(Map<String, dynamic> json) => StringFilter(
      equals: json['equals'] as String?,
      $in: (json['in'] as List<dynamic>?)?.map((e) => e as String),
      notIn: (json['notIn'] as List<dynamic>?)?.map((e) => e as String),
      lt: json['lt'] as String?,
      lte: json['lte'] as String?,
      gt: json['gt'] as String?,
      gte: json['gte'] as String?,
      contains: json['contains'] as String?,
      startsWith: json['startsWith'] as String?,
      endsWith: json['endsWith'] as String?,
      mode: $enumDecodeNullable(_$QueryModeEnumMap, json['mode']),
      not: json['not'] == null
          ? null
          : NestedStringFilter.fromJson(json['not'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$StringFilterToJson(StringFilter instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('equals', instance.equals);
  writeNotNull('in', instance.$in?.toList());
  writeNotNull('notIn', instance.notIn?.toList());
  writeNotNull('lt', instance.lt);
  writeNotNull('lte', instance.lte);
  writeNotNull('gt', instance.gt);
  writeNotNull('gte', instance.gte);
  writeNotNull('contains', instance.contains);
  writeNotNull('startsWith', instance.startsWith);
  writeNotNull('endsWith', instance.endsWith);
  writeNotNull('mode', _$QueryModeEnumMap[instance.mode]);
  writeNotNull('not', instance.not?.toJson());
  return val;
}

const _$QueryModeEnumMap = {
  QueryMode.$default: 'default',
  QueryMode.insensitive: 'insensitive',
};

IntFilter _$IntFilterFromJson(Map<String, dynamic> json) => IntFilter(
      equals: json['equals'] as int?,
      $in: (json['in'] as List<dynamic>?)?.map((e) => e as int),
      notIn: (json['notIn'] as List<dynamic>?)?.map((e) => e as int),
      lt: json['lt'] as int?,
      lte: json['lte'] as int?,
      gt: json['gt'] as int?,
      gte: json['gte'] as int?,
      not: json['not'] == null
          ? null
          : NestedIntFilter.fromJson(json['not'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$IntFilterToJson(IntFilter instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('equals', instance.equals);
  writeNotNull('in', instance.$in?.toList());
  writeNotNull('notIn', instance.notIn?.toList());
  writeNotNull('lt', instance.lt);
  writeNotNull('lte', instance.lte);
  writeNotNull('gt', instance.gt);
  writeNotNull('gte', instance.gte);
  writeNotNull('not', instance.not?.toJson());
  return val;
}

StringNullableListFilter _$StringNullableListFilterFromJson(
        Map<String, dynamic> json) =>
    StringNullableListFilter(
      equals: (json['equals'] as List<dynamic>?)?.map((e) => e as String),
      has: json['has'] as String?,
      hasEvery: (json['hasEvery'] as List<dynamic>?)?.map((e) => e as String),
      hasSome: (json['hasSome'] as List<dynamic>?)?.map((e) => e as String),
      isEmpty: json['isEmpty'] as bool?,
    );

Map<String, dynamic> _$StringNullableListFilterToJson(
    StringNullableListFilter instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('equals', instance.equals?.toList());
  writeNotNull('has', instance.has);
  writeNotNull('hasEvery', instance.hasEvery?.toList());
  writeNotNull('hasSome', instance.hasSome?.toList());
  writeNotNull('isEmpty', instance.isEmpty);
  return val;
}

BoolFilter _$BoolFilterFromJson(Map<String, dynamic> json) => BoolFilter(
      equals: json['equals'] as bool?,
      not: json['not'] == null
          ? null
          : NestedBoolFilter.fromJson(json['not'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$BoolFilterToJson(BoolFilter instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('equals', instance.equals);
  writeNotNull('not', instance.not?.toJson());
  return val;
}

PrismaAddressCountOrderByAggregateInput
    _$PrismaAddressCountOrderByAggregateInputFromJson(
            Map<String, dynamic> json) =>
        PrismaAddressCountOrderByAggregateInput(
          address: $enumDecodeNullable(_$SortOrderEnumMap, json['address']),
          status: $enumDecodeNullable(_$SortOrderEnumMap, json['status']),
          confirmedBalance:
              $enumDecodeNullable(_$SortOrderEnumMap, json['confirmedBalance']),
          unconfirmedBalance: $enumDecodeNullable(
              _$SortOrderEnumMap, json['unconfirmedBalance']),
          utxoHistory:
              $enumDecodeNullable(_$SortOrderEnumMap, json['utxoHistory']),
          needsUpdating:
              $enumDecodeNullable(_$SortOrderEnumMap, json['needsUpdating']),
        );

Map<String, dynamic> _$PrismaAddressCountOrderByAggregateInputToJson(
    PrismaAddressCountOrderByAggregateInput instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('address', _$SortOrderEnumMap[instance.address]);
  writeNotNull('status', _$SortOrderEnumMap[instance.status]);
  writeNotNull(
      'confirmedBalance', _$SortOrderEnumMap[instance.confirmedBalance]);
  writeNotNull(
      'unconfirmedBalance', _$SortOrderEnumMap[instance.unconfirmedBalance]);
  writeNotNull('utxoHistory', _$SortOrderEnumMap[instance.utxoHistory]);
  writeNotNull('needsUpdating', _$SortOrderEnumMap[instance.needsUpdating]);
  return val;
}

PrismaAddressAvgOrderByAggregateInput
    _$PrismaAddressAvgOrderByAggregateInputFromJson(
            Map<String, dynamic> json) =>
        PrismaAddressAvgOrderByAggregateInput(
          confirmedBalance:
              $enumDecodeNullable(_$SortOrderEnumMap, json['confirmedBalance']),
          unconfirmedBalance: $enumDecodeNullable(
              _$SortOrderEnumMap, json['unconfirmedBalance']),
        );

Map<String, dynamic> _$PrismaAddressAvgOrderByAggregateInputToJson(
    PrismaAddressAvgOrderByAggregateInput instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull(
      'confirmedBalance', _$SortOrderEnumMap[instance.confirmedBalance]);
  writeNotNull(
      'unconfirmedBalance', _$SortOrderEnumMap[instance.unconfirmedBalance]);
  return val;
}

PrismaAddressMaxOrderByAggregateInput
    _$PrismaAddressMaxOrderByAggregateInputFromJson(
            Map<String, dynamic> json) =>
        PrismaAddressMaxOrderByAggregateInput(
          address: $enumDecodeNullable(_$SortOrderEnumMap, json['address']),
          status: $enumDecodeNullable(_$SortOrderEnumMap, json['status']),
          confirmedBalance:
              $enumDecodeNullable(_$SortOrderEnumMap, json['confirmedBalance']),
          unconfirmedBalance: $enumDecodeNullable(
              _$SortOrderEnumMap, json['unconfirmedBalance']),
          needsUpdating:
              $enumDecodeNullable(_$SortOrderEnumMap, json['needsUpdating']),
        );

Map<String, dynamic> _$PrismaAddressMaxOrderByAggregateInputToJson(
    PrismaAddressMaxOrderByAggregateInput instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('address', _$SortOrderEnumMap[instance.address]);
  writeNotNull('status', _$SortOrderEnumMap[instance.status]);
  writeNotNull(
      'confirmedBalance', _$SortOrderEnumMap[instance.confirmedBalance]);
  writeNotNull(
      'unconfirmedBalance', _$SortOrderEnumMap[instance.unconfirmedBalance]);
  writeNotNull('needsUpdating', _$SortOrderEnumMap[instance.needsUpdating]);
  return val;
}

PrismaAddressMinOrderByAggregateInput
    _$PrismaAddressMinOrderByAggregateInputFromJson(
            Map<String, dynamic> json) =>
        PrismaAddressMinOrderByAggregateInput(
          address: $enumDecodeNullable(_$SortOrderEnumMap, json['address']),
          status: $enumDecodeNullable(_$SortOrderEnumMap, json['status']),
          confirmedBalance:
              $enumDecodeNullable(_$SortOrderEnumMap, json['confirmedBalance']),
          unconfirmedBalance: $enumDecodeNullable(
              _$SortOrderEnumMap, json['unconfirmedBalance']),
          needsUpdating:
              $enumDecodeNullable(_$SortOrderEnumMap, json['needsUpdating']),
        );

Map<String, dynamic> _$PrismaAddressMinOrderByAggregateInputToJson(
    PrismaAddressMinOrderByAggregateInput instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('address', _$SortOrderEnumMap[instance.address]);
  writeNotNull('status', _$SortOrderEnumMap[instance.status]);
  writeNotNull(
      'confirmedBalance', _$SortOrderEnumMap[instance.confirmedBalance]);
  writeNotNull(
      'unconfirmedBalance', _$SortOrderEnumMap[instance.unconfirmedBalance]);
  writeNotNull('needsUpdating', _$SortOrderEnumMap[instance.needsUpdating]);
  return val;
}

PrismaAddressSumOrderByAggregateInput
    _$PrismaAddressSumOrderByAggregateInputFromJson(
            Map<String, dynamic> json) =>
        PrismaAddressSumOrderByAggregateInput(
          confirmedBalance:
              $enumDecodeNullable(_$SortOrderEnumMap, json['confirmedBalance']),
          unconfirmedBalance: $enumDecodeNullable(
              _$SortOrderEnumMap, json['unconfirmedBalance']),
        );

Map<String, dynamic> _$PrismaAddressSumOrderByAggregateInputToJson(
    PrismaAddressSumOrderByAggregateInput instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull(
      'confirmedBalance', _$SortOrderEnumMap[instance.confirmedBalance]);
  writeNotNull(
      'unconfirmedBalance', _$SortOrderEnumMap[instance.unconfirmedBalance]);
  return val;
}

StringWithAggregatesFilter _$StringWithAggregatesFilterFromJson(
        Map<String, dynamic> json) =>
    StringWithAggregatesFilter(
      equals: json['equals'] as String?,
      $in: (json['in'] as List<dynamic>?)?.map((e) => e as String),
      notIn: (json['notIn'] as List<dynamic>?)?.map((e) => e as String),
      lt: json['lt'] as String?,
      lte: json['lte'] as String?,
      gt: json['gt'] as String?,
      gte: json['gte'] as String?,
      contains: json['contains'] as String?,
      startsWith: json['startsWith'] as String?,
      endsWith: json['endsWith'] as String?,
      mode: $enumDecodeNullable(_$QueryModeEnumMap, json['mode']),
      not: json['not'] == null
          ? null
          : NestedStringWithAggregatesFilter.fromJson(
              json['not'] as Map<String, dynamic>),
      $count: json['_count'] == null
          ? null
          : NestedIntFilter.fromJson(json['_count'] as Map<String, dynamic>),
      $min: json['_min'] == null
          ? null
          : NestedStringFilter.fromJson(json['_min'] as Map<String, dynamic>),
      $max: json['_max'] == null
          ? null
          : NestedStringFilter.fromJson(json['_max'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$StringWithAggregatesFilterToJson(
    StringWithAggregatesFilter instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('equals', instance.equals);
  writeNotNull('in', instance.$in?.toList());
  writeNotNull('notIn', instance.notIn?.toList());
  writeNotNull('lt', instance.lt);
  writeNotNull('lte', instance.lte);
  writeNotNull('gt', instance.gt);
  writeNotNull('gte', instance.gte);
  writeNotNull('contains', instance.contains);
  writeNotNull('startsWith', instance.startsWith);
  writeNotNull('endsWith', instance.endsWith);
  writeNotNull('mode', _$QueryModeEnumMap[instance.mode]);
  writeNotNull('not', instance.not?.toJson());
  writeNotNull('_count', instance.$count?.toJson());
  writeNotNull('_min', instance.$min?.toJson());
  writeNotNull('_max', instance.$max?.toJson());
  return val;
}

IntWithAggregatesFilter _$IntWithAggregatesFilterFromJson(
        Map<String, dynamic> json) =>
    IntWithAggregatesFilter(
      equals: json['equals'] as int?,
      $in: (json['in'] as List<dynamic>?)?.map((e) => e as int),
      notIn: (json['notIn'] as List<dynamic>?)?.map((e) => e as int),
      lt: json['lt'] as int?,
      lte: json['lte'] as int?,
      gt: json['gt'] as int?,
      gte: json['gte'] as int?,
      not: json['not'] == null
          ? null
          : NestedIntWithAggregatesFilter.fromJson(
              json['not'] as Map<String, dynamic>),
      $count: json['_count'] == null
          ? null
          : NestedIntFilter.fromJson(json['_count'] as Map<String, dynamic>),
      $avg: json['_avg'] == null
          ? null
          : NestedFloatFilter.fromJson(json['_avg'] as Map<String, dynamic>),
      $sum: json['_sum'] == null
          ? null
          : NestedIntFilter.fromJson(json['_sum'] as Map<String, dynamic>),
      $min: json['_min'] == null
          ? null
          : NestedIntFilter.fromJson(json['_min'] as Map<String, dynamic>),
      $max: json['_max'] == null
          ? null
          : NestedIntFilter.fromJson(json['_max'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$IntWithAggregatesFilterToJson(
    IntWithAggregatesFilter instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('equals', instance.equals);
  writeNotNull('in', instance.$in?.toList());
  writeNotNull('notIn', instance.notIn?.toList());
  writeNotNull('lt', instance.lt);
  writeNotNull('lte', instance.lte);
  writeNotNull('gt', instance.gt);
  writeNotNull('gte', instance.gte);
  writeNotNull('not', instance.not?.toJson());
  writeNotNull('_count', instance.$count?.toJson());
  writeNotNull('_avg', instance.$avg?.toJson());
  writeNotNull('_sum', instance.$sum?.toJson());
  writeNotNull('_min', instance.$min?.toJson());
  writeNotNull('_max', instance.$max?.toJson());
  return val;
}

BoolWithAggregatesFilter _$BoolWithAggregatesFilterFromJson(
        Map<String, dynamic> json) =>
    BoolWithAggregatesFilter(
      equals: json['equals'] as bool?,
      not: json['not'] == null
          ? null
          : NestedBoolWithAggregatesFilter.fromJson(
              json['not'] as Map<String, dynamic>),
      $count: json['_count'] == null
          ? null
          : NestedIntFilter.fromJson(json['_count'] as Map<String, dynamic>),
      $min: json['_min'] == null
          ? null
          : NestedBoolFilter.fromJson(json['_min'] as Map<String, dynamic>),
      $max: json['_max'] == null
          ? null
          : NestedBoolFilter.fromJson(json['_max'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$BoolWithAggregatesFilterToJson(
    BoolWithAggregatesFilter instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('equals', instance.equals);
  writeNotNull('not', instance.not?.toJson());
  writeNotNull('_count', instance.$count?.toJson());
  writeNotNull('_min', instance.$min?.toJson());
  writeNotNull('_max', instance.$max?.toJson());
  return val;
}

PrismaBlockCountOrderByAggregateInput
    _$PrismaBlockCountOrderByAggregateInputFromJson(
            Map<String, dynamic> json) =>
        PrismaBlockCountOrderByAggregateInput(
          id: $enumDecodeNullable(_$SortOrderEnumMap, json['id']),
          hash: $enumDecodeNullable(_$SortOrderEnumMap, json['hash']),
          blocktime: $enumDecodeNullable(_$SortOrderEnumMap, json['blocktime']),
        );

Map<String, dynamic> _$PrismaBlockCountOrderByAggregateInputToJson(
    PrismaBlockCountOrderByAggregateInput instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('id', _$SortOrderEnumMap[instance.id]);
  writeNotNull('hash', _$SortOrderEnumMap[instance.hash]);
  writeNotNull('blocktime', _$SortOrderEnumMap[instance.blocktime]);
  return val;
}

PrismaBlockAvgOrderByAggregateInput
    _$PrismaBlockAvgOrderByAggregateInputFromJson(Map<String, dynamic> json) =>
        PrismaBlockAvgOrderByAggregateInput(
          id: $enumDecodeNullable(_$SortOrderEnumMap, json['id']),
          blocktime: $enumDecodeNullable(_$SortOrderEnumMap, json['blocktime']),
        );

Map<String, dynamic> _$PrismaBlockAvgOrderByAggregateInputToJson(
    PrismaBlockAvgOrderByAggregateInput instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('id', _$SortOrderEnumMap[instance.id]);
  writeNotNull('blocktime', _$SortOrderEnumMap[instance.blocktime]);
  return val;
}

PrismaBlockMaxOrderByAggregateInput
    _$PrismaBlockMaxOrderByAggregateInputFromJson(Map<String, dynamic> json) =>
        PrismaBlockMaxOrderByAggregateInput(
          id: $enumDecodeNullable(_$SortOrderEnumMap, json['id']),
          hash: $enumDecodeNullable(_$SortOrderEnumMap, json['hash']),
          blocktime: $enumDecodeNullable(_$SortOrderEnumMap, json['blocktime']),
        );

Map<String, dynamic> _$PrismaBlockMaxOrderByAggregateInputToJson(
    PrismaBlockMaxOrderByAggregateInput instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('id', _$SortOrderEnumMap[instance.id]);
  writeNotNull('hash', _$SortOrderEnumMap[instance.hash]);
  writeNotNull('blocktime', _$SortOrderEnumMap[instance.blocktime]);
  return val;
}

PrismaBlockMinOrderByAggregateInput
    _$PrismaBlockMinOrderByAggregateInputFromJson(Map<String, dynamic> json) =>
        PrismaBlockMinOrderByAggregateInput(
          id: $enumDecodeNullable(_$SortOrderEnumMap, json['id']),
          hash: $enumDecodeNullable(_$SortOrderEnumMap, json['hash']),
          blocktime: $enumDecodeNullable(_$SortOrderEnumMap, json['blocktime']),
        );

Map<String, dynamic> _$PrismaBlockMinOrderByAggregateInputToJson(
    PrismaBlockMinOrderByAggregateInput instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('id', _$SortOrderEnumMap[instance.id]);
  writeNotNull('hash', _$SortOrderEnumMap[instance.hash]);
  writeNotNull('blocktime', _$SortOrderEnumMap[instance.blocktime]);
  return val;
}

PrismaBlockSumOrderByAggregateInput
    _$PrismaBlockSumOrderByAggregateInputFromJson(Map<String, dynamic> json) =>
        PrismaBlockSumOrderByAggregateInput(
          id: $enumDecodeNullable(_$SortOrderEnumMap, json['id']),
          blocktime: $enumDecodeNullable(_$SortOrderEnumMap, json['blocktime']),
        );

Map<String, dynamic> _$PrismaBlockSumOrderByAggregateInputToJson(
    PrismaBlockSumOrderByAggregateInput instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('id', _$SortOrderEnumMap[instance.id]);
  writeNotNull('blocktime', _$SortOrderEnumMap[instance.blocktime]);
  return val;
}

FloatFilter _$FloatFilterFromJson(Map<String, dynamic> json) => FloatFilter(
      equals: (json['equals'] as num?)?.toDouble(),
      $in: (json['in'] as List<dynamic>?)?.map((e) => (e as num).toDouble()),
      notIn:
          (json['notIn'] as List<dynamic>?)?.map((e) => (e as num).toDouble()),
      lt: (json['lt'] as num?)?.toDouble(),
      lte: (json['lte'] as num?)?.toDouble(),
      gt: (json['gt'] as num?)?.toDouble(),
      gte: (json['gte'] as num?)?.toDouble(),
      not: json['not'] == null
          ? null
          : NestedFloatFilter.fromJson(json['not'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$FloatFilterToJson(FloatFilter instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('equals', instance.equals);
  writeNotNull('in', instance.$in?.toList());
  writeNotNull('notIn', instance.notIn?.toList());
  writeNotNull('lt', instance.lt);
  writeNotNull('lte', instance.lte);
  writeNotNull('gt', instance.gt);
  writeNotNull('gte', instance.gte);
  writeNotNull('not', instance.not?.toJson());
  return val;
}

PrismaUtxoTxidTxposCompoundUniqueInput
    _$PrismaUtxoTxidTxposCompoundUniqueInputFromJson(
            Map<String, dynamic> json) =>
        PrismaUtxoTxidTxposCompoundUniqueInput(
          txid: json['txid'] as String,
          txpos: json['txpos'] as int,
        );

Map<String, dynamic> _$PrismaUtxoTxidTxposCompoundUniqueInputToJson(
        PrismaUtxoTxidTxposCompoundUniqueInput instance) =>
    <String, dynamic>{
      'txid': instance.txid,
      'txpos': instance.txpos,
    };

PrismaUtxoCountOrderByAggregateInput
    _$PrismaUtxoCountOrderByAggregateInputFromJson(Map<String, dynamic> json) =>
        PrismaUtxoCountOrderByAggregateInput(
          txid: $enumDecodeNullable(_$SortOrderEnumMap, json['txid']),
          txpos: $enumDecodeNullable(_$SortOrderEnumMap, json['txpos']),
          block: $enumDecodeNullable(_$SortOrderEnumMap, json['block']),
          value: $enumDecodeNullable(_$SortOrderEnumMap, json['value']),
          address: $enumDecodeNullable(_$SortOrderEnumMap, json['address']),
          flaggedForDelete:
              $enumDecodeNullable(_$SortOrderEnumMap, json['flaggedForDelete']),
        );

Map<String, dynamic> _$PrismaUtxoCountOrderByAggregateInputToJson(
    PrismaUtxoCountOrderByAggregateInput instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('txid', _$SortOrderEnumMap[instance.txid]);
  writeNotNull('txpos', _$SortOrderEnumMap[instance.txpos]);
  writeNotNull('block', _$SortOrderEnumMap[instance.block]);
  writeNotNull('value', _$SortOrderEnumMap[instance.value]);
  writeNotNull('address', _$SortOrderEnumMap[instance.address]);
  writeNotNull(
      'flaggedForDelete', _$SortOrderEnumMap[instance.flaggedForDelete]);
  return val;
}

PrismaUtxoAvgOrderByAggregateInput _$PrismaUtxoAvgOrderByAggregateInputFromJson(
        Map<String, dynamic> json) =>
    PrismaUtxoAvgOrderByAggregateInput(
      txpos: $enumDecodeNullable(_$SortOrderEnumMap, json['txpos']),
      block: $enumDecodeNullable(_$SortOrderEnumMap, json['block']),
      value: $enumDecodeNullable(_$SortOrderEnumMap, json['value']),
    );

Map<String, dynamic> _$PrismaUtxoAvgOrderByAggregateInputToJson(
    PrismaUtxoAvgOrderByAggregateInput instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('txpos', _$SortOrderEnumMap[instance.txpos]);
  writeNotNull('block', _$SortOrderEnumMap[instance.block]);
  writeNotNull('value', _$SortOrderEnumMap[instance.value]);
  return val;
}

PrismaUtxoMaxOrderByAggregateInput _$PrismaUtxoMaxOrderByAggregateInputFromJson(
        Map<String, dynamic> json) =>
    PrismaUtxoMaxOrderByAggregateInput(
      txid: $enumDecodeNullable(_$SortOrderEnumMap, json['txid']),
      txpos: $enumDecodeNullable(_$SortOrderEnumMap, json['txpos']),
      block: $enumDecodeNullable(_$SortOrderEnumMap, json['block']),
      value: $enumDecodeNullable(_$SortOrderEnumMap, json['value']),
      address: $enumDecodeNullable(_$SortOrderEnumMap, json['address']),
      flaggedForDelete:
          $enumDecodeNullable(_$SortOrderEnumMap, json['flaggedForDelete']),
    );

Map<String, dynamic> _$PrismaUtxoMaxOrderByAggregateInputToJson(
    PrismaUtxoMaxOrderByAggregateInput instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('txid', _$SortOrderEnumMap[instance.txid]);
  writeNotNull('txpos', _$SortOrderEnumMap[instance.txpos]);
  writeNotNull('block', _$SortOrderEnumMap[instance.block]);
  writeNotNull('value', _$SortOrderEnumMap[instance.value]);
  writeNotNull('address', _$SortOrderEnumMap[instance.address]);
  writeNotNull(
      'flaggedForDelete', _$SortOrderEnumMap[instance.flaggedForDelete]);
  return val;
}

PrismaUtxoMinOrderByAggregateInput _$PrismaUtxoMinOrderByAggregateInputFromJson(
        Map<String, dynamic> json) =>
    PrismaUtxoMinOrderByAggregateInput(
      txid: $enumDecodeNullable(_$SortOrderEnumMap, json['txid']),
      txpos: $enumDecodeNullable(_$SortOrderEnumMap, json['txpos']),
      block: $enumDecodeNullable(_$SortOrderEnumMap, json['block']),
      value: $enumDecodeNullable(_$SortOrderEnumMap, json['value']),
      address: $enumDecodeNullable(_$SortOrderEnumMap, json['address']),
      flaggedForDelete:
          $enumDecodeNullable(_$SortOrderEnumMap, json['flaggedForDelete']),
    );

Map<String, dynamic> _$PrismaUtxoMinOrderByAggregateInputToJson(
    PrismaUtxoMinOrderByAggregateInput instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('txid', _$SortOrderEnumMap[instance.txid]);
  writeNotNull('txpos', _$SortOrderEnumMap[instance.txpos]);
  writeNotNull('block', _$SortOrderEnumMap[instance.block]);
  writeNotNull('value', _$SortOrderEnumMap[instance.value]);
  writeNotNull('address', _$SortOrderEnumMap[instance.address]);
  writeNotNull(
      'flaggedForDelete', _$SortOrderEnumMap[instance.flaggedForDelete]);
  return val;
}

PrismaUtxoSumOrderByAggregateInput _$PrismaUtxoSumOrderByAggregateInputFromJson(
        Map<String, dynamic> json) =>
    PrismaUtxoSumOrderByAggregateInput(
      txpos: $enumDecodeNullable(_$SortOrderEnumMap, json['txpos']),
      block: $enumDecodeNullable(_$SortOrderEnumMap, json['block']),
      value: $enumDecodeNullable(_$SortOrderEnumMap, json['value']),
    );

Map<String, dynamic> _$PrismaUtxoSumOrderByAggregateInputToJson(
    PrismaUtxoSumOrderByAggregateInput instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('txpos', _$SortOrderEnumMap[instance.txpos]);
  writeNotNull('block', _$SortOrderEnumMap[instance.block]);
  writeNotNull('value', _$SortOrderEnumMap[instance.value]);
  return val;
}

FloatWithAggregatesFilter _$FloatWithAggregatesFilterFromJson(
        Map<String, dynamic> json) =>
    FloatWithAggregatesFilter(
      equals: (json['equals'] as num?)?.toDouble(),
      $in: (json['in'] as List<dynamic>?)?.map((e) => (e as num).toDouble()),
      notIn:
          (json['notIn'] as List<dynamic>?)?.map((e) => (e as num).toDouble()),
      lt: (json['lt'] as num?)?.toDouble(),
      lte: (json['lte'] as num?)?.toDouble(),
      gt: (json['gt'] as num?)?.toDouble(),
      gte: (json['gte'] as num?)?.toDouble(),
      not: json['not'] == null
          ? null
          : NestedFloatWithAggregatesFilter.fromJson(
              json['not'] as Map<String, dynamic>),
      $count: json['_count'] == null
          ? null
          : NestedIntFilter.fromJson(json['_count'] as Map<String, dynamic>),
      $avg: json['_avg'] == null
          ? null
          : NestedFloatFilter.fromJson(json['_avg'] as Map<String, dynamic>),
      $sum: json['_sum'] == null
          ? null
          : NestedFloatFilter.fromJson(json['_sum'] as Map<String, dynamic>),
      $min: json['_min'] == null
          ? null
          : NestedFloatFilter.fromJson(json['_min'] as Map<String, dynamic>),
      $max: json['_max'] == null
          ? null
          : NestedFloatFilter.fromJson(json['_max'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$FloatWithAggregatesFilterToJson(
    FloatWithAggregatesFilter instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('equals', instance.equals);
  writeNotNull('in', instance.$in?.toList());
  writeNotNull('notIn', instance.notIn?.toList());
  writeNotNull('lt', instance.lt);
  writeNotNull('lte', instance.lte);
  writeNotNull('gt', instance.gt);
  writeNotNull('gte', instance.gte);
  writeNotNull('not', instance.not?.toJson());
  writeNotNull('_count', instance.$count?.toJson());
  writeNotNull('_avg', instance.$avg?.toJson());
  writeNotNull('_sum', instance.$sum?.toJson());
  writeNotNull('_min', instance.$min?.toJson());
  writeNotNull('_max', instance.$max?.toJson());
  return val;
}

PrismaAddressCreateutxoHistoryInput
    _$PrismaAddressCreateutxoHistoryInputFromJson(Map<String, dynamic> json) =>
        PrismaAddressCreateutxoHistoryInput(
          set: (json['set'] as List<dynamic>).map((e) => e as String),
        );

Map<String, dynamic> _$PrismaAddressCreateutxoHistoryInputToJson(
        PrismaAddressCreateutxoHistoryInput instance) =>
    <String, dynamic>{
      'set': instance.set.toList(),
    };

StringFieldUpdateOperationsInput _$StringFieldUpdateOperationsInputFromJson(
        Map<String, dynamic> json) =>
    StringFieldUpdateOperationsInput(
      set: json['set'] as String?,
    );

Map<String, dynamic> _$StringFieldUpdateOperationsInputToJson(
    StringFieldUpdateOperationsInput instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('set', instance.set);
  return val;
}

IntFieldUpdateOperationsInput _$IntFieldUpdateOperationsInputFromJson(
        Map<String, dynamic> json) =>
    IntFieldUpdateOperationsInput(
      set: json['set'] as int?,
      increment: json['increment'] as int?,
      decrement: json['decrement'] as int?,
      multiply: json['multiply'] as int?,
      divide: json['divide'] as int?,
    );

Map<String, dynamic> _$IntFieldUpdateOperationsInputToJson(
    IntFieldUpdateOperationsInput instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('set', instance.set);
  writeNotNull('increment', instance.increment);
  writeNotNull('decrement', instance.decrement);
  writeNotNull('multiply', instance.multiply);
  writeNotNull('divide', instance.divide);
  return val;
}

PrismaAddressUpdateutxoHistoryInput
    _$PrismaAddressUpdateutxoHistoryInputFromJson(Map<String, dynamic> json) =>
        PrismaAddressUpdateutxoHistoryInput(
          set: (json['set'] as List<dynamic>?)?.map((e) => e as String),
          push: (json['push'] as List<dynamic>?)?.map((e) => e as String),
        );

Map<String, dynamic> _$PrismaAddressUpdateutxoHistoryInputToJson(
    PrismaAddressUpdateutxoHistoryInput instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('set', instance.set?.toList());
  writeNotNull('push', instance.push?.toList());
  return val;
}

BoolFieldUpdateOperationsInput _$BoolFieldUpdateOperationsInputFromJson(
        Map<String, dynamic> json) =>
    BoolFieldUpdateOperationsInput(
      set: json['set'] as bool?,
    );

Map<String, dynamic> _$BoolFieldUpdateOperationsInputToJson(
    BoolFieldUpdateOperationsInput instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('set', instance.set);
  return val;
}

FloatFieldUpdateOperationsInput _$FloatFieldUpdateOperationsInputFromJson(
        Map<String, dynamic> json) =>
    FloatFieldUpdateOperationsInput(
      set: (json['set'] as num?)?.toDouble(),
      increment: (json['increment'] as num?)?.toDouble(),
      decrement: (json['decrement'] as num?)?.toDouble(),
      multiply: (json['multiply'] as num?)?.toDouble(),
      divide: (json['divide'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$FloatFieldUpdateOperationsInputToJson(
    FloatFieldUpdateOperationsInput instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('set', instance.set);
  writeNotNull('increment', instance.increment);
  writeNotNull('decrement', instance.decrement);
  writeNotNull('multiply', instance.multiply);
  writeNotNull('divide', instance.divide);
  return val;
}

NestedStringFilter _$NestedStringFilterFromJson(Map<String, dynamic> json) =>
    NestedStringFilter(
      equals: json['equals'] as String?,
      $in: (json['in'] as List<dynamic>?)?.map((e) => e as String),
      notIn: (json['notIn'] as List<dynamic>?)?.map((e) => e as String),
      lt: json['lt'] as String?,
      lte: json['lte'] as String?,
      gt: json['gt'] as String?,
      gte: json['gte'] as String?,
      contains: json['contains'] as String?,
      startsWith: json['startsWith'] as String?,
      endsWith: json['endsWith'] as String?,
      not: json['not'] == null
          ? null
          : NestedStringFilter.fromJson(json['not'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$NestedStringFilterToJson(NestedStringFilter instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('equals', instance.equals);
  writeNotNull('in', instance.$in?.toList());
  writeNotNull('notIn', instance.notIn?.toList());
  writeNotNull('lt', instance.lt);
  writeNotNull('lte', instance.lte);
  writeNotNull('gt', instance.gt);
  writeNotNull('gte', instance.gte);
  writeNotNull('contains', instance.contains);
  writeNotNull('startsWith', instance.startsWith);
  writeNotNull('endsWith', instance.endsWith);
  writeNotNull('not', instance.not?.toJson());
  return val;
}

NestedIntFilter _$NestedIntFilterFromJson(Map<String, dynamic> json) =>
    NestedIntFilter(
      equals: json['equals'] as int?,
      $in: (json['in'] as List<dynamic>?)?.map((e) => e as int),
      notIn: (json['notIn'] as List<dynamic>?)?.map((e) => e as int),
      lt: json['lt'] as int?,
      lte: json['lte'] as int?,
      gt: json['gt'] as int?,
      gte: json['gte'] as int?,
      not: json['not'] == null
          ? null
          : NestedIntFilter.fromJson(json['not'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$NestedIntFilterToJson(NestedIntFilter instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('equals', instance.equals);
  writeNotNull('in', instance.$in?.toList());
  writeNotNull('notIn', instance.notIn?.toList());
  writeNotNull('lt', instance.lt);
  writeNotNull('lte', instance.lte);
  writeNotNull('gt', instance.gt);
  writeNotNull('gte', instance.gte);
  writeNotNull('not', instance.not?.toJson());
  return val;
}

NestedBoolFilter _$NestedBoolFilterFromJson(Map<String, dynamic> json) =>
    NestedBoolFilter(
      equals: json['equals'] as bool?,
      not: json['not'] == null
          ? null
          : NestedBoolFilter.fromJson(json['not'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$NestedBoolFilterToJson(NestedBoolFilter instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('equals', instance.equals);
  writeNotNull('not', instance.not?.toJson());
  return val;
}

NestedStringWithAggregatesFilter _$NestedStringWithAggregatesFilterFromJson(
        Map<String, dynamic> json) =>
    NestedStringWithAggregatesFilter(
      equals: json['equals'] as String?,
      $in: (json['in'] as List<dynamic>?)?.map((e) => e as String),
      notIn: (json['notIn'] as List<dynamic>?)?.map((e) => e as String),
      lt: json['lt'] as String?,
      lte: json['lte'] as String?,
      gt: json['gt'] as String?,
      gte: json['gte'] as String?,
      contains: json['contains'] as String?,
      startsWith: json['startsWith'] as String?,
      endsWith: json['endsWith'] as String?,
      not: json['not'] == null
          ? null
          : NestedStringWithAggregatesFilter.fromJson(
              json['not'] as Map<String, dynamic>),
      $count: json['_count'] == null
          ? null
          : NestedIntFilter.fromJson(json['_count'] as Map<String, dynamic>),
      $min: json['_min'] == null
          ? null
          : NestedStringFilter.fromJson(json['_min'] as Map<String, dynamic>),
      $max: json['_max'] == null
          ? null
          : NestedStringFilter.fromJson(json['_max'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$NestedStringWithAggregatesFilterToJson(
    NestedStringWithAggregatesFilter instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('equals', instance.equals);
  writeNotNull('in', instance.$in?.toList());
  writeNotNull('notIn', instance.notIn?.toList());
  writeNotNull('lt', instance.lt);
  writeNotNull('lte', instance.lte);
  writeNotNull('gt', instance.gt);
  writeNotNull('gte', instance.gte);
  writeNotNull('contains', instance.contains);
  writeNotNull('startsWith', instance.startsWith);
  writeNotNull('endsWith', instance.endsWith);
  writeNotNull('not', instance.not?.toJson());
  writeNotNull('_count', instance.$count?.toJson());
  writeNotNull('_min', instance.$min?.toJson());
  writeNotNull('_max', instance.$max?.toJson());
  return val;
}

NestedIntWithAggregatesFilter _$NestedIntWithAggregatesFilterFromJson(
        Map<String, dynamic> json) =>
    NestedIntWithAggregatesFilter(
      equals: json['equals'] as int?,
      $in: (json['in'] as List<dynamic>?)?.map((e) => e as int),
      notIn: (json['notIn'] as List<dynamic>?)?.map((e) => e as int),
      lt: json['lt'] as int?,
      lte: json['lte'] as int?,
      gt: json['gt'] as int?,
      gte: json['gte'] as int?,
      not: json['not'] == null
          ? null
          : NestedIntWithAggregatesFilter.fromJson(
              json['not'] as Map<String, dynamic>),
      $count: json['_count'] == null
          ? null
          : NestedIntFilter.fromJson(json['_count'] as Map<String, dynamic>),
      $avg: json['_avg'] == null
          ? null
          : NestedFloatFilter.fromJson(json['_avg'] as Map<String, dynamic>),
      $sum: json['_sum'] == null
          ? null
          : NestedIntFilter.fromJson(json['_sum'] as Map<String, dynamic>),
      $min: json['_min'] == null
          ? null
          : NestedIntFilter.fromJson(json['_min'] as Map<String, dynamic>),
      $max: json['_max'] == null
          ? null
          : NestedIntFilter.fromJson(json['_max'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$NestedIntWithAggregatesFilterToJson(
    NestedIntWithAggregatesFilter instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('equals', instance.equals);
  writeNotNull('in', instance.$in?.toList());
  writeNotNull('notIn', instance.notIn?.toList());
  writeNotNull('lt', instance.lt);
  writeNotNull('lte', instance.lte);
  writeNotNull('gt', instance.gt);
  writeNotNull('gte', instance.gte);
  writeNotNull('not', instance.not?.toJson());
  writeNotNull('_count', instance.$count?.toJson());
  writeNotNull('_avg', instance.$avg?.toJson());
  writeNotNull('_sum', instance.$sum?.toJson());
  writeNotNull('_min', instance.$min?.toJson());
  writeNotNull('_max', instance.$max?.toJson());
  return val;
}

NestedFloatFilter _$NestedFloatFilterFromJson(Map<String, dynamic> json) =>
    NestedFloatFilter(
      equals: (json['equals'] as num?)?.toDouble(),
      $in: (json['in'] as List<dynamic>?)?.map((e) => (e as num).toDouble()),
      notIn:
          (json['notIn'] as List<dynamic>?)?.map((e) => (e as num).toDouble()),
      lt: (json['lt'] as num?)?.toDouble(),
      lte: (json['lte'] as num?)?.toDouble(),
      gt: (json['gt'] as num?)?.toDouble(),
      gte: (json['gte'] as num?)?.toDouble(),
      not: json['not'] == null
          ? null
          : NestedFloatFilter.fromJson(json['not'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$NestedFloatFilterToJson(NestedFloatFilter instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('equals', instance.equals);
  writeNotNull('in', instance.$in?.toList());
  writeNotNull('notIn', instance.notIn?.toList());
  writeNotNull('lt', instance.lt);
  writeNotNull('lte', instance.lte);
  writeNotNull('gt', instance.gt);
  writeNotNull('gte', instance.gte);
  writeNotNull('not', instance.not?.toJson());
  return val;
}

NestedBoolWithAggregatesFilter _$NestedBoolWithAggregatesFilterFromJson(
        Map<String, dynamic> json) =>
    NestedBoolWithAggregatesFilter(
      equals: json['equals'] as bool?,
      not: json['not'] == null
          ? null
          : NestedBoolWithAggregatesFilter.fromJson(
              json['not'] as Map<String, dynamic>),
      $count: json['_count'] == null
          ? null
          : NestedIntFilter.fromJson(json['_count'] as Map<String, dynamic>),
      $min: json['_min'] == null
          ? null
          : NestedBoolFilter.fromJson(json['_min'] as Map<String, dynamic>),
      $max: json['_max'] == null
          ? null
          : NestedBoolFilter.fromJson(json['_max'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$NestedBoolWithAggregatesFilterToJson(
    NestedBoolWithAggregatesFilter instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('equals', instance.equals);
  writeNotNull('not', instance.not?.toJson());
  writeNotNull('_count', instance.$count?.toJson());
  writeNotNull('_min', instance.$min?.toJson());
  writeNotNull('_max', instance.$max?.toJson());
  return val;
}

NestedFloatWithAggregatesFilter _$NestedFloatWithAggregatesFilterFromJson(
        Map<String, dynamic> json) =>
    NestedFloatWithAggregatesFilter(
      equals: (json['equals'] as num?)?.toDouble(),
      $in: (json['in'] as List<dynamic>?)?.map((e) => (e as num).toDouble()),
      notIn:
          (json['notIn'] as List<dynamic>?)?.map((e) => (e as num).toDouble()),
      lt: (json['lt'] as num?)?.toDouble(),
      lte: (json['lte'] as num?)?.toDouble(),
      gt: (json['gt'] as num?)?.toDouble(),
      gte: (json['gte'] as num?)?.toDouble(),
      not: json['not'] == null
          ? null
          : NestedFloatWithAggregatesFilter.fromJson(
              json['not'] as Map<String, dynamic>),
      $count: json['_count'] == null
          ? null
          : NestedIntFilter.fromJson(json['_count'] as Map<String, dynamic>),
      $avg: json['_avg'] == null
          ? null
          : NestedFloatFilter.fromJson(json['_avg'] as Map<String, dynamic>),
      $sum: json['_sum'] == null
          ? null
          : NestedFloatFilter.fromJson(json['_sum'] as Map<String, dynamic>),
      $min: json['_min'] == null
          ? null
          : NestedFloatFilter.fromJson(json['_min'] as Map<String, dynamic>),
      $max: json['_max'] == null
          ? null
          : NestedFloatFilter.fromJson(json['_max'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$NestedFloatWithAggregatesFilterToJson(
    NestedFloatWithAggregatesFilter instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('equals', instance.equals);
  writeNotNull('in', instance.$in?.toList());
  writeNotNull('notIn', instance.notIn?.toList());
  writeNotNull('lt', instance.lt);
  writeNotNull('lte', instance.lte);
  writeNotNull('gt', instance.gt);
  writeNotNull('gte', instance.gte);
  writeNotNull('not', instance.not?.toJson());
  writeNotNull('_count', instance.$count?.toJson());
  writeNotNull('_avg', instance.$avg?.toJson());
  writeNotNull('_sum', instance.$sum?.toJson());
  writeNotNull('_min', instance.$min?.toJson());
  writeNotNull('_max', instance.$max?.toJson());
  return val;
}

PrismaAddress _$PrismaAddressFromJson(Map<String, dynamic> json) =>
    PrismaAddress(
      address: json['address'] as String,
      status: json['status'] as String,
      confirmedBalance: json['confirmedBalance'] as int,
      unconfirmedBalance: json['unconfirmedBalance'] as int,
      utxoHistory:
          (json['utxoHistory'] as List<dynamic>?)?.map((e) => e as String),
      needsUpdating: json['needsUpdating'] as bool,
    );

Map<String, dynamic> _$PrismaAddressToJson(PrismaAddress instance) {
  final val = <String, dynamic>{
    'address': instance.address,
    'status': instance.status,
    'confirmedBalance': instance.confirmedBalance,
    'unconfirmedBalance': instance.unconfirmedBalance,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('utxoHistory', instance.utxoHistory?.toList());
  val['needsUpdating'] = instance.needsUpdating;
  return val;
}

PrismaBlock _$PrismaBlockFromJson(Map<String, dynamic> json) => PrismaBlock(
      id: json['id'] as int,
      hash: json['hash'] as String,
      blocktime: json['blocktime'] as int,
    );

Map<String, dynamic> _$PrismaBlockToJson(PrismaBlock instance) =>
    <String, dynamic>{
      'id': instance.id,
      'hash': instance.hash,
      'blocktime': instance.blocktime,
    };

PrismaUtxo _$PrismaUtxoFromJson(Map<String, dynamic> json) => PrismaUtxo(
      txid: json['txid'] as String,
      txpos: json['txpos'] as int,
      block: json['block'] as int,
      value: (json['value'] as num).toDouble(),
      address: json['address'] as String,
      flaggedForDelete: json['flaggedForDelete'] as bool,
    );

Map<String, dynamic> _$PrismaUtxoToJson(PrismaUtxo instance) =>
    <String, dynamic>{
      'txid': instance.txid,
      'txpos': instance.txpos,
      'block': instance.block,
      'value': instance.value,
      'address': instance.address,
      'flaggedForDelete': instance.flaggedForDelete,
    };

PrismaAddressGroupByOutputType _$PrismaAddressGroupByOutputTypeFromJson(
        Map<String, dynamic> json) =>
    PrismaAddressGroupByOutputType(
      address: json['address'] as String?,
      status: json['status'] as String?,
      confirmedBalance: json['confirmedBalance'] as int?,
      unconfirmedBalance: json['unconfirmedBalance'] as int?,
      utxoHistory:
          (json['utxoHistory'] as List<dynamic>?)?.map((e) => e as String),
      needsUpdating: json['needsUpdating'] as bool?,
    );

Map<String, dynamic> _$PrismaAddressGroupByOutputTypeToJson(
    PrismaAddressGroupByOutputType instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('address', instance.address);
  writeNotNull('status', instance.status);
  writeNotNull('confirmedBalance', instance.confirmedBalance);
  writeNotNull('unconfirmedBalance', instance.unconfirmedBalance);
  writeNotNull('utxoHistory', instance.utxoHistory?.toList());
  writeNotNull('needsUpdating', instance.needsUpdating);
  return val;
}

PrismaBlockGroupByOutputType _$PrismaBlockGroupByOutputTypeFromJson(
        Map<String, dynamic> json) =>
    PrismaBlockGroupByOutputType(
      id: json['id'] as int?,
      hash: json['hash'] as String?,
      blocktime: json['blocktime'] as int?,
    );

Map<String, dynamic> _$PrismaBlockGroupByOutputTypeToJson(
    PrismaBlockGroupByOutputType instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('id', instance.id);
  writeNotNull('hash', instance.hash);
  writeNotNull('blocktime', instance.blocktime);
  return val;
}

PrismaUtxoGroupByOutputType _$PrismaUtxoGroupByOutputTypeFromJson(
        Map<String, dynamic> json) =>
    PrismaUtxoGroupByOutputType(
      txid: json['txid'] as String?,
      txpos: json['txpos'] as int?,
      block: json['block'] as int?,
      value: (json['value'] as num?)?.toDouble(),
      address: json['address'] as String?,
      flaggedForDelete: json['flaggedForDelete'] as bool?,
    );

Map<String, dynamic> _$PrismaUtxoGroupByOutputTypeToJson(
    PrismaUtxoGroupByOutputType instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('txid', instance.txid);
  writeNotNull('txpos', instance.txpos);
  writeNotNull('block', instance.block);
  writeNotNull('value', instance.value);
  writeNotNull('address', instance.address);
  writeNotNull('flaggedForDelete', instance.flaggedForDelete);
  return val;
}

AffectedRowsOutput _$AffectedRowsOutputFromJson(Map<String, dynamic> json) =>
    AffectedRowsOutput(
      count: json['count'] as int?,
    );

Map<String, dynamic> _$AffectedRowsOutputToJson(AffectedRowsOutput instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('count', instance.count);
  return val;
}

Map<String, dynamic> _$DatasourcesToJson(Datasources instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('db', instance.db);
  return val;
}
