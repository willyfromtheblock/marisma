// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:json_annotation/json_annotation.dart';
import 'package:orm/binary_engine.dart' as _i5;
import 'package:orm/engine_core.dart' as _i3;
import 'package:orm/graphql.dart' as _i2;
import 'package:orm/logger.dart' as _i4;
import 'package:orm/orm.dart' as _i1;
import 'package:orm/orm.dart' show DateTimeJsonConverter;

part 'prisma_client.g.dart';

enum PrismaAddressScalarFieldEnum implements _i1.PrismaEnum {
  address,
  status,
  confirmedBalance,
  unconfirmedBalance,
  utxoHistory,
  needsUpdating;

  @override
  String? get originalName => null;
}

enum PrismaBlockScalarFieldEnum implements _i1.PrismaEnum {
  id,
  hash,
  blocktime;

  @override
  String? get originalName => null;
}

enum PrismaUtxoScalarFieldEnum implements _i1.PrismaEnum {
  id,
  txid,
  txpos,
  block,
  value,
  addresses,
  flaggedForDelete;

  @override
  String? get originalName => null;
}

enum QueryMode implements _i1.PrismaEnum {
  @JsonValue('default')
  $default(r'default'),
  insensitive;

  const QueryMode([this.originalName]);

  @override
  final String? originalName;
}

enum SortOrder implements _i1.PrismaEnum {
  asc,
  desc;

  @override
  String? get originalName => null;
}

@_i1.jsonSerializable
class PrismaAddressWhereInput implements _i1.JsonSerializable {
  const PrismaAddressWhereInput({
    this.AND,
    this.OR,
    this.NOT,
    this.address,
    this.status,
    this.confirmedBalance,
    this.unconfirmedBalance,
    this.utxoHistory,
    this.needsUpdating,
  });

  factory PrismaAddressWhereInput.fromJson(Map<String, dynamic> json) =>
      _$PrismaAddressWhereInputFromJson(json);

  final Iterable<PrismaAddressWhereInput>? AND;

  final Iterable<PrismaAddressWhereInput>? OR;

  final Iterable<PrismaAddressWhereInput>? NOT;

  final StringFilter? address;

  final StringFilter? status;

  final IntFilter? confirmedBalance;

  final IntFilter? unconfirmedBalance;

  final StringNullableListFilter? utxoHistory;

  final BoolFilter? needsUpdating;

  @override
  Map<String, dynamic> toJson() => _$PrismaAddressWhereInputToJson(this);
}

@_i1.jsonSerializable
class PrismaAddressOrderByWithRelationInput implements _i1.JsonSerializable {
  const PrismaAddressOrderByWithRelationInput({
    this.address,
    this.status,
    this.confirmedBalance,
    this.unconfirmedBalance,
    this.utxoHistory,
    this.needsUpdating,
  });

  factory PrismaAddressOrderByWithRelationInput.fromJson(
          Map<String, dynamic> json) =>
      _$PrismaAddressOrderByWithRelationInputFromJson(json);

  final SortOrder? address;

  final SortOrder? status;

  final SortOrder? confirmedBalance;

  final SortOrder? unconfirmedBalance;

  final SortOrder? utxoHistory;

  final SortOrder? needsUpdating;

  @override
  Map<String, dynamic> toJson() =>
      _$PrismaAddressOrderByWithRelationInputToJson(this);
}

@_i1.jsonSerializable
class PrismaAddressWhereUniqueInput implements _i1.JsonSerializable {
  const PrismaAddressWhereUniqueInput({this.address});

  factory PrismaAddressWhereUniqueInput.fromJson(Map<String, dynamic> json) =>
      _$PrismaAddressWhereUniqueInputFromJson(json);

  final String? address;

  @override
  Map<String, dynamic> toJson() => _$PrismaAddressWhereUniqueInputToJson(this);
}

@_i1.jsonSerializable
class PrismaAddressOrderByWithAggregationInput implements _i1.JsonSerializable {
  const PrismaAddressOrderByWithAggregationInput({
    this.address,
    this.status,
    this.confirmedBalance,
    this.unconfirmedBalance,
    this.utxoHistory,
    this.needsUpdating,
    this.$count,
    this.$avg,
    this.$max,
    this.$min,
    this.$sum,
  });

  factory PrismaAddressOrderByWithAggregationInput.fromJson(
          Map<String, dynamic> json) =>
      _$PrismaAddressOrderByWithAggregationInputFromJson(json);

  final SortOrder? address;

  final SortOrder? status;

  final SortOrder? confirmedBalance;

  final SortOrder? unconfirmedBalance;

  final SortOrder? utxoHistory;

  final SortOrder? needsUpdating;

  @JsonKey(name: r'_count')
  final PrismaAddressCountOrderByAggregateInput? $count;

  @JsonKey(name: r'_avg')
  final PrismaAddressAvgOrderByAggregateInput? $avg;

  @JsonKey(name: r'_max')
  final PrismaAddressMaxOrderByAggregateInput? $max;

  @JsonKey(name: r'_min')
  final PrismaAddressMinOrderByAggregateInput? $min;

  @JsonKey(name: r'_sum')
  final PrismaAddressSumOrderByAggregateInput? $sum;

  @override
  Map<String, dynamic> toJson() =>
      _$PrismaAddressOrderByWithAggregationInputToJson(this);
}

@_i1.jsonSerializable
class PrismaAddressScalarWhereWithAggregatesInput
    implements _i1.JsonSerializable {
  const PrismaAddressScalarWhereWithAggregatesInput({
    this.AND,
    this.OR,
    this.NOT,
    this.address,
    this.status,
    this.confirmedBalance,
    this.unconfirmedBalance,
    this.utxoHistory,
    this.needsUpdating,
  });

  factory PrismaAddressScalarWhereWithAggregatesInput.fromJson(
          Map<String, dynamic> json) =>
      _$PrismaAddressScalarWhereWithAggregatesInputFromJson(json);

  final Iterable<PrismaAddressScalarWhereWithAggregatesInput>? AND;

  final Iterable<PrismaAddressScalarWhereWithAggregatesInput>? OR;

  final Iterable<PrismaAddressScalarWhereWithAggregatesInput>? NOT;

  final StringWithAggregatesFilter? address;

  final StringWithAggregatesFilter? status;

  final IntWithAggregatesFilter? confirmedBalance;

  final IntWithAggregatesFilter? unconfirmedBalance;

  final StringNullableListFilter? utxoHistory;

  final BoolWithAggregatesFilter? needsUpdating;

  @override
  Map<String, dynamic> toJson() =>
      _$PrismaAddressScalarWhereWithAggregatesInputToJson(this);
}

@_i1.jsonSerializable
class PrismaBlockWhereInput implements _i1.JsonSerializable {
  const PrismaBlockWhereInput({
    this.AND,
    this.OR,
    this.NOT,
    this.id,
    this.hash,
    this.blocktime,
  });

  factory PrismaBlockWhereInput.fromJson(Map<String, dynamic> json) =>
      _$PrismaBlockWhereInputFromJson(json);

  final Iterable<PrismaBlockWhereInput>? AND;

  final Iterable<PrismaBlockWhereInput>? OR;

  final Iterable<PrismaBlockWhereInput>? NOT;

  final IntFilter? id;

  final StringFilter? hash;

  final IntFilter? blocktime;

  @override
  Map<String, dynamic> toJson() => _$PrismaBlockWhereInputToJson(this);
}

@_i1.jsonSerializable
class PrismaBlockOrderByWithRelationInput implements _i1.JsonSerializable {
  const PrismaBlockOrderByWithRelationInput({
    this.id,
    this.hash,
    this.blocktime,
  });

  factory PrismaBlockOrderByWithRelationInput.fromJson(
          Map<String, dynamic> json) =>
      _$PrismaBlockOrderByWithRelationInputFromJson(json);

  final SortOrder? id;

  final SortOrder? hash;

  final SortOrder? blocktime;

  @override
  Map<String, dynamic> toJson() =>
      _$PrismaBlockOrderByWithRelationInputToJson(this);
}

@_i1.jsonSerializable
class PrismaBlockWhereUniqueInput implements _i1.JsonSerializable {
  const PrismaBlockWhereUniqueInput({this.id});

  factory PrismaBlockWhereUniqueInput.fromJson(Map<String, dynamic> json) =>
      _$PrismaBlockWhereUniqueInputFromJson(json);

  final int? id;

  @override
  Map<String, dynamic> toJson() => _$PrismaBlockWhereUniqueInputToJson(this);
}

@_i1.jsonSerializable
class PrismaBlockOrderByWithAggregationInput implements _i1.JsonSerializable {
  const PrismaBlockOrderByWithAggregationInput({
    this.id,
    this.hash,
    this.blocktime,
    this.$count,
    this.$avg,
    this.$max,
    this.$min,
    this.$sum,
  });

  factory PrismaBlockOrderByWithAggregationInput.fromJson(
          Map<String, dynamic> json) =>
      _$PrismaBlockOrderByWithAggregationInputFromJson(json);

  final SortOrder? id;

  final SortOrder? hash;

  final SortOrder? blocktime;

  @JsonKey(name: r'_count')
  final PrismaBlockCountOrderByAggregateInput? $count;

  @JsonKey(name: r'_avg')
  final PrismaBlockAvgOrderByAggregateInput? $avg;

  @JsonKey(name: r'_max')
  final PrismaBlockMaxOrderByAggregateInput? $max;

  @JsonKey(name: r'_min')
  final PrismaBlockMinOrderByAggregateInput? $min;

  @JsonKey(name: r'_sum')
  final PrismaBlockSumOrderByAggregateInput? $sum;

  @override
  Map<String, dynamic> toJson() =>
      _$PrismaBlockOrderByWithAggregationInputToJson(this);
}

@_i1.jsonSerializable
class PrismaBlockScalarWhereWithAggregatesInput
    implements _i1.JsonSerializable {
  const PrismaBlockScalarWhereWithAggregatesInput({
    this.AND,
    this.OR,
    this.NOT,
    this.id,
    this.hash,
    this.blocktime,
  });

  factory PrismaBlockScalarWhereWithAggregatesInput.fromJson(
          Map<String, dynamic> json) =>
      _$PrismaBlockScalarWhereWithAggregatesInputFromJson(json);

  final Iterable<PrismaBlockScalarWhereWithAggregatesInput>? AND;

  final Iterable<PrismaBlockScalarWhereWithAggregatesInput>? OR;

  final Iterable<PrismaBlockScalarWhereWithAggregatesInput>? NOT;

  final IntWithAggregatesFilter? id;

  final StringWithAggregatesFilter? hash;

  final IntWithAggregatesFilter? blocktime;

  @override
  Map<String, dynamic> toJson() =>
      _$PrismaBlockScalarWhereWithAggregatesInputToJson(this);
}

@_i1.jsonSerializable
class PrismaUtxoWhereInput implements _i1.JsonSerializable {
  const PrismaUtxoWhereInput({
    this.AND,
    this.OR,
    this.NOT,
    this.id,
    this.txid,
    this.txpos,
    this.block,
    this.value,
    this.addresses,
    this.flaggedForDelete,
  });

  factory PrismaUtxoWhereInput.fromJson(Map<String, dynamic> json) =>
      _$PrismaUtxoWhereInputFromJson(json);

  final Iterable<PrismaUtxoWhereInput>? AND;

  final Iterable<PrismaUtxoWhereInput>? OR;

  final Iterable<PrismaUtxoWhereInput>? NOT;

  final IntFilter? id;

  final StringFilter? txid;

  final IntFilter? txpos;

  final IntFilter? block;

  final FloatFilter? value;

  final StringNullableListFilter? addresses;

  final BoolFilter? flaggedForDelete;

  @override
  Map<String, dynamic> toJson() => _$PrismaUtxoWhereInputToJson(this);
}

@_i1.jsonSerializable
class PrismaUtxoOrderByWithRelationInput implements _i1.JsonSerializable {
  const PrismaUtxoOrderByWithRelationInput({
    this.id,
    this.txid,
    this.txpos,
    this.block,
    this.value,
    this.addresses,
    this.flaggedForDelete,
  });

  factory PrismaUtxoOrderByWithRelationInput.fromJson(
          Map<String, dynamic> json) =>
      _$PrismaUtxoOrderByWithRelationInputFromJson(json);

  final SortOrder? id;

  final SortOrder? txid;

  final SortOrder? txpos;

  final SortOrder? block;

  final SortOrder? value;

  final SortOrder? addresses;

  final SortOrder? flaggedForDelete;

  @override
  Map<String, dynamic> toJson() =>
      _$PrismaUtxoOrderByWithRelationInputToJson(this);
}

@_i1.jsonSerializable
class PrismaUtxoWhereUniqueInput implements _i1.JsonSerializable {
  const PrismaUtxoWhereUniqueInput({this.id});

  factory PrismaUtxoWhereUniqueInput.fromJson(Map<String, dynamic> json) =>
      _$PrismaUtxoWhereUniqueInputFromJson(json);

  final int? id;

  @override
  Map<String, dynamic> toJson() => _$PrismaUtxoWhereUniqueInputToJson(this);
}

@_i1.jsonSerializable
class PrismaUtxoOrderByWithAggregationInput implements _i1.JsonSerializable {
  const PrismaUtxoOrderByWithAggregationInput({
    this.id,
    this.txid,
    this.txpos,
    this.block,
    this.value,
    this.addresses,
    this.flaggedForDelete,
    this.$count,
    this.$avg,
    this.$max,
    this.$min,
    this.$sum,
  });

  factory PrismaUtxoOrderByWithAggregationInput.fromJson(
          Map<String, dynamic> json) =>
      _$PrismaUtxoOrderByWithAggregationInputFromJson(json);

  final SortOrder? id;

  final SortOrder? txid;

  final SortOrder? txpos;

  final SortOrder? block;

  final SortOrder? value;

  final SortOrder? addresses;

  final SortOrder? flaggedForDelete;

  @JsonKey(name: r'_count')
  final PrismaUtxoCountOrderByAggregateInput? $count;

  @JsonKey(name: r'_avg')
  final PrismaUtxoAvgOrderByAggregateInput? $avg;

  @JsonKey(name: r'_max')
  final PrismaUtxoMaxOrderByAggregateInput? $max;

  @JsonKey(name: r'_min')
  final PrismaUtxoMinOrderByAggregateInput? $min;

  @JsonKey(name: r'_sum')
  final PrismaUtxoSumOrderByAggregateInput? $sum;

  @override
  Map<String, dynamic> toJson() =>
      _$PrismaUtxoOrderByWithAggregationInputToJson(this);
}

@_i1.jsonSerializable
class PrismaUtxoScalarWhereWithAggregatesInput implements _i1.JsonSerializable {
  const PrismaUtxoScalarWhereWithAggregatesInput({
    this.AND,
    this.OR,
    this.NOT,
    this.id,
    this.txid,
    this.txpos,
    this.block,
    this.value,
    this.addresses,
    this.flaggedForDelete,
  });

  factory PrismaUtxoScalarWhereWithAggregatesInput.fromJson(
          Map<String, dynamic> json) =>
      _$PrismaUtxoScalarWhereWithAggregatesInputFromJson(json);

  final Iterable<PrismaUtxoScalarWhereWithAggregatesInput>? AND;

  final Iterable<PrismaUtxoScalarWhereWithAggregatesInput>? OR;

  final Iterable<PrismaUtxoScalarWhereWithAggregatesInput>? NOT;

  final IntWithAggregatesFilter? id;

  final StringWithAggregatesFilter? txid;

  final IntWithAggregatesFilter? txpos;

  final IntWithAggregatesFilter? block;

  final FloatWithAggregatesFilter? value;

  final StringNullableListFilter? addresses;

  final BoolWithAggregatesFilter? flaggedForDelete;

  @override
  Map<String, dynamic> toJson() =>
      _$PrismaUtxoScalarWhereWithAggregatesInputToJson(this);
}

@_i1.jsonSerializable
class PrismaAddressCreateInput implements _i1.JsonSerializable {
  const PrismaAddressCreateInput({
    required this.address,
    required this.status,
    required this.confirmedBalance,
    required this.unconfirmedBalance,
    this.utxoHistory,
    required this.needsUpdating,
  });

  factory PrismaAddressCreateInput.fromJson(Map<String, dynamic> json) =>
      _$PrismaAddressCreateInputFromJson(json);

  final String address;

  final String status;

  final int confirmedBalance;

  final int unconfirmedBalance;

  final Iterable<String>? utxoHistory;

  final bool needsUpdating;

  @override
  Map<String, dynamic> toJson() => _$PrismaAddressCreateInputToJson(this);
}

@_i1.jsonSerializable
class PrismaAddressUncheckedCreateInput implements _i1.JsonSerializable {
  const PrismaAddressUncheckedCreateInput({
    required this.address,
    required this.status,
    required this.confirmedBalance,
    required this.unconfirmedBalance,
    this.utxoHistory,
    required this.needsUpdating,
  });

  factory PrismaAddressUncheckedCreateInput.fromJson(
          Map<String, dynamic> json) =>
      _$PrismaAddressUncheckedCreateInputFromJson(json);

  final String address;

  final String status;

  final int confirmedBalance;

  final int unconfirmedBalance;

  final Iterable<String>? utxoHistory;

  final bool needsUpdating;

  @override
  Map<String, dynamic> toJson() =>
      _$PrismaAddressUncheckedCreateInputToJson(this);
}

@_i1.jsonSerializable
class PrismaAddressUpdateInput implements _i1.JsonSerializable {
  const PrismaAddressUpdateInput({
    this.address,
    this.status,
    this.confirmedBalance,
    this.unconfirmedBalance,
    this.utxoHistory,
    this.needsUpdating,
  });

  factory PrismaAddressUpdateInput.fromJson(Map<String, dynamic> json) =>
      _$PrismaAddressUpdateInputFromJson(json);

  final StringFieldUpdateOperationsInput? address;

  final StringFieldUpdateOperationsInput? status;

  final IntFieldUpdateOperationsInput? confirmedBalance;

  final IntFieldUpdateOperationsInput? unconfirmedBalance;

  final Iterable<String>? utxoHistory;

  final BoolFieldUpdateOperationsInput? needsUpdating;

  @override
  Map<String, dynamic> toJson() => _$PrismaAddressUpdateInputToJson(this);
}

@_i1.jsonSerializable
class PrismaAddressUncheckedUpdateInput implements _i1.JsonSerializable {
  const PrismaAddressUncheckedUpdateInput({
    this.address,
    this.status,
    this.confirmedBalance,
    this.unconfirmedBalance,
    this.utxoHistory,
    this.needsUpdating,
  });

  factory PrismaAddressUncheckedUpdateInput.fromJson(
          Map<String, dynamic> json) =>
      _$PrismaAddressUncheckedUpdateInputFromJson(json);

  final StringFieldUpdateOperationsInput? address;

  final StringFieldUpdateOperationsInput? status;

  final IntFieldUpdateOperationsInput? confirmedBalance;

  final IntFieldUpdateOperationsInput? unconfirmedBalance;

  final Iterable<String>? utxoHistory;

  final BoolFieldUpdateOperationsInput? needsUpdating;

  @override
  Map<String, dynamic> toJson() =>
      _$PrismaAddressUncheckedUpdateInputToJson(this);
}

@_i1.jsonSerializable
class PrismaAddressCreateManyInput implements _i1.JsonSerializable {
  const PrismaAddressCreateManyInput({
    required this.address,
    required this.status,
    required this.confirmedBalance,
    required this.unconfirmedBalance,
    this.utxoHistory,
    required this.needsUpdating,
  });

  factory PrismaAddressCreateManyInput.fromJson(Map<String, dynamic> json) =>
      _$PrismaAddressCreateManyInputFromJson(json);

  final String address;

  final String status;

  final int confirmedBalance;

  final int unconfirmedBalance;

  final Iterable<String>? utxoHistory;

  final bool needsUpdating;

  @override
  Map<String, dynamic> toJson() => _$PrismaAddressCreateManyInputToJson(this);
}

@_i1.jsonSerializable
class PrismaAddressUpdateManyMutationInput implements _i1.JsonSerializable {
  const PrismaAddressUpdateManyMutationInput({
    this.address,
    this.status,
    this.confirmedBalance,
    this.unconfirmedBalance,
    this.utxoHistory,
    this.needsUpdating,
  });

  factory PrismaAddressUpdateManyMutationInput.fromJson(
          Map<String, dynamic> json) =>
      _$PrismaAddressUpdateManyMutationInputFromJson(json);

  final StringFieldUpdateOperationsInput? address;

  final StringFieldUpdateOperationsInput? status;

  final IntFieldUpdateOperationsInput? confirmedBalance;

  final IntFieldUpdateOperationsInput? unconfirmedBalance;

  final Iterable<String>? utxoHistory;

  final BoolFieldUpdateOperationsInput? needsUpdating;

  @override
  Map<String, dynamic> toJson() =>
      _$PrismaAddressUpdateManyMutationInputToJson(this);
}

@_i1.jsonSerializable
class PrismaAddressUncheckedUpdateManyInput implements _i1.JsonSerializable {
  const PrismaAddressUncheckedUpdateManyInput({
    this.address,
    this.status,
    this.confirmedBalance,
    this.unconfirmedBalance,
    this.utxoHistory,
    this.needsUpdating,
  });

  factory PrismaAddressUncheckedUpdateManyInput.fromJson(
          Map<String, dynamic> json) =>
      _$PrismaAddressUncheckedUpdateManyInputFromJson(json);

  final StringFieldUpdateOperationsInput? address;

  final StringFieldUpdateOperationsInput? status;

  final IntFieldUpdateOperationsInput? confirmedBalance;

  final IntFieldUpdateOperationsInput? unconfirmedBalance;

  final Iterable<String>? utxoHistory;

  final BoolFieldUpdateOperationsInput? needsUpdating;

  @override
  Map<String, dynamic> toJson() =>
      _$PrismaAddressUncheckedUpdateManyInputToJson(this);
}

@_i1.jsonSerializable
class PrismaBlockCreateInput implements _i1.JsonSerializable {
  const PrismaBlockCreateInput({
    required this.id,
    required this.hash,
    required this.blocktime,
  });

  factory PrismaBlockCreateInput.fromJson(Map<String, dynamic> json) =>
      _$PrismaBlockCreateInputFromJson(json);

  final int id;

  final String hash;

  final int blocktime;

  @override
  Map<String, dynamic> toJson() => _$PrismaBlockCreateInputToJson(this);
}

@_i1.jsonSerializable
class PrismaBlockUncheckedCreateInput implements _i1.JsonSerializable {
  const PrismaBlockUncheckedCreateInput({
    required this.id,
    required this.hash,
    required this.blocktime,
  });

  factory PrismaBlockUncheckedCreateInput.fromJson(Map<String, dynamic> json) =>
      _$PrismaBlockUncheckedCreateInputFromJson(json);

  final int id;

  final String hash;

  final int blocktime;

  @override
  Map<String, dynamic> toJson() =>
      _$PrismaBlockUncheckedCreateInputToJson(this);
}

@_i1.jsonSerializable
class PrismaBlockUpdateInput implements _i1.JsonSerializable {
  const PrismaBlockUpdateInput({
    this.id,
    this.hash,
    this.blocktime,
  });

  factory PrismaBlockUpdateInput.fromJson(Map<String, dynamic> json) =>
      _$PrismaBlockUpdateInputFromJson(json);

  final IntFieldUpdateOperationsInput? id;

  final StringFieldUpdateOperationsInput? hash;

  final IntFieldUpdateOperationsInput? blocktime;

  @override
  Map<String, dynamic> toJson() => _$PrismaBlockUpdateInputToJson(this);
}

@_i1.jsonSerializable
class PrismaBlockUncheckedUpdateInput implements _i1.JsonSerializable {
  const PrismaBlockUncheckedUpdateInput({
    this.id,
    this.hash,
    this.blocktime,
  });

  factory PrismaBlockUncheckedUpdateInput.fromJson(Map<String, dynamic> json) =>
      _$PrismaBlockUncheckedUpdateInputFromJson(json);

  final IntFieldUpdateOperationsInput? id;

  final StringFieldUpdateOperationsInput? hash;

  final IntFieldUpdateOperationsInput? blocktime;

  @override
  Map<String, dynamic> toJson() =>
      _$PrismaBlockUncheckedUpdateInputToJson(this);
}

@_i1.jsonSerializable
class PrismaBlockCreateManyInput implements _i1.JsonSerializable {
  const PrismaBlockCreateManyInput({
    required this.id,
    required this.hash,
    required this.blocktime,
  });

  factory PrismaBlockCreateManyInput.fromJson(Map<String, dynamic> json) =>
      _$PrismaBlockCreateManyInputFromJson(json);

  final int id;

  final String hash;

  final int blocktime;

  @override
  Map<String, dynamic> toJson() => _$PrismaBlockCreateManyInputToJson(this);
}

@_i1.jsonSerializable
class PrismaBlockUpdateManyMutationInput implements _i1.JsonSerializable {
  const PrismaBlockUpdateManyMutationInput({
    this.id,
    this.hash,
    this.blocktime,
  });

  factory PrismaBlockUpdateManyMutationInput.fromJson(
          Map<String, dynamic> json) =>
      _$PrismaBlockUpdateManyMutationInputFromJson(json);

  final IntFieldUpdateOperationsInput? id;

  final StringFieldUpdateOperationsInput? hash;

  final IntFieldUpdateOperationsInput? blocktime;

  @override
  Map<String, dynamic> toJson() =>
      _$PrismaBlockUpdateManyMutationInputToJson(this);
}

@_i1.jsonSerializable
class PrismaBlockUncheckedUpdateManyInput implements _i1.JsonSerializable {
  const PrismaBlockUncheckedUpdateManyInput({
    this.id,
    this.hash,
    this.blocktime,
  });

  factory PrismaBlockUncheckedUpdateManyInput.fromJson(
          Map<String, dynamic> json) =>
      _$PrismaBlockUncheckedUpdateManyInputFromJson(json);

  final IntFieldUpdateOperationsInput? id;

  final StringFieldUpdateOperationsInput? hash;

  final IntFieldUpdateOperationsInput? blocktime;

  @override
  Map<String, dynamic> toJson() =>
      _$PrismaBlockUncheckedUpdateManyInputToJson(this);
}

@_i1.jsonSerializable
class PrismaUtxoCreateInput implements _i1.JsonSerializable {
  const PrismaUtxoCreateInput({
    required this.txid,
    required this.txpos,
    required this.block,
    required this.value,
    this.addresses,
    required this.flaggedForDelete,
  });

  factory PrismaUtxoCreateInput.fromJson(Map<String, dynamic> json) =>
      _$PrismaUtxoCreateInputFromJson(json);

  final String txid;

  final int txpos;

  final int block;

  final double value;

  final Iterable<String>? addresses;

  final bool flaggedForDelete;

  @override
  Map<String, dynamic> toJson() => _$PrismaUtxoCreateInputToJson(this);
}

@_i1.jsonSerializable
class PrismaUtxoUncheckedCreateInput implements _i1.JsonSerializable {
  const PrismaUtxoUncheckedCreateInput({
    this.id,
    required this.txid,
    required this.txpos,
    required this.block,
    required this.value,
    this.addresses,
    required this.flaggedForDelete,
  });

  factory PrismaUtxoUncheckedCreateInput.fromJson(Map<String, dynamic> json) =>
      _$PrismaUtxoUncheckedCreateInputFromJson(json);

  final int? id;

  final String txid;

  final int txpos;

  final int block;

  final double value;

  final Iterable<String>? addresses;

  final bool flaggedForDelete;

  @override
  Map<String, dynamic> toJson() => _$PrismaUtxoUncheckedCreateInputToJson(this);
}

@_i1.jsonSerializable
class PrismaUtxoUpdateInput implements _i1.JsonSerializable {
  const PrismaUtxoUpdateInput({
    this.txid,
    this.txpos,
    this.block,
    this.value,
    this.addresses,
    this.flaggedForDelete,
  });

  factory PrismaUtxoUpdateInput.fromJson(Map<String, dynamic> json) =>
      _$PrismaUtxoUpdateInputFromJson(json);

  final StringFieldUpdateOperationsInput? txid;

  final IntFieldUpdateOperationsInput? txpos;

  final IntFieldUpdateOperationsInput? block;

  final FloatFieldUpdateOperationsInput? value;

  final Iterable<String>? addresses;

  final BoolFieldUpdateOperationsInput? flaggedForDelete;

  @override
  Map<String, dynamic> toJson() => _$PrismaUtxoUpdateInputToJson(this);
}

@_i1.jsonSerializable
class PrismaUtxoUncheckedUpdateInput implements _i1.JsonSerializable {
  const PrismaUtxoUncheckedUpdateInput({
    this.id,
    this.txid,
    this.txpos,
    this.block,
    this.value,
    this.addresses,
    this.flaggedForDelete,
  });

  factory PrismaUtxoUncheckedUpdateInput.fromJson(Map<String, dynamic> json) =>
      _$PrismaUtxoUncheckedUpdateInputFromJson(json);

  final IntFieldUpdateOperationsInput? id;

  final StringFieldUpdateOperationsInput? txid;

  final IntFieldUpdateOperationsInput? txpos;

  final IntFieldUpdateOperationsInput? block;

  final FloatFieldUpdateOperationsInput? value;

  final Iterable<String>? addresses;

  final BoolFieldUpdateOperationsInput? flaggedForDelete;

  @override
  Map<String, dynamic> toJson() => _$PrismaUtxoUncheckedUpdateInputToJson(this);
}

@_i1.jsonSerializable
class PrismaUtxoCreateManyInput implements _i1.JsonSerializable {
  const PrismaUtxoCreateManyInput({
    this.id,
    required this.txid,
    required this.txpos,
    required this.block,
    required this.value,
    this.addresses,
    required this.flaggedForDelete,
  });

  factory PrismaUtxoCreateManyInput.fromJson(Map<String, dynamic> json) =>
      _$PrismaUtxoCreateManyInputFromJson(json);

  final int? id;

  final String txid;

  final int txpos;

  final int block;

  final double value;

  final Iterable<String>? addresses;

  final bool flaggedForDelete;

  @override
  Map<String, dynamic> toJson() => _$PrismaUtxoCreateManyInputToJson(this);
}

@_i1.jsonSerializable
class PrismaUtxoUpdateManyMutationInput implements _i1.JsonSerializable {
  const PrismaUtxoUpdateManyMutationInput({
    this.txid,
    this.txpos,
    this.block,
    this.value,
    this.addresses,
    this.flaggedForDelete,
  });

  factory PrismaUtxoUpdateManyMutationInput.fromJson(
          Map<String, dynamic> json) =>
      _$PrismaUtxoUpdateManyMutationInputFromJson(json);

  final StringFieldUpdateOperationsInput? txid;

  final IntFieldUpdateOperationsInput? txpos;

  final IntFieldUpdateOperationsInput? block;

  final FloatFieldUpdateOperationsInput? value;

  final Iterable<String>? addresses;

  final BoolFieldUpdateOperationsInput? flaggedForDelete;

  @override
  Map<String, dynamic> toJson() =>
      _$PrismaUtxoUpdateManyMutationInputToJson(this);
}

@_i1.jsonSerializable
class PrismaUtxoUncheckedUpdateManyInput implements _i1.JsonSerializable {
  const PrismaUtxoUncheckedUpdateManyInput({
    this.id,
    this.txid,
    this.txpos,
    this.block,
    this.value,
    this.addresses,
    this.flaggedForDelete,
  });

  factory PrismaUtxoUncheckedUpdateManyInput.fromJson(
          Map<String, dynamic> json) =>
      _$PrismaUtxoUncheckedUpdateManyInputFromJson(json);

  final IntFieldUpdateOperationsInput? id;

  final StringFieldUpdateOperationsInput? txid;

  final IntFieldUpdateOperationsInput? txpos;

  final IntFieldUpdateOperationsInput? block;

  final FloatFieldUpdateOperationsInput? value;

  final Iterable<String>? addresses;

  final BoolFieldUpdateOperationsInput? flaggedForDelete;

  @override
  Map<String, dynamic> toJson() =>
      _$PrismaUtxoUncheckedUpdateManyInputToJson(this);
}

@_i1.jsonSerializable
class StringFilter implements _i1.JsonSerializable {
  const StringFilter({
    this.equals,
    this.$in,
    this.notIn,
    this.lt,
    this.lte,
    this.gt,
    this.gte,
    this.contains,
    this.startsWith,
    this.endsWith,
    this.mode,
    this.not,
  });

  factory StringFilter.fromJson(Map<String, dynamic> json) =>
      _$StringFilterFromJson(json);

  final String? equals;

  @JsonKey(name: r'in')
  final Iterable<String>? $in;

  final Iterable<String>? notIn;

  final String? lt;

  final String? lte;

  final String? gt;

  final String? gte;

  final String? contains;

  final String? startsWith;

  final String? endsWith;

  final QueryMode? mode;

  final NestedStringFilter? not;

  @override
  Map<String, dynamic> toJson() => _$StringFilterToJson(this);
}

@_i1.jsonSerializable
class IntFilter implements _i1.JsonSerializable {
  const IntFilter({
    this.equals,
    this.$in,
    this.notIn,
    this.lt,
    this.lte,
    this.gt,
    this.gte,
    this.not,
  });

  factory IntFilter.fromJson(Map<String, dynamic> json) =>
      _$IntFilterFromJson(json);

  final int? equals;

  @JsonKey(name: r'in')
  final Iterable<int>? $in;

  final Iterable<int>? notIn;

  final int? lt;

  final int? lte;

  final int? gt;

  final int? gte;

  final NestedIntFilter? not;

  @override
  Map<String, dynamic> toJson() => _$IntFilterToJson(this);
}

@_i1.jsonSerializable
class StringNullableListFilter implements _i1.JsonSerializable {
  const StringNullableListFilter({
    this.equals,
    this.has,
    this.hasEvery,
    this.hasSome,
    this.isEmpty,
  });

  factory StringNullableListFilter.fromJson(Map<String, dynamic> json) =>
      _$StringNullableListFilterFromJson(json);

  final Iterable<String>? equals;

  final String? has;

  final Iterable<String>? hasEvery;

  final Iterable<String>? hasSome;

  final bool? isEmpty;

  @override
  Map<String, dynamic> toJson() => _$StringNullableListFilterToJson(this);
}

@_i1.jsonSerializable
class BoolFilter implements _i1.JsonSerializable {
  const BoolFilter({
    this.equals,
    this.not,
  });

  factory BoolFilter.fromJson(Map<String, dynamic> json) =>
      _$BoolFilterFromJson(json);

  final bool? equals;

  final NestedBoolFilter? not;

  @override
  Map<String, dynamic> toJson() => _$BoolFilterToJson(this);
}

@_i1.jsonSerializable
class PrismaAddressCountOrderByAggregateInput implements _i1.JsonSerializable {
  const PrismaAddressCountOrderByAggregateInput({
    this.address,
    this.status,
    this.confirmedBalance,
    this.unconfirmedBalance,
    this.utxoHistory,
    this.needsUpdating,
  });

  factory PrismaAddressCountOrderByAggregateInput.fromJson(
          Map<String, dynamic> json) =>
      _$PrismaAddressCountOrderByAggregateInputFromJson(json);

  final SortOrder? address;

  final SortOrder? status;

  final SortOrder? confirmedBalance;

  final SortOrder? unconfirmedBalance;

  final SortOrder? utxoHistory;

  final SortOrder? needsUpdating;

  @override
  Map<String, dynamic> toJson() =>
      _$PrismaAddressCountOrderByAggregateInputToJson(this);
}

@_i1.jsonSerializable
class PrismaAddressAvgOrderByAggregateInput implements _i1.JsonSerializable {
  const PrismaAddressAvgOrderByAggregateInput({
    this.confirmedBalance,
    this.unconfirmedBalance,
  });

  factory PrismaAddressAvgOrderByAggregateInput.fromJson(
          Map<String, dynamic> json) =>
      _$PrismaAddressAvgOrderByAggregateInputFromJson(json);

  final SortOrder? confirmedBalance;

  final SortOrder? unconfirmedBalance;

  @override
  Map<String, dynamic> toJson() =>
      _$PrismaAddressAvgOrderByAggregateInputToJson(this);
}

@_i1.jsonSerializable
class PrismaAddressMaxOrderByAggregateInput implements _i1.JsonSerializable {
  const PrismaAddressMaxOrderByAggregateInput({
    this.address,
    this.status,
    this.confirmedBalance,
    this.unconfirmedBalance,
    this.needsUpdating,
  });

  factory PrismaAddressMaxOrderByAggregateInput.fromJson(
          Map<String, dynamic> json) =>
      _$PrismaAddressMaxOrderByAggregateInputFromJson(json);

  final SortOrder? address;

  final SortOrder? status;

  final SortOrder? confirmedBalance;

  final SortOrder? unconfirmedBalance;

  final SortOrder? needsUpdating;

  @override
  Map<String, dynamic> toJson() =>
      _$PrismaAddressMaxOrderByAggregateInputToJson(this);
}

@_i1.jsonSerializable
class PrismaAddressMinOrderByAggregateInput implements _i1.JsonSerializable {
  const PrismaAddressMinOrderByAggregateInput({
    this.address,
    this.status,
    this.confirmedBalance,
    this.unconfirmedBalance,
    this.needsUpdating,
  });

  factory PrismaAddressMinOrderByAggregateInput.fromJson(
          Map<String, dynamic> json) =>
      _$PrismaAddressMinOrderByAggregateInputFromJson(json);

  final SortOrder? address;

  final SortOrder? status;

  final SortOrder? confirmedBalance;

  final SortOrder? unconfirmedBalance;

  final SortOrder? needsUpdating;

  @override
  Map<String, dynamic> toJson() =>
      _$PrismaAddressMinOrderByAggregateInputToJson(this);
}

@_i1.jsonSerializable
class PrismaAddressSumOrderByAggregateInput implements _i1.JsonSerializable {
  const PrismaAddressSumOrderByAggregateInput({
    this.confirmedBalance,
    this.unconfirmedBalance,
  });

  factory PrismaAddressSumOrderByAggregateInput.fromJson(
          Map<String, dynamic> json) =>
      _$PrismaAddressSumOrderByAggregateInputFromJson(json);

  final SortOrder? confirmedBalance;

  final SortOrder? unconfirmedBalance;

  @override
  Map<String, dynamic> toJson() =>
      _$PrismaAddressSumOrderByAggregateInputToJson(this);
}

@_i1.jsonSerializable
class StringWithAggregatesFilter implements _i1.JsonSerializable {
  const StringWithAggregatesFilter({
    this.equals,
    this.$in,
    this.notIn,
    this.lt,
    this.lte,
    this.gt,
    this.gte,
    this.contains,
    this.startsWith,
    this.endsWith,
    this.mode,
    this.not,
    this.$count,
    this.$min,
    this.$max,
  });

  factory StringWithAggregatesFilter.fromJson(Map<String, dynamic> json) =>
      _$StringWithAggregatesFilterFromJson(json);

  final String? equals;

  @JsonKey(name: r'in')
  final Iterable<String>? $in;

  final Iterable<String>? notIn;

  final String? lt;

  final String? lte;

  final String? gt;

  final String? gte;

  final String? contains;

  final String? startsWith;

  final String? endsWith;

  final QueryMode? mode;

  final NestedStringWithAggregatesFilter? not;

  @JsonKey(name: r'_count')
  final NestedIntFilter? $count;

  @JsonKey(name: r'_min')
  final NestedStringFilter? $min;

  @JsonKey(name: r'_max')
  final NestedStringFilter? $max;

  @override
  Map<String, dynamic> toJson() => _$StringWithAggregatesFilterToJson(this);
}

@_i1.jsonSerializable
class IntWithAggregatesFilter implements _i1.JsonSerializable {
  const IntWithAggregatesFilter({
    this.equals,
    this.$in,
    this.notIn,
    this.lt,
    this.lte,
    this.gt,
    this.gte,
    this.not,
    this.$count,
    this.$avg,
    this.$sum,
    this.$min,
    this.$max,
  });

  factory IntWithAggregatesFilter.fromJson(Map<String, dynamic> json) =>
      _$IntWithAggregatesFilterFromJson(json);

  final int? equals;

  @JsonKey(name: r'in')
  final Iterable<int>? $in;

  final Iterable<int>? notIn;

  final int? lt;

  final int? lte;

  final int? gt;

  final int? gte;

  final NestedIntWithAggregatesFilter? not;

  @JsonKey(name: r'_count')
  final NestedIntFilter? $count;

  @JsonKey(name: r'_avg')
  final NestedFloatFilter? $avg;

  @JsonKey(name: r'_sum')
  final NestedIntFilter? $sum;

  @JsonKey(name: r'_min')
  final NestedIntFilter? $min;

  @JsonKey(name: r'_max')
  final NestedIntFilter? $max;

  @override
  Map<String, dynamic> toJson() => _$IntWithAggregatesFilterToJson(this);
}

@_i1.jsonSerializable
class BoolWithAggregatesFilter implements _i1.JsonSerializable {
  const BoolWithAggregatesFilter({
    this.equals,
    this.not,
    this.$count,
    this.$min,
    this.$max,
  });

  factory BoolWithAggregatesFilter.fromJson(Map<String, dynamic> json) =>
      _$BoolWithAggregatesFilterFromJson(json);

  final bool? equals;

  final NestedBoolWithAggregatesFilter? not;

  @JsonKey(name: r'_count')
  final NestedIntFilter? $count;

  @JsonKey(name: r'_min')
  final NestedBoolFilter? $min;

  @JsonKey(name: r'_max')
  final NestedBoolFilter? $max;

  @override
  Map<String, dynamic> toJson() => _$BoolWithAggregatesFilterToJson(this);
}

@_i1.jsonSerializable
class PrismaBlockCountOrderByAggregateInput implements _i1.JsonSerializable {
  const PrismaBlockCountOrderByAggregateInput({
    this.id,
    this.hash,
    this.blocktime,
  });

  factory PrismaBlockCountOrderByAggregateInput.fromJson(
          Map<String, dynamic> json) =>
      _$PrismaBlockCountOrderByAggregateInputFromJson(json);

  final SortOrder? id;

  final SortOrder? hash;

  final SortOrder? blocktime;

  @override
  Map<String, dynamic> toJson() =>
      _$PrismaBlockCountOrderByAggregateInputToJson(this);
}

@_i1.jsonSerializable
class PrismaBlockAvgOrderByAggregateInput implements _i1.JsonSerializable {
  const PrismaBlockAvgOrderByAggregateInput({
    this.id,
    this.blocktime,
  });

  factory PrismaBlockAvgOrderByAggregateInput.fromJson(
          Map<String, dynamic> json) =>
      _$PrismaBlockAvgOrderByAggregateInputFromJson(json);

  final SortOrder? id;

  final SortOrder? blocktime;

  @override
  Map<String, dynamic> toJson() =>
      _$PrismaBlockAvgOrderByAggregateInputToJson(this);
}

@_i1.jsonSerializable
class PrismaBlockMaxOrderByAggregateInput implements _i1.JsonSerializable {
  const PrismaBlockMaxOrderByAggregateInput({
    this.id,
    this.hash,
    this.blocktime,
  });

  factory PrismaBlockMaxOrderByAggregateInput.fromJson(
          Map<String, dynamic> json) =>
      _$PrismaBlockMaxOrderByAggregateInputFromJson(json);

  final SortOrder? id;

  final SortOrder? hash;

  final SortOrder? blocktime;

  @override
  Map<String, dynamic> toJson() =>
      _$PrismaBlockMaxOrderByAggregateInputToJson(this);
}

@_i1.jsonSerializable
class PrismaBlockMinOrderByAggregateInput implements _i1.JsonSerializable {
  const PrismaBlockMinOrderByAggregateInput({
    this.id,
    this.hash,
    this.blocktime,
  });

  factory PrismaBlockMinOrderByAggregateInput.fromJson(
          Map<String, dynamic> json) =>
      _$PrismaBlockMinOrderByAggregateInputFromJson(json);

  final SortOrder? id;

  final SortOrder? hash;

  final SortOrder? blocktime;

  @override
  Map<String, dynamic> toJson() =>
      _$PrismaBlockMinOrderByAggregateInputToJson(this);
}

@_i1.jsonSerializable
class PrismaBlockSumOrderByAggregateInput implements _i1.JsonSerializable {
  const PrismaBlockSumOrderByAggregateInput({
    this.id,
    this.blocktime,
  });

  factory PrismaBlockSumOrderByAggregateInput.fromJson(
          Map<String, dynamic> json) =>
      _$PrismaBlockSumOrderByAggregateInputFromJson(json);

  final SortOrder? id;

  final SortOrder? blocktime;

  @override
  Map<String, dynamic> toJson() =>
      _$PrismaBlockSumOrderByAggregateInputToJson(this);
}

@_i1.jsonSerializable
class FloatFilter implements _i1.JsonSerializable {
  const FloatFilter({
    this.equals,
    this.$in,
    this.notIn,
    this.lt,
    this.lte,
    this.gt,
    this.gte,
    this.not,
  });

  factory FloatFilter.fromJson(Map<String, dynamic> json) =>
      _$FloatFilterFromJson(json);

  final double? equals;

  @JsonKey(name: r'in')
  final Iterable<double>? $in;

  final Iterable<double>? notIn;

  final double? lt;

  final double? lte;

  final double? gt;

  final double? gte;

  final NestedFloatFilter? not;

  @override
  Map<String, dynamic> toJson() => _$FloatFilterToJson(this);
}

@_i1.jsonSerializable
class PrismaUtxoCountOrderByAggregateInput implements _i1.JsonSerializable {
  const PrismaUtxoCountOrderByAggregateInput({
    this.id,
    this.txid,
    this.txpos,
    this.block,
    this.value,
    this.addresses,
    this.flaggedForDelete,
  });

  factory PrismaUtxoCountOrderByAggregateInput.fromJson(
          Map<String, dynamic> json) =>
      _$PrismaUtxoCountOrderByAggregateInputFromJson(json);

  final SortOrder? id;

  final SortOrder? txid;

  final SortOrder? txpos;

  final SortOrder? block;

  final SortOrder? value;

  final SortOrder? addresses;

  final SortOrder? flaggedForDelete;

  @override
  Map<String, dynamic> toJson() =>
      _$PrismaUtxoCountOrderByAggregateInputToJson(this);
}

@_i1.jsonSerializable
class PrismaUtxoAvgOrderByAggregateInput implements _i1.JsonSerializable {
  const PrismaUtxoAvgOrderByAggregateInput({
    this.id,
    this.txpos,
    this.block,
    this.value,
  });

  factory PrismaUtxoAvgOrderByAggregateInput.fromJson(
          Map<String, dynamic> json) =>
      _$PrismaUtxoAvgOrderByAggregateInputFromJson(json);

  final SortOrder? id;

  final SortOrder? txpos;

  final SortOrder? block;

  final SortOrder? value;

  @override
  Map<String, dynamic> toJson() =>
      _$PrismaUtxoAvgOrderByAggregateInputToJson(this);
}

@_i1.jsonSerializable
class PrismaUtxoMaxOrderByAggregateInput implements _i1.JsonSerializable {
  const PrismaUtxoMaxOrderByAggregateInput({
    this.id,
    this.txid,
    this.txpos,
    this.block,
    this.value,
    this.flaggedForDelete,
  });

  factory PrismaUtxoMaxOrderByAggregateInput.fromJson(
          Map<String, dynamic> json) =>
      _$PrismaUtxoMaxOrderByAggregateInputFromJson(json);

  final SortOrder? id;

  final SortOrder? txid;

  final SortOrder? txpos;

  final SortOrder? block;

  final SortOrder? value;

  final SortOrder? flaggedForDelete;

  @override
  Map<String, dynamic> toJson() =>
      _$PrismaUtxoMaxOrderByAggregateInputToJson(this);
}

@_i1.jsonSerializable
class PrismaUtxoMinOrderByAggregateInput implements _i1.JsonSerializable {
  const PrismaUtxoMinOrderByAggregateInput({
    this.id,
    this.txid,
    this.txpos,
    this.block,
    this.value,
    this.flaggedForDelete,
  });

  factory PrismaUtxoMinOrderByAggregateInput.fromJson(
          Map<String, dynamic> json) =>
      _$PrismaUtxoMinOrderByAggregateInputFromJson(json);

  final SortOrder? id;

  final SortOrder? txid;

  final SortOrder? txpos;

  final SortOrder? block;

  final SortOrder? value;

  final SortOrder? flaggedForDelete;

  @override
  Map<String, dynamic> toJson() =>
      _$PrismaUtxoMinOrderByAggregateInputToJson(this);
}

@_i1.jsonSerializable
class PrismaUtxoSumOrderByAggregateInput implements _i1.JsonSerializable {
  const PrismaUtxoSumOrderByAggregateInput({
    this.id,
    this.txpos,
    this.block,
    this.value,
  });

  factory PrismaUtxoSumOrderByAggregateInput.fromJson(
          Map<String, dynamic> json) =>
      _$PrismaUtxoSumOrderByAggregateInputFromJson(json);

  final SortOrder? id;

  final SortOrder? txpos;

  final SortOrder? block;

  final SortOrder? value;

  @override
  Map<String, dynamic> toJson() =>
      _$PrismaUtxoSumOrderByAggregateInputToJson(this);
}

@_i1.jsonSerializable
class FloatWithAggregatesFilter implements _i1.JsonSerializable {
  const FloatWithAggregatesFilter({
    this.equals,
    this.$in,
    this.notIn,
    this.lt,
    this.lte,
    this.gt,
    this.gte,
    this.not,
    this.$count,
    this.$avg,
    this.$sum,
    this.$min,
    this.$max,
  });

  factory FloatWithAggregatesFilter.fromJson(Map<String, dynamic> json) =>
      _$FloatWithAggregatesFilterFromJson(json);

  final double? equals;

  @JsonKey(name: r'in')
  final Iterable<double>? $in;

  final Iterable<double>? notIn;

  final double? lt;

  final double? lte;

  final double? gt;

  final double? gte;

  final NestedFloatWithAggregatesFilter? not;

  @JsonKey(name: r'_count')
  final NestedIntFilter? $count;

  @JsonKey(name: r'_avg')
  final NestedFloatFilter? $avg;

  @JsonKey(name: r'_sum')
  final NestedFloatFilter? $sum;

  @JsonKey(name: r'_min')
  final NestedFloatFilter? $min;

  @JsonKey(name: r'_max')
  final NestedFloatFilter? $max;

  @override
  Map<String, dynamic> toJson() => _$FloatWithAggregatesFilterToJson(this);
}

@_i1.jsonSerializable
class PrismaAddressCreateutxoHistoryInput implements _i1.JsonSerializable {
  const PrismaAddressCreateutxoHistoryInput({required this.set});

  factory PrismaAddressCreateutxoHistoryInput.fromJson(
          Map<String, dynamic> json) =>
      _$PrismaAddressCreateutxoHistoryInputFromJson(json);

  final Iterable<String> set;

  @override
  Map<String, dynamic> toJson() =>
      _$PrismaAddressCreateutxoHistoryInputToJson(this);
}

@_i1.jsonSerializable
class StringFieldUpdateOperationsInput implements _i1.JsonSerializable {
  const StringFieldUpdateOperationsInput({this.set});

  factory StringFieldUpdateOperationsInput.fromJson(
          Map<String, dynamic> json) =>
      _$StringFieldUpdateOperationsInputFromJson(json);

  final String? set;

  @override
  Map<String, dynamic> toJson() =>
      _$StringFieldUpdateOperationsInputToJson(this);
}

@_i1.jsonSerializable
class IntFieldUpdateOperationsInput implements _i1.JsonSerializable {
  const IntFieldUpdateOperationsInput({
    this.set,
    this.increment,
    this.decrement,
    this.multiply,
    this.divide,
  });

  factory IntFieldUpdateOperationsInput.fromJson(Map<String, dynamic> json) =>
      _$IntFieldUpdateOperationsInputFromJson(json);

  final int? set;

  final int? increment;

  final int? decrement;

  final int? multiply;

  final int? divide;

  @override
  Map<String, dynamic> toJson() => _$IntFieldUpdateOperationsInputToJson(this);
}

@_i1.jsonSerializable
class PrismaAddressUpdateutxoHistoryInput implements _i1.JsonSerializable {
  const PrismaAddressUpdateutxoHistoryInput({
    this.set,
    this.push,
  });

  factory PrismaAddressUpdateutxoHistoryInput.fromJson(
          Map<String, dynamic> json) =>
      _$PrismaAddressUpdateutxoHistoryInputFromJson(json);

  final Iterable<String>? set;

  final Iterable<String>? push;

  @override
  Map<String, dynamic> toJson() =>
      _$PrismaAddressUpdateutxoHistoryInputToJson(this);
}

@_i1.jsonSerializable
class BoolFieldUpdateOperationsInput implements _i1.JsonSerializable {
  const BoolFieldUpdateOperationsInput({this.set});

  factory BoolFieldUpdateOperationsInput.fromJson(Map<String, dynamic> json) =>
      _$BoolFieldUpdateOperationsInputFromJson(json);

  final bool? set;

  @override
  Map<String, dynamic> toJson() => _$BoolFieldUpdateOperationsInputToJson(this);
}

@_i1.jsonSerializable
class PrismaUtxoCreateaddressesInput implements _i1.JsonSerializable {
  const PrismaUtxoCreateaddressesInput({required this.set});

  factory PrismaUtxoCreateaddressesInput.fromJson(Map<String, dynamic> json) =>
      _$PrismaUtxoCreateaddressesInputFromJson(json);

  final Iterable<String> set;

  @override
  Map<String, dynamic> toJson() => _$PrismaUtxoCreateaddressesInputToJson(this);
}

@_i1.jsonSerializable
class FloatFieldUpdateOperationsInput implements _i1.JsonSerializable {
  const FloatFieldUpdateOperationsInput({
    this.set,
    this.increment,
    this.decrement,
    this.multiply,
    this.divide,
  });

  factory FloatFieldUpdateOperationsInput.fromJson(Map<String, dynamic> json) =>
      _$FloatFieldUpdateOperationsInputFromJson(json);

  final double? set;

  final double? increment;

  final double? decrement;

  final double? multiply;

  final double? divide;

  @override
  Map<String, dynamic> toJson() =>
      _$FloatFieldUpdateOperationsInputToJson(this);
}

@_i1.jsonSerializable
class PrismaUtxoUpdateaddressesInput implements _i1.JsonSerializable {
  const PrismaUtxoUpdateaddressesInput({
    this.set,
    this.push,
  });

  factory PrismaUtxoUpdateaddressesInput.fromJson(Map<String, dynamic> json) =>
      _$PrismaUtxoUpdateaddressesInputFromJson(json);

  final Iterable<String>? set;

  final Iterable<String>? push;

  @override
  Map<String, dynamic> toJson() => _$PrismaUtxoUpdateaddressesInputToJson(this);
}

@_i1.jsonSerializable
class NestedStringFilter implements _i1.JsonSerializable {
  const NestedStringFilter({
    this.equals,
    this.$in,
    this.notIn,
    this.lt,
    this.lte,
    this.gt,
    this.gte,
    this.contains,
    this.startsWith,
    this.endsWith,
    this.not,
  });

  factory NestedStringFilter.fromJson(Map<String, dynamic> json) =>
      _$NestedStringFilterFromJson(json);

  final String? equals;

  @JsonKey(name: r'in')
  final Iterable<String>? $in;

  final Iterable<String>? notIn;

  final String? lt;

  final String? lte;

  final String? gt;

  final String? gte;

  final String? contains;

  final String? startsWith;

  final String? endsWith;

  final NestedStringFilter? not;

  @override
  Map<String, dynamic> toJson() => _$NestedStringFilterToJson(this);
}

@_i1.jsonSerializable
class NestedIntFilter implements _i1.JsonSerializable {
  const NestedIntFilter({
    this.equals,
    this.$in,
    this.notIn,
    this.lt,
    this.lte,
    this.gt,
    this.gte,
    this.not,
  });

  factory NestedIntFilter.fromJson(Map<String, dynamic> json) =>
      _$NestedIntFilterFromJson(json);

  final int? equals;

  @JsonKey(name: r'in')
  final Iterable<int>? $in;

  final Iterable<int>? notIn;

  final int? lt;

  final int? lte;

  final int? gt;

  final int? gte;

  final NestedIntFilter? not;

  @override
  Map<String, dynamic> toJson() => _$NestedIntFilterToJson(this);
}

@_i1.jsonSerializable
class NestedBoolFilter implements _i1.JsonSerializable {
  const NestedBoolFilter({
    this.equals,
    this.not,
  });

  factory NestedBoolFilter.fromJson(Map<String, dynamic> json) =>
      _$NestedBoolFilterFromJson(json);

  final bool? equals;

  final NestedBoolFilter? not;

  @override
  Map<String, dynamic> toJson() => _$NestedBoolFilterToJson(this);
}

@_i1.jsonSerializable
class NestedStringWithAggregatesFilter implements _i1.JsonSerializable {
  const NestedStringWithAggregatesFilter({
    this.equals,
    this.$in,
    this.notIn,
    this.lt,
    this.lte,
    this.gt,
    this.gte,
    this.contains,
    this.startsWith,
    this.endsWith,
    this.not,
    this.$count,
    this.$min,
    this.$max,
  });

  factory NestedStringWithAggregatesFilter.fromJson(
          Map<String, dynamic> json) =>
      _$NestedStringWithAggregatesFilterFromJson(json);

  final String? equals;

  @JsonKey(name: r'in')
  final Iterable<String>? $in;

  final Iterable<String>? notIn;

  final String? lt;

  final String? lte;

  final String? gt;

  final String? gte;

  final String? contains;

  final String? startsWith;

  final String? endsWith;

  final NestedStringWithAggregatesFilter? not;

  @JsonKey(name: r'_count')
  final NestedIntFilter? $count;

  @JsonKey(name: r'_min')
  final NestedStringFilter? $min;

  @JsonKey(name: r'_max')
  final NestedStringFilter? $max;

  @override
  Map<String, dynamic> toJson() =>
      _$NestedStringWithAggregatesFilterToJson(this);
}

@_i1.jsonSerializable
class NestedIntWithAggregatesFilter implements _i1.JsonSerializable {
  const NestedIntWithAggregatesFilter({
    this.equals,
    this.$in,
    this.notIn,
    this.lt,
    this.lte,
    this.gt,
    this.gte,
    this.not,
    this.$count,
    this.$avg,
    this.$sum,
    this.$min,
    this.$max,
  });

  factory NestedIntWithAggregatesFilter.fromJson(Map<String, dynamic> json) =>
      _$NestedIntWithAggregatesFilterFromJson(json);

  final int? equals;

  @JsonKey(name: r'in')
  final Iterable<int>? $in;

  final Iterable<int>? notIn;

  final int? lt;

  final int? lte;

  final int? gt;

  final int? gte;

  final NestedIntWithAggregatesFilter? not;

  @JsonKey(name: r'_count')
  final NestedIntFilter? $count;

  @JsonKey(name: r'_avg')
  final NestedFloatFilter? $avg;

  @JsonKey(name: r'_sum')
  final NestedIntFilter? $sum;

  @JsonKey(name: r'_min')
  final NestedIntFilter? $min;

  @JsonKey(name: r'_max')
  final NestedIntFilter? $max;

  @override
  Map<String, dynamic> toJson() => _$NestedIntWithAggregatesFilterToJson(this);
}

@_i1.jsonSerializable
class NestedFloatFilter implements _i1.JsonSerializable {
  const NestedFloatFilter({
    this.equals,
    this.$in,
    this.notIn,
    this.lt,
    this.lte,
    this.gt,
    this.gte,
    this.not,
  });

  factory NestedFloatFilter.fromJson(Map<String, dynamic> json) =>
      _$NestedFloatFilterFromJson(json);

  final double? equals;

  @JsonKey(name: r'in')
  final Iterable<double>? $in;

  final Iterable<double>? notIn;

  final double? lt;

  final double? lte;

  final double? gt;

  final double? gte;

  final NestedFloatFilter? not;

  @override
  Map<String, dynamic> toJson() => _$NestedFloatFilterToJson(this);
}

@_i1.jsonSerializable
class NestedBoolWithAggregatesFilter implements _i1.JsonSerializable {
  const NestedBoolWithAggregatesFilter({
    this.equals,
    this.not,
    this.$count,
    this.$min,
    this.$max,
  });

  factory NestedBoolWithAggregatesFilter.fromJson(Map<String, dynamic> json) =>
      _$NestedBoolWithAggregatesFilterFromJson(json);

  final bool? equals;

  final NestedBoolWithAggregatesFilter? not;

  @JsonKey(name: r'_count')
  final NestedIntFilter? $count;

  @JsonKey(name: r'_min')
  final NestedBoolFilter? $min;

  @JsonKey(name: r'_max')
  final NestedBoolFilter? $max;

  @override
  Map<String, dynamic> toJson() => _$NestedBoolWithAggregatesFilterToJson(this);
}

@_i1.jsonSerializable
class NestedFloatWithAggregatesFilter implements _i1.JsonSerializable {
  const NestedFloatWithAggregatesFilter({
    this.equals,
    this.$in,
    this.notIn,
    this.lt,
    this.lte,
    this.gt,
    this.gte,
    this.not,
    this.$count,
    this.$avg,
    this.$sum,
    this.$min,
    this.$max,
  });

  factory NestedFloatWithAggregatesFilter.fromJson(Map<String, dynamic> json) =>
      _$NestedFloatWithAggregatesFilterFromJson(json);

  final double? equals;

  @JsonKey(name: r'in')
  final Iterable<double>? $in;

  final Iterable<double>? notIn;

  final double? lt;

  final double? lte;

  final double? gt;

  final double? gte;

  final NestedFloatWithAggregatesFilter? not;

  @JsonKey(name: r'_count')
  final NestedIntFilter? $count;

  @JsonKey(name: r'_avg')
  final NestedFloatFilter? $avg;

  @JsonKey(name: r'_sum')
  final NestedFloatFilter? $sum;

  @JsonKey(name: r'_min')
  final NestedFloatFilter? $min;

  @JsonKey(name: r'_max')
  final NestedFloatFilter? $max;

  @override
  Map<String, dynamic> toJson() =>
      _$NestedFloatWithAggregatesFilterToJson(this);
}

@_i1.jsonSerializable
class PrismaAddress implements _i1.JsonSerializable {
  const PrismaAddress({
    required this.address,
    required this.status,
    required this.confirmedBalance,
    required this.unconfirmedBalance,
    this.utxoHistory,
    required this.needsUpdating,
  });

  factory PrismaAddress.fromJson(Map<String, dynamic> json) =>
      _$PrismaAddressFromJson(json);

  final String address;

  final String status;

  final int confirmedBalance;

  final int unconfirmedBalance;

  final Iterable<String>? utxoHistory;

  final bool needsUpdating;

  @override
  Map<String, dynamic> toJson() => _$PrismaAddressToJson(this);
}

@_i1.jsonSerializable
class PrismaBlock implements _i1.JsonSerializable {
  const PrismaBlock({
    required this.id,
    required this.hash,
    required this.blocktime,
  });

  factory PrismaBlock.fromJson(Map<String, dynamic> json) =>
      _$PrismaBlockFromJson(json);

  final int id;

  final String hash;

  final int blocktime;

  @override
  Map<String, dynamic> toJson() => _$PrismaBlockToJson(this);
}

@_i1.jsonSerializable
class PrismaUtxo implements _i1.JsonSerializable {
  const PrismaUtxo({
    required this.id,
    required this.txid,
    required this.txpos,
    required this.block,
    required this.value,
    this.addresses,
    required this.flaggedForDelete,
  });

  factory PrismaUtxo.fromJson(Map<String, dynamic> json) =>
      _$PrismaUtxoFromJson(json);

  final int id;

  final String txid;

  final int txpos;

  final int block;

  final double value;

  final Iterable<String>? addresses;

  final bool flaggedForDelete;

  @override
  Map<String, dynamic> toJson() => _$PrismaUtxoToJson(this);
}

class PrismaAddressFluent<T> extends _i1.PrismaFluent<T> {
  const PrismaAddressFluent(
    super.original,
    super.$query,
  );
}

class PrismaBlockFluent<T> extends _i1.PrismaFluent<T> {
  const PrismaBlockFluent(
    super.original,
    super.$query,
  );
}

class PrismaUtxoFluent<T> extends _i1.PrismaFluent<T> {
  const PrismaUtxoFluent(
    super.original,
    super.$query,
  );
}

extension PrismaAddressModelDelegateExtension
    on _i1.ModelDelegate<PrismaAddress> {
  PrismaAddressFluent<PrismaAddress?> findUnique(
      {required PrismaAddressWhereUniqueInput where}) {
    final args = [
      _i2.GraphQLArg(
        r'where',
        where,
      )
    ];
    final query = _i1.PrismaFluent.queryBuilder(
      query: (fields) => $query([
        _i2.GraphQLField(
          r'findUniquePrismaAddress',
          fields: fields,
          args: args,
        )
      ]),
      key: r'findUniquePrismaAddress',
    );
    final future = query(PrismaAddressScalarFieldEnum.values.toGraphQLFields())
        .then((json) => json is Map
            ? PrismaAddress.fromJson(json.cast<String, dynamic>())
            : null);
    return PrismaAddressFluent<PrismaAddress?>(
      future,
      query,
    );
  }

  PrismaAddressFluent<PrismaAddress> findUniqueOrThrow(
      {required PrismaAddressWhereUniqueInput where}) {
    final args = [
      _i2.GraphQLArg(
        r'where',
        where,
      )
    ];
    final query = _i1.PrismaFluent.queryBuilder(
      query: (fields) => $query([
        _i2.GraphQLField(
          r'findUniquePrismaAddressOrThrow',
          fields: fields,
          args: args,
        )
      ]),
      key: r'findUniquePrismaAddressOrThrow',
    );
    final future = query(PrismaAddressScalarFieldEnum.values.toGraphQLFields())
        .then((json) => json is Map
            ? PrismaAddress.fromJson(json.cast<String, dynamic>())
            : throw Exception(
                'Not found TypeRefType.string(value: PrismaAddress)'));
    return PrismaAddressFluent<PrismaAddress>(
      future,
      query,
    );
  }

  PrismaAddressFluent<PrismaAddress?> findFirst({
    PrismaAddressWhereInput? where,
    Iterable<PrismaAddressOrderByWithRelationInput>? orderBy,
    PrismaAddressWhereUniqueInput? cursor,
    int? take,
    int? skip,
    Iterable<PrismaAddressScalarFieldEnum>? distinct,
  }) {
    final args = [
      _i2.GraphQLArg(
        r'where',
        where,
      ),
      _i2.GraphQLArg(
        r'orderBy',
        orderBy,
      ),
      _i2.GraphQLArg(
        r'cursor',
        cursor,
      ),
      _i2.GraphQLArg(
        r'take',
        take,
      ),
      _i2.GraphQLArg(
        r'skip',
        skip,
      ),
      _i2.GraphQLArg(
        r'distinct',
        distinct,
      ),
    ];
    final query = _i1.PrismaFluent.queryBuilder(
      query: (fields) => $query([
        _i2.GraphQLField(
          r'findFirstPrismaAddress',
          fields: fields,
          args: args,
        )
      ]),
      key: r'findFirstPrismaAddress',
    );
    final future = query(PrismaAddressScalarFieldEnum.values.toGraphQLFields())
        .then((json) => json is Map
            ? PrismaAddress.fromJson(json.cast<String, dynamic>())
            : null);
    return PrismaAddressFluent<PrismaAddress?>(
      future,
      query,
    );
  }

  PrismaAddressFluent<PrismaAddress> findFirstOrThrow({
    PrismaAddressWhereInput? where,
    Iterable<PrismaAddressOrderByWithRelationInput>? orderBy,
    PrismaAddressWhereUniqueInput? cursor,
    int? take,
    int? skip,
    Iterable<PrismaAddressScalarFieldEnum>? distinct,
  }) {
    final args = [
      _i2.GraphQLArg(
        r'where',
        where,
      ),
      _i2.GraphQLArg(
        r'orderBy',
        orderBy,
      ),
      _i2.GraphQLArg(
        r'cursor',
        cursor,
      ),
      _i2.GraphQLArg(
        r'take',
        take,
      ),
      _i2.GraphQLArg(
        r'skip',
        skip,
      ),
      _i2.GraphQLArg(
        r'distinct',
        distinct,
      ),
    ];
    final query = _i1.PrismaFluent.queryBuilder(
      query: (fields) => $query([
        _i2.GraphQLField(
          r'findFirstPrismaAddressOrThrow',
          fields: fields,
          args: args,
        )
      ]),
      key: r'findFirstPrismaAddressOrThrow',
    );
    final future = query(PrismaAddressScalarFieldEnum.values.toGraphQLFields())
        .then((json) => json is Map
            ? PrismaAddress.fromJson(json.cast<String, dynamic>())
            : throw Exception(
                'Not found TypeRefType.string(value: PrismaAddress)'));
    return PrismaAddressFluent<PrismaAddress>(
      future,
      query,
    );
  }

  Future<Iterable<PrismaAddress>> findMany({
    PrismaAddressWhereInput? where,
    Iterable<PrismaAddressOrderByWithRelationInput>? orderBy,
    PrismaAddressWhereUniqueInput? cursor,
    int? take,
    int? skip,
    Iterable<PrismaAddressScalarFieldEnum>? distinct,
  }) {
    final args = [
      _i2.GraphQLArg(
        r'where',
        where,
      ),
      _i2.GraphQLArg(
        r'orderBy',
        orderBy,
      ),
      _i2.GraphQLArg(
        r'cursor',
        cursor,
      ),
      _i2.GraphQLArg(
        r'take',
        take,
      ),
      _i2.GraphQLArg(
        r'skip',
        skip,
      ),
      _i2.GraphQLArg(
        r'distinct',
        distinct,
      ),
    ];
    final query = _i1.PrismaFluent.queryBuilder(
      query: (fields) => $query([
        _i2.GraphQLField(
          r'findManyPrismaAddress',
          fields: fields,
          args: args,
        )
      ]),
      key: r'findManyPrismaAddress',
    );
    final fields = PrismaAddressScalarFieldEnum.values.toGraphQLFields();
    compiler(Iterable<Map> findManyPrismaAddress) =>
        findManyPrismaAddress.map((Map findManyPrismaAddress) =>
            PrismaAddress.fromJson(findManyPrismaAddress.cast()));
    return query(fields).then((json) => json is Iterable
        ? compiler(json.cast())
        : throw Exception('Unable to parse response'));
  }

  PrismaAddressFluent<PrismaAddress> create(
      {required PrismaAddressCreateInput data}) {
    final args = [
      _i2.GraphQLArg(
        r'data',
        data,
      )
    ];
    final query = _i1.PrismaFluent.queryBuilder(
      query: (fields) => $mutation([
        _i2.GraphQLField(
          r'createOnePrismaAddress',
          fields: fields,
          args: args,
        )
      ]),
      key: r'createOnePrismaAddress',
    );
    final future = query(PrismaAddressScalarFieldEnum.values.toGraphQLFields())
        .then((json) => json is Map
            ? PrismaAddress.fromJson(json.cast<String, dynamic>())
            : throw Exception(
                'Not found TypeRefType.string(value: PrismaAddress)'));
    return PrismaAddressFluent<PrismaAddress>(
      future,
      query,
    );
  }

  Future<AffectedRowsOutput> createMany({
    required Iterable<PrismaAddressCreateManyInput> data,
    bool? skipDuplicates,
  }) {
    final args = [
      _i2.GraphQLArg(
        r'data',
        data,
      ),
      _i2.GraphQLArg(
        r'skipDuplicates',
        skipDuplicates,
      ),
    ];
    final query = _i1.PrismaFluent.queryBuilder(
      query: (fields) => $mutation([
        _i2.GraphQLField(
          r'createManyPrismaAddress',
          fields: fields,
          args: args,
        )
      ]),
      key: r'createManyPrismaAddress',
    );
    final fields = const ['count'].map((e) => _i2.GraphQLField(e));
    compiler(Map createManyPrismaAddress) =>
        AffectedRowsOutput.fromJson(createManyPrismaAddress.cast());
    return query(fields).then((json) => json is Map
        ? compiler(json)
        : throw Exception('Unable to parse response'));
  }

  PrismaAddressFluent<PrismaAddress?> update({
    required PrismaAddressUpdateInput data,
    required PrismaAddressWhereUniqueInput where,
  }) {
    final args = [
      _i2.GraphQLArg(
        r'data',
        data,
      ),
      _i2.GraphQLArg(
        r'where',
        where,
      ),
    ];
    final query = _i1.PrismaFluent.queryBuilder(
      query: (fields) => $mutation([
        _i2.GraphQLField(
          r'updateOnePrismaAddress',
          fields: fields,
          args: args,
        )
      ]),
      key: r'updateOnePrismaAddress',
    );
    final future = query(PrismaAddressScalarFieldEnum.values.toGraphQLFields())
        .then((json) => json is Map
            ? PrismaAddress.fromJson(json.cast<String, dynamic>())
            : null);
    return PrismaAddressFluent<PrismaAddress?>(
      future,
      query,
    );
  }

  Future<AffectedRowsOutput> updateMany({
    required PrismaAddressUpdateManyMutationInput data,
    PrismaAddressWhereInput? where,
  }) {
    final args = [
      _i2.GraphQLArg(
        r'data',
        data,
      ),
      _i2.GraphQLArg(
        r'where',
        where,
      ),
    ];
    final query = _i1.PrismaFluent.queryBuilder(
      query: (fields) => $mutation([
        _i2.GraphQLField(
          r'updateManyPrismaAddress',
          fields: fields,
          args: args,
        )
      ]),
      key: r'updateManyPrismaAddress',
    );
    final fields = const ['count'].map((e) => _i2.GraphQLField(e));
    compiler(Map updateManyPrismaAddress) =>
        AffectedRowsOutput.fromJson(updateManyPrismaAddress.cast());
    return query(fields).then((json) => json is Map
        ? compiler(json)
        : throw Exception('Unable to parse response'));
  }

  PrismaAddressFluent<PrismaAddress> upsert({
    required PrismaAddressWhereUniqueInput where,
    required PrismaAddressCreateInput create,
    required PrismaAddressUpdateInput update,
  }) {
    final args = [
      _i2.GraphQLArg(
        r'where',
        where,
      ),
      _i2.GraphQLArg(
        r'create',
        create,
      ),
      _i2.GraphQLArg(
        r'update',
        update,
      ),
    ];
    final query = _i1.PrismaFluent.queryBuilder(
      query: (fields) => $mutation([
        _i2.GraphQLField(
          r'upsertOnePrismaAddress',
          fields: fields,
          args: args,
        )
      ]),
      key: r'upsertOnePrismaAddress',
    );
    final future = query(PrismaAddressScalarFieldEnum.values.toGraphQLFields())
        .then((json) => json is Map
            ? PrismaAddress.fromJson(json.cast<String, dynamic>())
            : throw Exception(
                'Not found TypeRefType.string(value: PrismaAddress)'));
    return PrismaAddressFluent<PrismaAddress>(
      future,
      query,
    );
  }

  PrismaAddressFluent<PrismaAddress?> delete(
      {required PrismaAddressWhereUniqueInput where}) {
    final args = [
      _i2.GraphQLArg(
        r'where',
        where,
      )
    ];
    final query = _i1.PrismaFluent.queryBuilder(
      query: (fields) => $mutation([
        _i2.GraphQLField(
          r'deleteOnePrismaAddress',
          fields: fields,
          args: args,
        )
      ]),
      key: r'deleteOnePrismaAddress',
    );
    final future = query(PrismaAddressScalarFieldEnum.values.toGraphQLFields())
        .then((json) => json is Map
            ? PrismaAddress.fromJson(json.cast<String, dynamic>())
            : null);
    return PrismaAddressFluent<PrismaAddress?>(
      future,
      query,
    );
  }

  Future<AffectedRowsOutput> deleteMany({PrismaAddressWhereInput? where}) {
    final args = [
      _i2.GraphQLArg(
        r'where',
        where,
      )
    ];
    final query = _i1.PrismaFluent.queryBuilder(
      query: (fields) => $mutation([
        _i2.GraphQLField(
          r'deleteManyPrismaAddress',
          fields: fields,
          args: args,
        )
      ]),
      key: r'deleteManyPrismaAddress',
    );
    final fields = const ['count'].map((e) => _i2.GraphQLField(e));
    compiler(Map deleteManyPrismaAddress) =>
        AffectedRowsOutput.fromJson(deleteManyPrismaAddress.cast());
    return query(fields).then((json) => json is Map
        ? compiler(json)
        : throw Exception('Unable to parse response'));
  }

  AggregatePrismaAddress aggregate({
    PrismaAddressWhereInput? where,
    Iterable<PrismaAddressOrderByWithRelationInput>? orderBy,
    PrismaAddressWhereUniqueInput? cursor,
    int? take,
    int? skip,
  }) {
    final args = [
      _i2.GraphQLArg(
        r'where',
        where,
      ),
      _i2.GraphQLArg(
        r'orderBy',
        orderBy,
      ),
      _i2.GraphQLArg(
        r'cursor',
        cursor,
      ),
      _i2.GraphQLArg(
        r'take',
        take,
      ),
      _i2.GraphQLArg(
        r'skip',
        skip,
      ),
    ];
    final query = _i1.PrismaFluent.queryBuilder(
      query: (fields) => $query([
        _i2.GraphQLField(
          r'aggregatePrismaAddress',
          fields: fields,
          args: args,
        )
      ]),
      key: r'aggregatePrismaAddress',
    );
    return AggregatePrismaAddress(query);
  }

  Future<Iterable<PrismaAddressGroupByOutputType>> groupBy({
    PrismaAddressWhereInput? where,
    Iterable<PrismaAddressOrderByWithAggregationInput>? orderBy,
    required Iterable<PrismaAddressScalarFieldEnum> by,
    PrismaAddressScalarWhereWithAggregatesInput? having,
    int? take,
    int? skip,
  }) {
    final args = [
      _i2.GraphQLArg(
        r'where',
        where,
      ),
      _i2.GraphQLArg(
        r'orderBy',
        orderBy,
      ),
      _i2.GraphQLArg(
        r'by',
        by,
      ),
      _i2.GraphQLArg(
        r'having',
        having,
      ),
      _i2.GraphQLArg(
        r'take',
        take,
      ),
      _i2.GraphQLArg(
        r'skip',
        skip,
      ),
    ];
    final query = _i1.PrismaFluent.queryBuilder(
      query: (fields) => $query([
        _i2.GraphQLField(
          r'groupByPrismaAddress',
          fields: fields,
          args: args,
        )
      ]),
      key: r'groupByPrismaAddress',
    );
    final fields = by.map((e) => _i2.GraphQLField(e.originalName ?? e.name));
    compiler(Iterable<Map> groupByPrismaAddress) => groupByPrismaAddress.map(
        (Map groupByPrismaAddress) => PrismaAddressGroupByOutputType.fromJson(
            groupByPrismaAddress.cast()));
    return query(fields).then((json) => json is Iterable
        ? compiler(json.cast())
        : throw Exception('Unable to parse response'));
  }
}

extension PrismaBlockModelDelegateExtension on _i1.ModelDelegate<PrismaBlock> {
  PrismaBlockFluent<PrismaBlock?> findUnique(
      {required PrismaBlockWhereUniqueInput where}) {
    final args = [
      _i2.GraphQLArg(
        r'where',
        where,
      )
    ];
    final query = _i1.PrismaFluent.queryBuilder(
      query: (fields) => $query([
        _i2.GraphQLField(
          r'findUniquePrismaBlock',
          fields: fields,
          args: args,
        )
      ]),
      key: r'findUniquePrismaBlock',
    );
    final future = query(PrismaBlockScalarFieldEnum.values.toGraphQLFields())
        .then((json) => json is Map
            ? PrismaBlock.fromJson(json.cast<String, dynamic>())
            : null);
    return PrismaBlockFluent<PrismaBlock?>(
      future,
      query,
    );
  }

  PrismaBlockFluent<PrismaBlock> findUniqueOrThrow(
      {required PrismaBlockWhereUniqueInput where}) {
    final args = [
      _i2.GraphQLArg(
        r'where',
        where,
      )
    ];
    final query = _i1.PrismaFluent.queryBuilder(
      query: (fields) => $query([
        _i2.GraphQLField(
          r'findUniquePrismaBlockOrThrow',
          fields: fields,
          args: args,
        )
      ]),
      key: r'findUniquePrismaBlockOrThrow',
    );
    final future = query(PrismaBlockScalarFieldEnum.values.toGraphQLFields())
        .then((json) => json is Map
            ? PrismaBlock.fromJson(json.cast<String, dynamic>())
            : throw Exception(
                'Not found TypeRefType.string(value: PrismaBlock)'));
    return PrismaBlockFluent<PrismaBlock>(
      future,
      query,
    );
  }

  PrismaBlockFluent<PrismaBlock?> findFirst({
    PrismaBlockWhereInput? where,
    Iterable<PrismaBlockOrderByWithRelationInput>? orderBy,
    PrismaBlockWhereUniqueInput? cursor,
    int? take,
    int? skip,
    Iterable<PrismaBlockScalarFieldEnum>? distinct,
  }) {
    final args = [
      _i2.GraphQLArg(
        r'where',
        where,
      ),
      _i2.GraphQLArg(
        r'orderBy',
        orderBy,
      ),
      _i2.GraphQLArg(
        r'cursor',
        cursor,
      ),
      _i2.GraphQLArg(
        r'take',
        take,
      ),
      _i2.GraphQLArg(
        r'skip',
        skip,
      ),
      _i2.GraphQLArg(
        r'distinct',
        distinct,
      ),
    ];
    final query = _i1.PrismaFluent.queryBuilder(
      query: (fields) => $query([
        _i2.GraphQLField(
          r'findFirstPrismaBlock',
          fields: fields,
          args: args,
        )
      ]),
      key: r'findFirstPrismaBlock',
    );
    final future = query(PrismaBlockScalarFieldEnum.values.toGraphQLFields())
        .then((json) => json is Map
            ? PrismaBlock.fromJson(json.cast<String, dynamic>())
            : null);
    return PrismaBlockFluent<PrismaBlock?>(
      future,
      query,
    );
  }

  PrismaBlockFluent<PrismaBlock> findFirstOrThrow({
    PrismaBlockWhereInput? where,
    Iterable<PrismaBlockOrderByWithRelationInput>? orderBy,
    PrismaBlockWhereUniqueInput? cursor,
    int? take,
    int? skip,
    Iterable<PrismaBlockScalarFieldEnum>? distinct,
  }) {
    final args = [
      _i2.GraphQLArg(
        r'where',
        where,
      ),
      _i2.GraphQLArg(
        r'orderBy',
        orderBy,
      ),
      _i2.GraphQLArg(
        r'cursor',
        cursor,
      ),
      _i2.GraphQLArg(
        r'take',
        take,
      ),
      _i2.GraphQLArg(
        r'skip',
        skip,
      ),
      _i2.GraphQLArg(
        r'distinct',
        distinct,
      ),
    ];
    final query = _i1.PrismaFluent.queryBuilder(
      query: (fields) => $query([
        _i2.GraphQLField(
          r'findFirstPrismaBlockOrThrow',
          fields: fields,
          args: args,
        )
      ]),
      key: r'findFirstPrismaBlockOrThrow',
    );
    final future = query(PrismaBlockScalarFieldEnum.values.toGraphQLFields())
        .then((json) => json is Map
            ? PrismaBlock.fromJson(json.cast<String, dynamic>())
            : throw Exception(
                'Not found TypeRefType.string(value: PrismaBlock)'));
    return PrismaBlockFluent<PrismaBlock>(
      future,
      query,
    );
  }

  Future<Iterable<PrismaBlock>> findMany({
    PrismaBlockWhereInput? where,
    Iterable<PrismaBlockOrderByWithRelationInput>? orderBy,
    PrismaBlockWhereUniqueInput? cursor,
    int? take,
    int? skip,
    Iterable<PrismaBlockScalarFieldEnum>? distinct,
  }) {
    final args = [
      _i2.GraphQLArg(
        r'where',
        where,
      ),
      _i2.GraphQLArg(
        r'orderBy',
        orderBy,
      ),
      _i2.GraphQLArg(
        r'cursor',
        cursor,
      ),
      _i2.GraphQLArg(
        r'take',
        take,
      ),
      _i2.GraphQLArg(
        r'skip',
        skip,
      ),
      _i2.GraphQLArg(
        r'distinct',
        distinct,
      ),
    ];
    final query = _i1.PrismaFluent.queryBuilder(
      query: (fields) => $query([
        _i2.GraphQLField(
          r'findManyPrismaBlock',
          fields: fields,
          args: args,
        )
      ]),
      key: r'findManyPrismaBlock',
    );
    final fields = PrismaBlockScalarFieldEnum.values.toGraphQLFields();
    compiler(Iterable<Map> findManyPrismaBlock) =>
        findManyPrismaBlock.map((Map findManyPrismaBlock) =>
            PrismaBlock.fromJson(findManyPrismaBlock.cast()));
    return query(fields).then((json) => json is Iterable
        ? compiler(json.cast())
        : throw Exception('Unable to parse response'));
  }

  PrismaBlockFluent<PrismaBlock> create(
      {required PrismaBlockCreateInput data}) {
    final args = [
      _i2.GraphQLArg(
        r'data',
        data,
      )
    ];
    final query = _i1.PrismaFluent.queryBuilder(
      query: (fields) => $mutation([
        _i2.GraphQLField(
          r'createOnePrismaBlock',
          fields: fields,
          args: args,
        )
      ]),
      key: r'createOnePrismaBlock',
    );
    final future = query(PrismaBlockScalarFieldEnum.values.toGraphQLFields())
        .then((json) => json is Map
            ? PrismaBlock.fromJson(json.cast<String, dynamic>())
            : throw Exception(
                'Not found TypeRefType.string(value: PrismaBlock)'));
    return PrismaBlockFluent<PrismaBlock>(
      future,
      query,
    );
  }

  Future<AffectedRowsOutput> createMany({
    required Iterable<PrismaBlockCreateManyInput> data,
    bool? skipDuplicates,
  }) {
    final args = [
      _i2.GraphQLArg(
        r'data',
        data,
      ),
      _i2.GraphQLArg(
        r'skipDuplicates',
        skipDuplicates,
      ),
    ];
    final query = _i1.PrismaFluent.queryBuilder(
      query: (fields) => $mutation([
        _i2.GraphQLField(
          r'createManyPrismaBlock',
          fields: fields,
          args: args,
        )
      ]),
      key: r'createManyPrismaBlock',
    );
    final fields = const ['count'].map((e) => _i2.GraphQLField(e));
    compiler(Map createManyPrismaBlock) =>
        AffectedRowsOutput.fromJson(createManyPrismaBlock.cast());
    return query(fields).then((json) => json is Map
        ? compiler(json)
        : throw Exception('Unable to parse response'));
  }

  PrismaBlockFluent<PrismaBlock?> update({
    required PrismaBlockUpdateInput data,
    required PrismaBlockWhereUniqueInput where,
  }) {
    final args = [
      _i2.GraphQLArg(
        r'data',
        data,
      ),
      _i2.GraphQLArg(
        r'where',
        where,
      ),
    ];
    final query = _i1.PrismaFluent.queryBuilder(
      query: (fields) => $mutation([
        _i2.GraphQLField(
          r'updateOnePrismaBlock',
          fields: fields,
          args: args,
        )
      ]),
      key: r'updateOnePrismaBlock',
    );
    final future = query(PrismaBlockScalarFieldEnum.values.toGraphQLFields())
        .then((json) => json is Map
            ? PrismaBlock.fromJson(json.cast<String, dynamic>())
            : null);
    return PrismaBlockFluent<PrismaBlock?>(
      future,
      query,
    );
  }

  Future<AffectedRowsOutput> updateMany({
    required PrismaBlockUpdateManyMutationInput data,
    PrismaBlockWhereInput? where,
  }) {
    final args = [
      _i2.GraphQLArg(
        r'data',
        data,
      ),
      _i2.GraphQLArg(
        r'where',
        where,
      ),
    ];
    final query = _i1.PrismaFluent.queryBuilder(
      query: (fields) => $mutation([
        _i2.GraphQLField(
          r'updateManyPrismaBlock',
          fields: fields,
          args: args,
        )
      ]),
      key: r'updateManyPrismaBlock',
    );
    final fields = const ['count'].map((e) => _i2.GraphQLField(e));
    compiler(Map updateManyPrismaBlock) =>
        AffectedRowsOutput.fromJson(updateManyPrismaBlock.cast());
    return query(fields).then((json) => json is Map
        ? compiler(json)
        : throw Exception('Unable to parse response'));
  }

  PrismaBlockFluent<PrismaBlock> upsert({
    required PrismaBlockWhereUniqueInput where,
    required PrismaBlockCreateInput create,
    required PrismaBlockUpdateInput update,
  }) {
    final args = [
      _i2.GraphQLArg(
        r'where',
        where,
      ),
      _i2.GraphQLArg(
        r'create',
        create,
      ),
      _i2.GraphQLArg(
        r'update',
        update,
      ),
    ];
    final query = _i1.PrismaFluent.queryBuilder(
      query: (fields) => $mutation([
        _i2.GraphQLField(
          r'upsertOnePrismaBlock',
          fields: fields,
          args: args,
        )
      ]),
      key: r'upsertOnePrismaBlock',
    );
    final future = query(PrismaBlockScalarFieldEnum.values.toGraphQLFields())
        .then((json) => json is Map
            ? PrismaBlock.fromJson(json.cast<String, dynamic>())
            : throw Exception(
                'Not found TypeRefType.string(value: PrismaBlock)'));
    return PrismaBlockFluent<PrismaBlock>(
      future,
      query,
    );
  }

  PrismaBlockFluent<PrismaBlock?> delete(
      {required PrismaBlockWhereUniqueInput where}) {
    final args = [
      _i2.GraphQLArg(
        r'where',
        where,
      )
    ];
    final query = _i1.PrismaFluent.queryBuilder(
      query: (fields) => $mutation([
        _i2.GraphQLField(
          r'deleteOnePrismaBlock',
          fields: fields,
          args: args,
        )
      ]),
      key: r'deleteOnePrismaBlock',
    );
    final future = query(PrismaBlockScalarFieldEnum.values.toGraphQLFields())
        .then((json) => json is Map
            ? PrismaBlock.fromJson(json.cast<String, dynamic>())
            : null);
    return PrismaBlockFluent<PrismaBlock?>(
      future,
      query,
    );
  }

  Future<AffectedRowsOutput> deleteMany({PrismaBlockWhereInput? where}) {
    final args = [
      _i2.GraphQLArg(
        r'where',
        where,
      )
    ];
    final query = _i1.PrismaFluent.queryBuilder(
      query: (fields) => $mutation([
        _i2.GraphQLField(
          r'deleteManyPrismaBlock',
          fields: fields,
          args: args,
        )
      ]),
      key: r'deleteManyPrismaBlock',
    );
    final fields = const ['count'].map((e) => _i2.GraphQLField(e));
    compiler(Map deleteManyPrismaBlock) =>
        AffectedRowsOutput.fromJson(deleteManyPrismaBlock.cast());
    return query(fields).then((json) => json is Map
        ? compiler(json)
        : throw Exception('Unable to parse response'));
  }

  AggregatePrismaBlock aggregate({
    PrismaBlockWhereInput? where,
    Iterable<PrismaBlockOrderByWithRelationInput>? orderBy,
    PrismaBlockWhereUniqueInput? cursor,
    int? take,
    int? skip,
  }) {
    final args = [
      _i2.GraphQLArg(
        r'where',
        where,
      ),
      _i2.GraphQLArg(
        r'orderBy',
        orderBy,
      ),
      _i2.GraphQLArg(
        r'cursor',
        cursor,
      ),
      _i2.GraphQLArg(
        r'take',
        take,
      ),
      _i2.GraphQLArg(
        r'skip',
        skip,
      ),
    ];
    final query = _i1.PrismaFluent.queryBuilder(
      query: (fields) => $query([
        _i2.GraphQLField(
          r'aggregatePrismaBlock',
          fields: fields,
          args: args,
        )
      ]),
      key: r'aggregatePrismaBlock',
    );
    return AggregatePrismaBlock(query);
  }

  Future<Iterable<PrismaBlockGroupByOutputType>> groupBy({
    PrismaBlockWhereInput? where,
    Iterable<PrismaBlockOrderByWithAggregationInput>? orderBy,
    required Iterable<PrismaBlockScalarFieldEnum> by,
    PrismaBlockScalarWhereWithAggregatesInput? having,
    int? take,
    int? skip,
  }) {
    final args = [
      _i2.GraphQLArg(
        r'where',
        where,
      ),
      _i2.GraphQLArg(
        r'orderBy',
        orderBy,
      ),
      _i2.GraphQLArg(
        r'by',
        by,
      ),
      _i2.GraphQLArg(
        r'having',
        having,
      ),
      _i2.GraphQLArg(
        r'take',
        take,
      ),
      _i2.GraphQLArg(
        r'skip',
        skip,
      ),
    ];
    final query = _i1.PrismaFluent.queryBuilder(
      query: (fields) => $query([
        _i2.GraphQLField(
          r'groupByPrismaBlock',
          fields: fields,
          args: args,
        )
      ]),
      key: r'groupByPrismaBlock',
    );
    final fields = by.map((e) => _i2.GraphQLField(e.originalName ?? e.name));
    compiler(Iterable<Map> groupByPrismaBlock) =>
        groupByPrismaBlock.map((Map groupByPrismaBlock) =>
            PrismaBlockGroupByOutputType.fromJson(groupByPrismaBlock.cast()));
    return query(fields).then((json) => json is Iterable
        ? compiler(json.cast())
        : throw Exception('Unable to parse response'));
  }
}

extension PrismaUtxoModelDelegateExtension on _i1.ModelDelegate<PrismaUtxo> {
  PrismaUtxoFluent<PrismaUtxo?> findUnique(
      {required PrismaUtxoWhereUniqueInput where}) {
    final args = [
      _i2.GraphQLArg(
        r'where',
        where,
      )
    ];
    final query = _i1.PrismaFluent.queryBuilder(
      query: (fields) => $query([
        _i2.GraphQLField(
          r'findUniquePrismaUtxo',
          fields: fields,
          args: args,
        )
      ]),
      key: r'findUniquePrismaUtxo',
    );
    final future = query(PrismaUtxoScalarFieldEnum.values.toGraphQLFields())
        .then((json) => json is Map
            ? PrismaUtxo.fromJson(json.cast<String, dynamic>())
            : null);
    return PrismaUtxoFluent<PrismaUtxo?>(
      future,
      query,
    );
  }

  PrismaUtxoFluent<PrismaUtxo> findUniqueOrThrow(
      {required PrismaUtxoWhereUniqueInput where}) {
    final args = [
      _i2.GraphQLArg(
        r'where',
        where,
      )
    ];
    final query = _i1.PrismaFluent.queryBuilder(
      query: (fields) => $query([
        _i2.GraphQLField(
          r'findUniquePrismaUtxoOrThrow',
          fields: fields,
          args: args,
        )
      ]),
      key: r'findUniquePrismaUtxoOrThrow',
    );
    final future = query(PrismaUtxoScalarFieldEnum.values.toGraphQLFields())
        .then((json) => json is Map
            ? PrismaUtxo.fromJson(json.cast<String, dynamic>())
            : throw Exception(
                'Not found TypeRefType.string(value: PrismaUtxo)'));
    return PrismaUtxoFluent<PrismaUtxo>(
      future,
      query,
    );
  }

  PrismaUtxoFluent<PrismaUtxo?> findFirst({
    PrismaUtxoWhereInput? where,
    Iterable<PrismaUtxoOrderByWithRelationInput>? orderBy,
    PrismaUtxoWhereUniqueInput? cursor,
    int? take,
    int? skip,
    Iterable<PrismaUtxoScalarFieldEnum>? distinct,
  }) {
    final args = [
      _i2.GraphQLArg(
        r'where',
        where,
      ),
      _i2.GraphQLArg(
        r'orderBy',
        orderBy,
      ),
      _i2.GraphQLArg(
        r'cursor',
        cursor,
      ),
      _i2.GraphQLArg(
        r'take',
        take,
      ),
      _i2.GraphQLArg(
        r'skip',
        skip,
      ),
      _i2.GraphQLArg(
        r'distinct',
        distinct,
      ),
    ];
    final query = _i1.PrismaFluent.queryBuilder(
      query: (fields) => $query([
        _i2.GraphQLField(
          r'findFirstPrismaUtxo',
          fields: fields,
          args: args,
        )
      ]),
      key: r'findFirstPrismaUtxo',
    );
    final future = query(PrismaUtxoScalarFieldEnum.values.toGraphQLFields())
        .then((json) => json is Map
            ? PrismaUtxo.fromJson(json.cast<String, dynamic>())
            : null);
    return PrismaUtxoFluent<PrismaUtxo?>(
      future,
      query,
    );
  }

  PrismaUtxoFluent<PrismaUtxo> findFirstOrThrow({
    PrismaUtxoWhereInput? where,
    Iterable<PrismaUtxoOrderByWithRelationInput>? orderBy,
    PrismaUtxoWhereUniqueInput? cursor,
    int? take,
    int? skip,
    Iterable<PrismaUtxoScalarFieldEnum>? distinct,
  }) {
    final args = [
      _i2.GraphQLArg(
        r'where',
        where,
      ),
      _i2.GraphQLArg(
        r'orderBy',
        orderBy,
      ),
      _i2.GraphQLArg(
        r'cursor',
        cursor,
      ),
      _i2.GraphQLArg(
        r'take',
        take,
      ),
      _i2.GraphQLArg(
        r'skip',
        skip,
      ),
      _i2.GraphQLArg(
        r'distinct',
        distinct,
      ),
    ];
    final query = _i1.PrismaFluent.queryBuilder(
      query: (fields) => $query([
        _i2.GraphQLField(
          r'findFirstPrismaUtxoOrThrow',
          fields: fields,
          args: args,
        )
      ]),
      key: r'findFirstPrismaUtxoOrThrow',
    );
    final future = query(PrismaUtxoScalarFieldEnum.values.toGraphQLFields())
        .then((json) => json is Map
            ? PrismaUtxo.fromJson(json.cast<String, dynamic>())
            : throw Exception(
                'Not found TypeRefType.string(value: PrismaUtxo)'));
    return PrismaUtxoFluent<PrismaUtxo>(
      future,
      query,
    );
  }

  Future<Iterable<PrismaUtxo>> findMany({
    PrismaUtxoWhereInput? where,
    Iterable<PrismaUtxoOrderByWithRelationInput>? orderBy,
    PrismaUtxoWhereUniqueInput? cursor,
    int? take,
    int? skip,
    Iterable<PrismaUtxoScalarFieldEnum>? distinct,
  }) {
    final args = [
      _i2.GraphQLArg(
        r'where',
        where,
      ),
      _i2.GraphQLArg(
        r'orderBy',
        orderBy,
      ),
      _i2.GraphQLArg(
        r'cursor',
        cursor,
      ),
      _i2.GraphQLArg(
        r'take',
        take,
      ),
      _i2.GraphQLArg(
        r'skip',
        skip,
      ),
      _i2.GraphQLArg(
        r'distinct',
        distinct,
      ),
    ];
    final query = _i1.PrismaFluent.queryBuilder(
      query: (fields) => $query([
        _i2.GraphQLField(
          r'findManyPrismaUtxo',
          fields: fields,
          args: args,
        )
      ]),
      key: r'findManyPrismaUtxo',
    );
    final fields = PrismaUtxoScalarFieldEnum.values.toGraphQLFields();
    compiler(Iterable<Map> findManyPrismaUtxo) =>
        findManyPrismaUtxo.map((Map findManyPrismaUtxo) =>
            PrismaUtxo.fromJson(findManyPrismaUtxo.cast()));
    return query(fields).then((json) => json is Iterable
        ? compiler(json.cast())
        : throw Exception('Unable to parse response'));
  }

  PrismaUtxoFluent<PrismaUtxo> create({required PrismaUtxoCreateInput data}) {
    final args = [
      _i2.GraphQLArg(
        r'data',
        data,
      )
    ];
    final query = _i1.PrismaFluent.queryBuilder(
      query: (fields) => $mutation([
        _i2.GraphQLField(
          r'createOnePrismaUtxo',
          fields: fields,
          args: args,
        )
      ]),
      key: r'createOnePrismaUtxo',
    );
    final future = query(PrismaUtxoScalarFieldEnum.values.toGraphQLFields())
        .then((json) => json is Map
            ? PrismaUtxo.fromJson(json.cast<String, dynamic>())
            : throw Exception(
                'Not found TypeRefType.string(value: PrismaUtxo)'));
    return PrismaUtxoFluent<PrismaUtxo>(
      future,
      query,
    );
  }

  Future<AffectedRowsOutput> createMany({
    required Iterable<PrismaUtxoCreateManyInput> data,
    bool? skipDuplicates,
  }) {
    final args = [
      _i2.GraphQLArg(
        r'data',
        data,
      ),
      _i2.GraphQLArg(
        r'skipDuplicates',
        skipDuplicates,
      ),
    ];
    final query = _i1.PrismaFluent.queryBuilder(
      query: (fields) => $mutation([
        _i2.GraphQLField(
          r'createManyPrismaUtxo',
          fields: fields,
          args: args,
        )
      ]),
      key: r'createManyPrismaUtxo',
    );
    final fields = const ['count'].map((e) => _i2.GraphQLField(e));
    compiler(Map createManyPrismaUtxo) =>
        AffectedRowsOutput.fromJson(createManyPrismaUtxo.cast());
    return query(fields).then((json) => json is Map
        ? compiler(json)
        : throw Exception('Unable to parse response'));
  }

  PrismaUtxoFluent<PrismaUtxo?> update({
    required PrismaUtxoUpdateInput data,
    required PrismaUtxoWhereUniqueInput where,
  }) {
    final args = [
      _i2.GraphQLArg(
        r'data',
        data,
      ),
      _i2.GraphQLArg(
        r'where',
        where,
      ),
    ];
    final query = _i1.PrismaFluent.queryBuilder(
      query: (fields) => $mutation([
        _i2.GraphQLField(
          r'updateOnePrismaUtxo',
          fields: fields,
          args: args,
        )
      ]),
      key: r'updateOnePrismaUtxo',
    );
    final future = query(PrismaUtxoScalarFieldEnum.values.toGraphQLFields())
        .then((json) => json is Map
            ? PrismaUtxo.fromJson(json.cast<String, dynamic>())
            : null);
    return PrismaUtxoFluent<PrismaUtxo?>(
      future,
      query,
    );
  }

  Future<AffectedRowsOutput> updateMany({
    required PrismaUtxoUpdateManyMutationInput data,
    PrismaUtxoWhereInput? where,
  }) {
    final args = [
      _i2.GraphQLArg(
        r'data',
        data,
      ),
      _i2.GraphQLArg(
        r'where',
        where,
      ),
    ];
    final query = _i1.PrismaFluent.queryBuilder(
      query: (fields) => $mutation([
        _i2.GraphQLField(
          r'updateManyPrismaUtxo',
          fields: fields,
          args: args,
        )
      ]),
      key: r'updateManyPrismaUtxo',
    );
    final fields = const ['count'].map((e) => _i2.GraphQLField(e));
    compiler(Map updateManyPrismaUtxo) =>
        AffectedRowsOutput.fromJson(updateManyPrismaUtxo.cast());
    return query(fields).then((json) => json is Map
        ? compiler(json)
        : throw Exception('Unable to parse response'));
  }

  PrismaUtxoFluent<PrismaUtxo> upsert({
    required PrismaUtxoWhereUniqueInput where,
    required PrismaUtxoCreateInput create,
    required PrismaUtxoUpdateInput update,
  }) {
    final args = [
      _i2.GraphQLArg(
        r'where',
        where,
      ),
      _i2.GraphQLArg(
        r'create',
        create,
      ),
      _i2.GraphQLArg(
        r'update',
        update,
      ),
    ];
    final query = _i1.PrismaFluent.queryBuilder(
      query: (fields) => $mutation([
        _i2.GraphQLField(
          r'upsertOnePrismaUtxo',
          fields: fields,
          args: args,
        )
      ]),
      key: r'upsertOnePrismaUtxo',
    );
    final future = query(PrismaUtxoScalarFieldEnum.values.toGraphQLFields())
        .then((json) => json is Map
            ? PrismaUtxo.fromJson(json.cast<String, dynamic>())
            : throw Exception(
                'Not found TypeRefType.string(value: PrismaUtxo)'));
    return PrismaUtxoFluent<PrismaUtxo>(
      future,
      query,
    );
  }

  PrismaUtxoFluent<PrismaUtxo?> delete(
      {required PrismaUtxoWhereUniqueInput where}) {
    final args = [
      _i2.GraphQLArg(
        r'where',
        where,
      )
    ];
    final query = _i1.PrismaFluent.queryBuilder(
      query: (fields) => $mutation([
        _i2.GraphQLField(
          r'deleteOnePrismaUtxo',
          fields: fields,
          args: args,
        )
      ]),
      key: r'deleteOnePrismaUtxo',
    );
    final future = query(PrismaUtxoScalarFieldEnum.values.toGraphQLFields())
        .then((json) => json is Map
            ? PrismaUtxo.fromJson(json.cast<String, dynamic>())
            : null);
    return PrismaUtxoFluent<PrismaUtxo?>(
      future,
      query,
    );
  }

  Future<AffectedRowsOutput> deleteMany({PrismaUtxoWhereInput? where}) {
    final args = [
      _i2.GraphQLArg(
        r'where',
        where,
      )
    ];
    final query = _i1.PrismaFluent.queryBuilder(
      query: (fields) => $mutation([
        _i2.GraphQLField(
          r'deleteManyPrismaUtxo',
          fields: fields,
          args: args,
        )
      ]),
      key: r'deleteManyPrismaUtxo',
    );
    final fields = const ['count'].map((e) => _i2.GraphQLField(e));
    compiler(Map deleteManyPrismaUtxo) =>
        AffectedRowsOutput.fromJson(deleteManyPrismaUtxo.cast());
    return query(fields).then((json) => json is Map
        ? compiler(json)
        : throw Exception('Unable to parse response'));
  }

  AggregatePrismaUtxo aggregate({
    PrismaUtxoWhereInput? where,
    Iterable<PrismaUtxoOrderByWithRelationInput>? orderBy,
    PrismaUtxoWhereUniqueInput? cursor,
    int? take,
    int? skip,
  }) {
    final args = [
      _i2.GraphQLArg(
        r'where',
        where,
      ),
      _i2.GraphQLArg(
        r'orderBy',
        orderBy,
      ),
      _i2.GraphQLArg(
        r'cursor',
        cursor,
      ),
      _i2.GraphQLArg(
        r'take',
        take,
      ),
      _i2.GraphQLArg(
        r'skip',
        skip,
      ),
    ];
    final query = _i1.PrismaFluent.queryBuilder(
      query: (fields) => $query([
        _i2.GraphQLField(
          r'aggregatePrismaUtxo',
          fields: fields,
          args: args,
        )
      ]),
      key: r'aggregatePrismaUtxo',
    );
    return AggregatePrismaUtxo(query);
  }

  Future<Iterable<PrismaUtxoGroupByOutputType>> groupBy({
    PrismaUtxoWhereInput? where,
    Iterable<PrismaUtxoOrderByWithAggregationInput>? orderBy,
    required Iterable<PrismaUtxoScalarFieldEnum> by,
    PrismaUtxoScalarWhereWithAggregatesInput? having,
    int? take,
    int? skip,
  }) {
    final args = [
      _i2.GraphQLArg(
        r'where',
        where,
      ),
      _i2.GraphQLArg(
        r'orderBy',
        orderBy,
      ),
      _i2.GraphQLArg(
        r'by',
        by,
      ),
      _i2.GraphQLArg(
        r'having',
        having,
      ),
      _i2.GraphQLArg(
        r'take',
        take,
      ),
      _i2.GraphQLArg(
        r'skip',
        skip,
      ),
    ];
    final query = _i1.PrismaFluent.queryBuilder(
      query: (fields) => $query([
        _i2.GraphQLField(
          r'groupByPrismaUtxo',
          fields: fields,
          args: args,
        )
      ]),
      key: r'groupByPrismaUtxo',
    );
    final fields = by.map((e) => _i2.GraphQLField(e.originalName ?? e.name));
    compiler(Iterable<Map> groupByPrismaUtxo) =>
        groupByPrismaUtxo.map((Map groupByPrismaUtxo) =>
            PrismaUtxoGroupByOutputType.fromJson(groupByPrismaUtxo.cast()));
    return query(fields).then((json) => json is Iterable
        ? compiler(json.cast())
        : throw Exception('Unable to parse response'));
  }
}

@_i1.jsonSerializable
class PrismaAddressGroupByOutputType implements _i1.JsonSerializable {
  const PrismaAddressGroupByOutputType({
    this.address,
    this.status,
    this.confirmedBalance,
    this.unconfirmedBalance,
    this.utxoHistory,
    this.needsUpdating,
  });

  factory PrismaAddressGroupByOutputType.fromJson(Map<String, dynamic> json) =>
      _$PrismaAddressGroupByOutputTypeFromJson(json);

  final String? address;

  final String? status;

  final int? confirmedBalance;

  final int? unconfirmedBalance;

  final Iterable<String>? utxoHistory;

  final bool? needsUpdating;

  @override
  Map<String, dynamic> toJson() => _$PrismaAddressGroupByOutputTypeToJson(this);
}

@_i1.jsonSerializable
class PrismaBlockGroupByOutputType implements _i1.JsonSerializable {
  const PrismaBlockGroupByOutputType({
    this.id,
    this.hash,
    this.blocktime,
  });

  factory PrismaBlockGroupByOutputType.fromJson(Map<String, dynamic> json) =>
      _$PrismaBlockGroupByOutputTypeFromJson(json);

  final int? id;

  final String? hash;

  final int? blocktime;

  @override
  Map<String, dynamic> toJson() => _$PrismaBlockGroupByOutputTypeToJson(this);
}

@_i1.jsonSerializable
class PrismaUtxoGroupByOutputType implements _i1.JsonSerializable {
  const PrismaUtxoGroupByOutputType({
    this.id,
    this.txid,
    this.txpos,
    this.block,
    this.value,
    this.addresses,
    this.flaggedForDelete,
  });

  factory PrismaUtxoGroupByOutputType.fromJson(Map<String, dynamic> json) =>
      _$PrismaUtxoGroupByOutputTypeFromJson(json);

  final int? id;

  final String? txid;

  final int? txpos;

  final int? block;

  final double? value;

  final Iterable<String>? addresses;

  final bool? flaggedForDelete;

  @override
  Map<String, dynamic> toJson() => _$PrismaUtxoGroupByOutputTypeToJson(this);
}

@_i1.jsonSerializable
class AffectedRowsOutput implements _i1.JsonSerializable {
  const AffectedRowsOutput({this.count});

  factory AffectedRowsOutput.fromJson(Map<String, dynamic> json) =>
      _$AffectedRowsOutputFromJson(json);

  final int? count;

  @override
  Map<String, dynamic> toJson() => _$AffectedRowsOutputToJson(this);
}

class AggregatePrismaAddress {
  const AggregatePrismaAddress(this.$query);

  final _i1.PrismaFluentQuery $query;

  PrismaAddressCountAggregateOutputType $count() {
    final query = _i1.PrismaFluent.queryBuilder(
      query: (fields) => $query([
        _i2.GraphQLField(
          r'_count',
          fields: fields,
        )
      ]),
      key: r'_count',
    );
    return PrismaAddressCountAggregateOutputType(query);
  }

  PrismaAddressAvgAggregateOutputType $avg() {
    final query = _i1.PrismaFluent.queryBuilder(
      query: (fields) => $query([
        _i2.GraphQLField(
          r'_avg',
          fields: fields,
        )
      ]),
      key: r'_avg',
    );
    return PrismaAddressAvgAggregateOutputType(query);
  }

  PrismaAddressSumAggregateOutputType $sum() {
    final query = _i1.PrismaFluent.queryBuilder(
      query: (fields) => $query([
        _i2.GraphQLField(
          r'_sum',
          fields: fields,
        )
      ]),
      key: r'_sum',
    );
    return PrismaAddressSumAggregateOutputType(query);
  }

  PrismaAddressMinAggregateOutputType $min() {
    final query = _i1.PrismaFluent.queryBuilder(
      query: (fields) => $query([
        _i2.GraphQLField(
          r'_min',
          fields: fields,
        )
      ]),
      key: r'_min',
    );
    return PrismaAddressMinAggregateOutputType(query);
  }

  PrismaAddressMaxAggregateOutputType $max() {
    final query = _i1.PrismaFluent.queryBuilder(
      query: (fields) => $query([
        _i2.GraphQLField(
          r'_max',
          fields: fields,
        )
      ]),
      key: r'_max',
    );
    return PrismaAddressMaxAggregateOutputType(query);
  }
}

class AggregatePrismaBlock {
  const AggregatePrismaBlock(this.$query);

  final _i1.PrismaFluentQuery $query;

  PrismaBlockCountAggregateOutputType $count() {
    final query = _i1.PrismaFluent.queryBuilder(
      query: (fields) => $query([
        _i2.GraphQLField(
          r'_count',
          fields: fields,
        )
      ]),
      key: r'_count',
    );
    return PrismaBlockCountAggregateOutputType(query);
  }

  PrismaBlockAvgAggregateOutputType $avg() {
    final query = _i1.PrismaFluent.queryBuilder(
      query: (fields) => $query([
        _i2.GraphQLField(
          r'_avg',
          fields: fields,
        )
      ]),
      key: r'_avg',
    );
    return PrismaBlockAvgAggregateOutputType(query);
  }

  PrismaBlockSumAggregateOutputType $sum() {
    final query = _i1.PrismaFluent.queryBuilder(
      query: (fields) => $query([
        _i2.GraphQLField(
          r'_sum',
          fields: fields,
        )
      ]),
      key: r'_sum',
    );
    return PrismaBlockSumAggregateOutputType(query);
  }

  PrismaBlockMinAggregateOutputType $min() {
    final query = _i1.PrismaFluent.queryBuilder(
      query: (fields) => $query([
        _i2.GraphQLField(
          r'_min',
          fields: fields,
        )
      ]),
      key: r'_min',
    );
    return PrismaBlockMinAggregateOutputType(query);
  }

  PrismaBlockMaxAggregateOutputType $max() {
    final query = _i1.PrismaFluent.queryBuilder(
      query: (fields) => $query([
        _i2.GraphQLField(
          r'_max',
          fields: fields,
        )
      ]),
      key: r'_max',
    );
    return PrismaBlockMaxAggregateOutputType(query);
  }
}

class AggregatePrismaUtxo {
  const AggregatePrismaUtxo(this.$query);

  final _i1.PrismaFluentQuery $query;

  PrismaUtxoCountAggregateOutputType $count() {
    final query = _i1.PrismaFluent.queryBuilder(
      query: (fields) => $query([
        _i2.GraphQLField(
          r'_count',
          fields: fields,
        )
      ]),
      key: r'_count',
    );
    return PrismaUtxoCountAggregateOutputType(query);
  }

  PrismaUtxoAvgAggregateOutputType $avg() {
    final query = _i1.PrismaFluent.queryBuilder(
      query: (fields) => $query([
        _i2.GraphQLField(
          r'_avg',
          fields: fields,
        )
      ]),
      key: r'_avg',
    );
    return PrismaUtxoAvgAggregateOutputType(query);
  }

  PrismaUtxoSumAggregateOutputType $sum() {
    final query = _i1.PrismaFluent.queryBuilder(
      query: (fields) => $query([
        _i2.GraphQLField(
          r'_sum',
          fields: fields,
        )
      ]),
      key: r'_sum',
    );
    return PrismaUtxoSumAggregateOutputType(query);
  }

  PrismaUtxoMinAggregateOutputType $min() {
    final query = _i1.PrismaFluent.queryBuilder(
      query: (fields) => $query([
        _i2.GraphQLField(
          r'_min',
          fields: fields,
        )
      ]),
      key: r'_min',
    );
    return PrismaUtxoMinAggregateOutputType(query);
  }

  PrismaUtxoMaxAggregateOutputType $max() {
    final query = _i1.PrismaFluent.queryBuilder(
      query: (fields) => $query([
        _i2.GraphQLField(
          r'_max',
          fields: fields,
        )
      ]),
      key: r'_max',
    );
    return PrismaUtxoMaxAggregateOutputType(query);
  }
}

class PrismaAddressCountAggregateOutputType {
  const PrismaAddressCountAggregateOutputType(this.$query);

  final _i1.PrismaFluentQuery $query;

  Future<int> address() {
    final query = _i1.PrismaFluent.queryBuilder(
      query: (fields) => $query([
        _i2.GraphQLField(
          r'address',
          fields: fields,
        )
      ]),
      key: r'address',
    );
    return query(const []).then((value) => (value as int));
  }

  Future<int> status() {
    final query = _i1.PrismaFluent.queryBuilder(
      query: (fields) => $query([
        _i2.GraphQLField(
          r'status',
          fields: fields,
        )
      ]),
      key: r'status',
    );
    return query(const []).then((value) => (value as int));
  }

  Future<int> confirmedBalance() {
    final query = _i1.PrismaFluent.queryBuilder(
      query: (fields) => $query([
        _i2.GraphQLField(
          r'confirmedBalance',
          fields: fields,
        )
      ]),
      key: r'confirmedBalance',
    );
    return query(const []).then((value) => (value as int));
  }

  Future<int> unconfirmedBalance() {
    final query = _i1.PrismaFluent.queryBuilder(
      query: (fields) => $query([
        _i2.GraphQLField(
          r'unconfirmedBalance',
          fields: fields,
        )
      ]),
      key: r'unconfirmedBalance',
    );
    return query(const []).then((value) => (value as int));
  }

  Future<int> utxoHistory() {
    final query = _i1.PrismaFluent.queryBuilder(
      query: (fields) => $query([
        _i2.GraphQLField(
          r'utxoHistory',
          fields: fields,
        )
      ]),
      key: r'utxoHistory',
    );
    return query(const []).then((value) => (value as int));
  }

  Future<int> needsUpdating() {
    final query = _i1.PrismaFluent.queryBuilder(
      query: (fields) => $query([
        _i2.GraphQLField(
          r'needsUpdating',
          fields: fields,
        )
      ]),
      key: r'needsUpdating',
    );
    return query(const []).then((value) => (value as int));
  }

  Future<int> $all() {
    final query = _i1.PrismaFluent.queryBuilder(
      query: (fields) => $query([
        _i2.GraphQLField(
          r'_all',
          fields: fields,
        )
      ]),
      key: r'_all',
    );
    return query(const []).then((value) => (value as int));
  }
}

class PrismaAddressAvgAggregateOutputType {
  const PrismaAddressAvgAggregateOutputType(this.$query);

  final _i1.PrismaFluentQuery $query;

  Future<double?> confirmedBalance() {
    final query = _i1.PrismaFluent.queryBuilder(
      query: (fields) => $query([
        _i2.GraphQLField(
          r'confirmedBalance',
          fields: fields,
        )
      ]),
      key: r'confirmedBalance',
    );
    return query(const []).then((value) => (value as double?));
  }

  Future<double?> unconfirmedBalance() {
    final query = _i1.PrismaFluent.queryBuilder(
      query: (fields) => $query([
        _i2.GraphQLField(
          r'unconfirmedBalance',
          fields: fields,
        )
      ]),
      key: r'unconfirmedBalance',
    );
    return query(const []).then((value) => (value as double?));
  }
}

class PrismaAddressSumAggregateOutputType {
  const PrismaAddressSumAggregateOutputType(this.$query);

  final _i1.PrismaFluentQuery $query;

  Future<int?> confirmedBalance() {
    final query = _i1.PrismaFluent.queryBuilder(
      query: (fields) => $query([
        _i2.GraphQLField(
          r'confirmedBalance',
          fields: fields,
        )
      ]),
      key: r'confirmedBalance',
    );
    return query(const []).then((value) => (value as int?));
  }

  Future<int?> unconfirmedBalance() {
    final query = _i1.PrismaFluent.queryBuilder(
      query: (fields) => $query([
        _i2.GraphQLField(
          r'unconfirmedBalance',
          fields: fields,
        )
      ]),
      key: r'unconfirmedBalance',
    );
    return query(const []).then((value) => (value as int?));
  }
}

class PrismaAddressMinAggregateOutputType {
  const PrismaAddressMinAggregateOutputType(this.$query);

  final _i1.PrismaFluentQuery $query;

  Future<String?> address() {
    final query = _i1.PrismaFluent.queryBuilder(
      query: (fields) => $query([
        _i2.GraphQLField(
          r'address',
          fields: fields,
        )
      ]),
      key: r'address',
    );
    return query(const []).then((value) => (value as String?));
  }

  Future<String?> status() {
    final query = _i1.PrismaFluent.queryBuilder(
      query: (fields) => $query([
        _i2.GraphQLField(
          r'status',
          fields: fields,
        )
      ]),
      key: r'status',
    );
    return query(const []).then((value) => (value as String?));
  }

  Future<int?> confirmedBalance() {
    final query = _i1.PrismaFluent.queryBuilder(
      query: (fields) => $query([
        _i2.GraphQLField(
          r'confirmedBalance',
          fields: fields,
        )
      ]),
      key: r'confirmedBalance',
    );
    return query(const []).then((value) => (value as int?));
  }

  Future<int?> unconfirmedBalance() {
    final query = _i1.PrismaFluent.queryBuilder(
      query: (fields) => $query([
        _i2.GraphQLField(
          r'unconfirmedBalance',
          fields: fields,
        )
      ]),
      key: r'unconfirmedBalance',
    );
    return query(const []).then((value) => (value as int?));
  }

  Future<bool?> needsUpdating() {
    final query = _i1.PrismaFluent.queryBuilder(
      query: (fields) => $query([
        _i2.GraphQLField(
          r'needsUpdating',
          fields: fields,
        )
      ]),
      key: r'needsUpdating',
    );
    return query(const []).then((value) => (value as bool?));
  }
}

class PrismaAddressMaxAggregateOutputType {
  const PrismaAddressMaxAggregateOutputType(this.$query);

  final _i1.PrismaFluentQuery $query;

  Future<String?> address() {
    final query = _i1.PrismaFluent.queryBuilder(
      query: (fields) => $query([
        _i2.GraphQLField(
          r'address',
          fields: fields,
        )
      ]),
      key: r'address',
    );
    return query(const []).then((value) => (value as String?));
  }

  Future<String?> status() {
    final query = _i1.PrismaFluent.queryBuilder(
      query: (fields) => $query([
        _i2.GraphQLField(
          r'status',
          fields: fields,
        )
      ]),
      key: r'status',
    );
    return query(const []).then((value) => (value as String?));
  }

  Future<int?> confirmedBalance() {
    final query = _i1.PrismaFluent.queryBuilder(
      query: (fields) => $query([
        _i2.GraphQLField(
          r'confirmedBalance',
          fields: fields,
        )
      ]),
      key: r'confirmedBalance',
    );
    return query(const []).then((value) => (value as int?));
  }

  Future<int?> unconfirmedBalance() {
    final query = _i1.PrismaFluent.queryBuilder(
      query: (fields) => $query([
        _i2.GraphQLField(
          r'unconfirmedBalance',
          fields: fields,
        )
      ]),
      key: r'unconfirmedBalance',
    );
    return query(const []).then((value) => (value as int?));
  }

  Future<bool?> needsUpdating() {
    final query = _i1.PrismaFluent.queryBuilder(
      query: (fields) => $query([
        _i2.GraphQLField(
          r'needsUpdating',
          fields: fields,
        )
      ]),
      key: r'needsUpdating',
    );
    return query(const []).then((value) => (value as bool?));
  }
}

class PrismaBlockCountAggregateOutputType {
  const PrismaBlockCountAggregateOutputType(this.$query);

  final _i1.PrismaFluentQuery $query;

  Future<int> id() {
    final query = _i1.PrismaFluent.queryBuilder(
      query: (fields) => $query([
        _i2.GraphQLField(
          r'id',
          fields: fields,
        )
      ]),
      key: r'id',
    );
    return query(const []).then((value) => (value as int));
  }

  Future<int> hash() {
    final query = _i1.PrismaFluent.queryBuilder(
      query: (fields) => $query([
        _i2.GraphQLField(
          r'hash',
          fields: fields,
        )
      ]),
      key: r'hash',
    );
    return query(const []).then((value) => (value as int));
  }

  Future<int> blocktime() {
    final query = _i1.PrismaFluent.queryBuilder(
      query: (fields) => $query([
        _i2.GraphQLField(
          r'blocktime',
          fields: fields,
        )
      ]),
      key: r'blocktime',
    );
    return query(const []).then((value) => (value as int));
  }

  Future<int> $all() {
    final query = _i1.PrismaFluent.queryBuilder(
      query: (fields) => $query([
        _i2.GraphQLField(
          r'_all',
          fields: fields,
        )
      ]),
      key: r'_all',
    );
    return query(const []).then((value) => (value as int));
  }
}

class PrismaBlockAvgAggregateOutputType {
  const PrismaBlockAvgAggregateOutputType(this.$query);

  final _i1.PrismaFluentQuery $query;

  Future<double?> id() {
    final query = _i1.PrismaFluent.queryBuilder(
      query: (fields) => $query([
        _i2.GraphQLField(
          r'id',
          fields: fields,
        )
      ]),
      key: r'id',
    );
    return query(const []).then((value) => (value as double?));
  }

  Future<double?> blocktime() {
    final query = _i1.PrismaFluent.queryBuilder(
      query: (fields) => $query([
        _i2.GraphQLField(
          r'blocktime',
          fields: fields,
        )
      ]),
      key: r'blocktime',
    );
    return query(const []).then((value) => (value as double?));
  }
}

class PrismaBlockSumAggregateOutputType {
  const PrismaBlockSumAggregateOutputType(this.$query);

  final _i1.PrismaFluentQuery $query;

  Future<int?> id() {
    final query = _i1.PrismaFluent.queryBuilder(
      query: (fields) => $query([
        _i2.GraphQLField(
          r'id',
          fields: fields,
        )
      ]),
      key: r'id',
    );
    return query(const []).then((value) => (value as int?));
  }

  Future<int?> blocktime() {
    final query = _i1.PrismaFluent.queryBuilder(
      query: (fields) => $query([
        _i2.GraphQLField(
          r'blocktime',
          fields: fields,
        )
      ]),
      key: r'blocktime',
    );
    return query(const []).then((value) => (value as int?));
  }
}

class PrismaBlockMinAggregateOutputType {
  const PrismaBlockMinAggregateOutputType(this.$query);

  final _i1.PrismaFluentQuery $query;

  Future<int?> id() {
    final query = _i1.PrismaFluent.queryBuilder(
      query: (fields) => $query([
        _i2.GraphQLField(
          r'id',
          fields: fields,
        )
      ]),
      key: r'id',
    );
    return query(const []).then((value) => (value as int?));
  }

  Future<String?> hash() {
    final query = _i1.PrismaFluent.queryBuilder(
      query: (fields) => $query([
        _i2.GraphQLField(
          r'hash',
          fields: fields,
        )
      ]),
      key: r'hash',
    );
    return query(const []).then((value) => (value as String?));
  }

  Future<int?> blocktime() {
    final query = _i1.PrismaFluent.queryBuilder(
      query: (fields) => $query([
        _i2.GraphQLField(
          r'blocktime',
          fields: fields,
        )
      ]),
      key: r'blocktime',
    );
    return query(const []).then((value) => (value as int?));
  }
}

class PrismaBlockMaxAggregateOutputType {
  const PrismaBlockMaxAggregateOutputType(this.$query);

  final _i1.PrismaFluentQuery $query;

  Future<int?> id() {
    final query = _i1.PrismaFluent.queryBuilder(
      query: (fields) => $query([
        _i2.GraphQLField(
          r'id',
          fields: fields,
        )
      ]),
      key: r'id',
    );
    return query(const []).then((value) => (value as int?));
  }

  Future<String?> hash() {
    final query = _i1.PrismaFluent.queryBuilder(
      query: (fields) => $query([
        _i2.GraphQLField(
          r'hash',
          fields: fields,
        )
      ]),
      key: r'hash',
    );
    return query(const []).then((value) => (value as String?));
  }

  Future<int?> blocktime() {
    final query = _i1.PrismaFluent.queryBuilder(
      query: (fields) => $query([
        _i2.GraphQLField(
          r'blocktime',
          fields: fields,
        )
      ]),
      key: r'blocktime',
    );
    return query(const []).then((value) => (value as int?));
  }
}

class PrismaUtxoCountAggregateOutputType {
  const PrismaUtxoCountAggregateOutputType(this.$query);

  final _i1.PrismaFluentQuery $query;

  Future<int> id() {
    final query = _i1.PrismaFluent.queryBuilder(
      query: (fields) => $query([
        _i2.GraphQLField(
          r'id',
          fields: fields,
        )
      ]),
      key: r'id',
    );
    return query(const []).then((value) => (value as int));
  }

  Future<int> txid() {
    final query = _i1.PrismaFluent.queryBuilder(
      query: (fields) => $query([
        _i2.GraphQLField(
          r'txid',
          fields: fields,
        )
      ]),
      key: r'txid',
    );
    return query(const []).then((value) => (value as int));
  }

  Future<int> txpos() {
    final query = _i1.PrismaFluent.queryBuilder(
      query: (fields) => $query([
        _i2.GraphQLField(
          r'txpos',
          fields: fields,
        )
      ]),
      key: r'txpos',
    );
    return query(const []).then((value) => (value as int));
  }

  Future<int> block() {
    final query = _i1.PrismaFluent.queryBuilder(
      query: (fields) => $query([
        _i2.GraphQLField(
          r'block',
          fields: fields,
        )
      ]),
      key: r'block',
    );
    return query(const []).then((value) => (value as int));
  }

  Future<int> value() {
    final query = _i1.PrismaFluent.queryBuilder(
      query: (fields) => $query([
        _i2.GraphQLField(
          r'value',
          fields: fields,
        )
      ]),
      key: r'value',
    );
    return query(const []).then((value) => (value as int));
  }

  Future<int> addresses() {
    final query = _i1.PrismaFluent.queryBuilder(
      query: (fields) => $query([
        _i2.GraphQLField(
          r'addresses',
          fields: fields,
        )
      ]),
      key: r'addresses',
    );
    return query(const []).then((value) => (value as int));
  }

  Future<int> flaggedForDelete() {
    final query = _i1.PrismaFluent.queryBuilder(
      query: (fields) => $query([
        _i2.GraphQLField(
          r'flaggedForDelete',
          fields: fields,
        )
      ]),
      key: r'flaggedForDelete',
    );
    return query(const []).then((value) => (value as int));
  }

  Future<int> $all() {
    final query = _i1.PrismaFluent.queryBuilder(
      query: (fields) => $query([
        _i2.GraphQLField(
          r'_all',
          fields: fields,
        )
      ]),
      key: r'_all',
    );
    return query(const []).then((value) => (value as int));
  }
}

class PrismaUtxoAvgAggregateOutputType {
  const PrismaUtxoAvgAggregateOutputType(this.$query);

  final _i1.PrismaFluentQuery $query;

  Future<double?> id() {
    final query = _i1.PrismaFluent.queryBuilder(
      query: (fields) => $query([
        _i2.GraphQLField(
          r'id',
          fields: fields,
        )
      ]),
      key: r'id',
    );
    return query(const []).then((value) => (value as double?));
  }

  Future<double?> txpos() {
    final query = _i1.PrismaFluent.queryBuilder(
      query: (fields) => $query([
        _i2.GraphQLField(
          r'txpos',
          fields: fields,
        )
      ]),
      key: r'txpos',
    );
    return query(const []).then((value) => (value as double?));
  }

  Future<double?> block() {
    final query = _i1.PrismaFluent.queryBuilder(
      query: (fields) => $query([
        _i2.GraphQLField(
          r'block',
          fields: fields,
        )
      ]),
      key: r'block',
    );
    return query(const []).then((value) => (value as double?));
  }

  Future<double?> value() {
    final query = _i1.PrismaFluent.queryBuilder(
      query: (fields) => $query([
        _i2.GraphQLField(
          r'value',
          fields: fields,
        )
      ]),
      key: r'value',
    );
    return query(const []).then((value) => (value as double?));
  }
}

class PrismaUtxoSumAggregateOutputType {
  const PrismaUtxoSumAggregateOutputType(this.$query);

  final _i1.PrismaFluentQuery $query;

  Future<int?> id() {
    final query = _i1.PrismaFluent.queryBuilder(
      query: (fields) => $query([
        _i2.GraphQLField(
          r'id',
          fields: fields,
        )
      ]),
      key: r'id',
    );
    return query(const []).then((value) => (value as int?));
  }

  Future<int?> txpos() {
    final query = _i1.PrismaFluent.queryBuilder(
      query: (fields) => $query([
        _i2.GraphQLField(
          r'txpos',
          fields: fields,
        )
      ]),
      key: r'txpos',
    );
    return query(const []).then((value) => (value as int?));
  }

  Future<int?> block() {
    final query = _i1.PrismaFluent.queryBuilder(
      query: (fields) => $query([
        _i2.GraphQLField(
          r'block',
          fields: fields,
        )
      ]),
      key: r'block',
    );
    return query(const []).then((value) => (value as int?));
  }

  Future<double?> value() {
    final query = _i1.PrismaFluent.queryBuilder(
      query: (fields) => $query([
        _i2.GraphQLField(
          r'value',
          fields: fields,
        )
      ]),
      key: r'value',
    );
    return query(const []).then((value) => (value as double?));
  }
}

class PrismaUtxoMinAggregateOutputType {
  const PrismaUtxoMinAggregateOutputType(this.$query);

  final _i1.PrismaFluentQuery $query;

  Future<int?> id() {
    final query = _i1.PrismaFluent.queryBuilder(
      query: (fields) => $query([
        _i2.GraphQLField(
          r'id',
          fields: fields,
        )
      ]),
      key: r'id',
    );
    return query(const []).then((value) => (value as int?));
  }

  Future<String?> txid() {
    final query = _i1.PrismaFluent.queryBuilder(
      query: (fields) => $query([
        _i2.GraphQLField(
          r'txid',
          fields: fields,
        )
      ]),
      key: r'txid',
    );
    return query(const []).then((value) => (value as String?));
  }

  Future<int?> txpos() {
    final query = _i1.PrismaFluent.queryBuilder(
      query: (fields) => $query([
        _i2.GraphQLField(
          r'txpos',
          fields: fields,
        )
      ]),
      key: r'txpos',
    );
    return query(const []).then((value) => (value as int?));
  }

  Future<int?> block() {
    final query = _i1.PrismaFluent.queryBuilder(
      query: (fields) => $query([
        _i2.GraphQLField(
          r'block',
          fields: fields,
        )
      ]),
      key: r'block',
    );
    return query(const []).then((value) => (value as int?));
  }

  Future<double?> value() {
    final query = _i1.PrismaFluent.queryBuilder(
      query: (fields) => $query([
        _i2.GraphQLField(
          r'value',
          fields: fields,
        )
      ]),
      key: r'value',
    );
    return query(const []).then((value) => (value as double?));
  }

  Future<bool?> flaggedForDelete() {
    final query = _i1.PrismaFluent.queryBuilder(
      query: (fields) => $query([
        _i2.GraphQLField(
          r'flaggedForDelete',
          fields: fields,
        )
      ]),
      key: r'flaggedForDelete',
    );
    return query(const []).then((value) => (value as bool?));
  }
}

class PrismaUtxoMaxAggregateOutputType {
  const PrismaUtxoMaxAggregateOutputType(this.$query);

  final _i1.PrismaFluentQuery $query;

  Future<int?> id() {
    final query = _i1.PrismaFluent.queryBuilder(
      query: (fields) => $query([
        _i2.GraphQLField(
          r'id',
          fields: fields,
        )
      ]),
      key: r'id',
    );
    return query(const []).then((value) => (value as int?));
  }

  Future<String?> txid() {
    final query = _i1.PrismaFluent.queryBuilder(
      query: (fields) => $query([
        _i2.GraphQLField(
          r'txid',
          fields: fields,
        )
      ]),
      key: r'txid',
    );
    return query(const []).then((value) => (value as String?));
  }

  Future<int?> txpos() {
    final query = _i1.PrismaFluent.queryBuilder(
      query: (fields) => $query([
        _i2.GraphQLField(
          r'txpos',
          fields: fields,
        )
      ]),
      key: r'txpos',
    );
    return query(const []).then((value) => (value as int?));
  }

  Future<int?> block() {
    final query = _i1.PrismaFluent.queryBuilder(
      query: (fields) => $query([
        _i2.GraphQLField(
          r'block',
          fields: fields,
        )
      ]),
      key: r'block',
    );
    return query(const []).then((value) => (value as int?));
  }

  Future<double?> value() {
    final query = _i1.PrismaFluent.queryBuilder(
      query: (fields) => $query([
        _i2.GraphQLField(
          r'value',
          fields: fields,
        )
      ]),
      key: r'value',
    );
    return query(const []).then((value) => (value as double?));
  }

  Future<bool?> flaggedForDelete() {
    final query = _i1.PrismaFluent.queryBuilder(
      query: (fields) => $query([
        _i2.GraphQLField(
          r'flaggedForDelete',
          fields: fields,
        )
      ]),
      key: r'flaggedForDelete',
    );
    return query(const []).then((value) => (value as bool?));
  }
}

@JsonSerializable(
  createFactory: false,
  createToJson: true,
  includeIfNull: false,
)
class Datasources implements _i1.JsonSerializable {
  const Datasources({this.db});

  final String? db;

  @override
  Map<String, dynamic> toJson() => _$DatasourcesToJson(this);
}

class PrismaClient extends _i1.BasePrismaClient<PrismaClient> {
  PrismaClient._internal(
    _i3.Engine engine, {
    _i3.QueryEngineRequestHeaders? headers,
    _i3.TransactionInfo? transaction,
  })  : _engine = engine,
        _headers = headers,
        _transaction = transaction,
        super(
          engine,
          headers: headers,
          transaction: transaction,
        );

  factory PrismaClient({
    Datasources? datasources,
    Iterable<_i4.Event>? stdout,
    Iterable<_i4.Event>? event,
  }) {
    final logger = _i4.Logger(
      stdout: stdout,
      event: event,
    );
    final engine = _i5.BinaryEngine(
      logger: logger,
      schema:
          r'Ly8gVGhpcyBpcyB5b3VyIFByaXNtYSBzY2hlbWEgZmlsZSwKLy8gbGVhcm4gbW9yZSBhYm91dCBpdCBpbiB0aGUgZG9jczogaHR0cHM6Ly9wcmlzLmx5L2QvcHJpc21hLXNjaGVtYQoKZ2VuZXJhdG9yIGNsaWVudCB7CiAgcHJvdmlkZXIgPSAiZGFydCBydW4gb3JtIgp9CgpkYXRhc291cmNlIGRiIHsKICBwcm92aWRlciA9ICJwb3N0Z3Jlc3FsIgogIHVybCAgICAgID0gZW52KCJEQVRBQkFTRV9VUkwiKQp9Cgptb2RlbCBQcmlzbWFBZGRyZXNzIHsKICBhZGRyZXNzIFN0cmluZyBAaWQgQHVuaXF1ZQogIHN0YXR1cyBTdHJpbmcKICBjb25maXJtZWRCYWxhbmNlIEludAogIHVuY29uZmlybWVkQmFsYW5jZSBJbnQKICB1dHhvSGlzdG9yeSBTdHJpbmdbXQogIG5lZWRzVXBkYXRpbmcgQm9vbGVhbgp9Cgptb2RlbCBQcmlzbWFCbG9jayB7CiAgaWQgSW50IEBpZCBAdW5pcXVlCiAgaGFzaCBTdHJpbmcKICBibG9ja3RpbWUgSW50Cn0KCm1vZGVsIFByaXNtYVV0eG8gewogIGlkIEludCBAaWQgQGRlZmF1bHQoYXV0b2luY3JlbWVudCgpKQogIHR4aWQgU3RyaW5nCiAgdHhwb3MgSW50CiAgYmxvY2sgSW50CiAgdmFsdWUgRmxvYXQKICBhZGRyZXNzZXMgU3RyaW5nW10KICBmbGFnZ2VkRm9yRGVsZXRlIEJvb2xlYW4KfQ==',
      datasources: datasources?.toJson().cast() ?? const {},
      executable:
          r'/Users/robert/node_modules/prisma/query-engine-darwin-arm64',
    );
    return PrismaClient._internal(engine);
  }

  final _i3.Engine _engine;

  final _i3.QueryEngineRequestHeaders? _headers;

  final _i3.TransactionInfo? _transaction;

  @override
  PrismaClient copyWith({
    _i3.QueryEngineRequestHeaders? headers,
    _i3.TransactionInfo? transaction,
  }) =>
      PrismaClient._internal(
        _engine,
        headers: headers ?? _headers,
        transaction: transaction ?? _transaction,
      );
  _i1.ModelDelegate<PrismaAddress> get prismaAddress =>
      _i1.ModelDelegate<PrismaAddress>(
        _engine,
        headers: _headers,
        transaction: _transaction,
      );
  _i1.ModelDelegate<PrismaBlock> get prismaBlock =>
      _i1.ModelDelegate<PrismaBlock>(
        _engine,
        headers: _headers,
        transaction: _transaction,
      );
  _i1.ModelDelegate<PrismaUtxo> get prismaUtxo => _i1.ModelDelegate<PrismaUtxo>(
        _engine,
        headers: _headers,
        transaction: _transaction,
      );
}
