// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'utxo.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters

extension GetUtxoCollection on Isar {
  IsarCollection<Utxo> get utxos => this.collection();
}

const UtxoSchema = CollectionSchema(
  name: r'Utxo',
  id: -3408295405398731572,
  properties: {
    r'addresses': PropertySchema(
      id: 0,
      name: r'addresses',
      type: IsarType.stringList,
    ),
    r'block': PropertySchema(
      id: 1,
      name: r'block',
      type: IsarType.long,
    ),
    r'flaggedForDelete': PropertySchema(
      id: 2,
      name: r'flaggedForDelete',
      type: IsarType.bool,
    ),
    r'txid': PropertySchema(
      id: 3,
      name: r'txid',
      type: IsarType.string,
    ),
    r'txpos': PropertySchema(
      id: 4,
      name: r'txpos',
      type: IsarType.long,
    ),
    r'value': PropertySchema(
      id: 5,
      name: r'value',
      type: IsarType.double,
    )
  },
  estimateSize: _utxoEstimateSize,
  serialize: _utxoSerialize,
  deserialize: _utxoDeserialize,
  deserializeProp: _utxoDeserializeProp,
  idName: r'id',
  indexes: {
    r'txid_txpos': IndexSchema(
      id: 1789810434980396397,
      name: r'txid_txpos',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'txid',
          type: IndexType.hash,
          caseSensitive: true,
        ),
        IndexPropertySchema(
          name: r'txpos',
          type: IndexType.value,
          caseSensitive: false,
        )
      ],
    )
  },
  links: {},
  embeddedSchemas: {},
  getId: _utxoGetId,
  getLinks: _utxoGetLinks,
  attach: _utxoAttach,
  version: '3.0.6-dev.0',
);

int _utxoEstimateSize(
  Utxo object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.addresses.length * 3;
  {
    for (var i = 0; i < object.addresses.length; i++) {
      final value = object.addresses[i];
      bytesCount += value.length * 3;
    }
  }
  bytesCount += 3 + object.txid.length * 3;
  return bytesCount;
}

void _utxoSerialize(
  Utxo object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeStringList(offsets[0], object.addresses);
  writer.writeLong(offsets[1], object.block);
  writer.writeBool(offsets[2], object.flaggedForDelete);
  writer.writeString(offsets[3], object.txid);
  writer.writeLong(offsets[4], object.txpos);
  writer.writeDouble(offsets[5], object.value);
}

Utxo _utxoDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = Utxo(
    addresses: reader.readStringList(offsets[0]) ?? [],
    block: reader.readLong(offsets[1]),
    txid: reader.readString(offsets[3]),
    txpos: reader.readLong(offsets[4]),
    value: reader.readDouble(offsets[5]),
  );
  object.flaggedForDelete = reader.readBool(offsets[2]);
  object.id = id;
  return object;
}

P _utxoDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readStringList(offset) ?? []) as P;
    case 1:
      return (reader.readLong(offset)) as P;
    case 2:
      return (reader.readBool(offset)) as P;
    case 3:
      return (reader.readString(offset)) as P;
    case 4:
      return (reader.readLong(offset)) as P;
    case 5:
      return (reader.readDouble(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _utxoGetId(Utxo object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _utxoGetLinks(Utxo object) {
  return [];
}

void _utxoAttach(IsarCollection<dynamic> col, Id id, Utxo object) {
  object.id = id;
}

extension UtxoQueryWhereSort on QueryBuilder<Utxo, Utxo, QWhere> {
  QueryBuilder<Utxo, Utxo, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension UtxoQueryWhere on QueryBuilder<Utxo, Utxo, QWhereClause> {
  QueryBuilder<Utxo, Utxo, QAfterWhereClause> idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<Utxo, Utxo, QAfterWhereClause> idNotEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            )
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            );
      } else {
        return query
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            )
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            );
      }
    });
  }

  QueryBuilder<Utxo, Utxo, QAfterWhereClause> idGreaterThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<Utxo, Utxo, QAfterWhereClause> idLessThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<Utxo, Utxo, QAfterWhereClause> idBetween(
    Id lowerId,
    Id upperId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: lowerId,
        includeLower: includeLower,
        upper: upperId,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Utxo, Utxo, QAfterWhereClause> txidEqualToAnyTxpos(String txid) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'txid_txpos',
        value: [txid],
      ));
    });
  }

  QueryBuilder<Utxo, Utxo, QAfterWhereClause> txidNotEqualToAnyTxpos(
      String txid) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'txid_txpos',
              lower: [],
              upper: [txid],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'txid_txpos',
              lower: [txid],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'txid_txpos',
              lower: [txid],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'txid_txpos',
              lower: [],
              upper: [txid],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<Utxo, Utxo, QAfterWhereClause> txidTxposEqualTo(
      String txid, int txpos) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'txid_txpos',
        value: [txid, txpos],
      ));
    });
  }

  QueryBuilder<Utxo, Utxo, QAfterWhereClause> txidEqualToTxposNotEqualTo(
      String txid, int txpos) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'txid_txpos',
              lower: [txid],
              upper: [txid, txpos],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'txid_txpos',
              lower: [txid, txpos],
              includeLower: false,
              upper: [txid],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'txid_txpos',
              lower: [txid, txpos],
              includeLower: false,
              upper: [txid],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'txid_txpos',
              lower: [txid],
              upper: [txid, txpos],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<Utxo, Utxo, QAfterWhereClause> txidEqualToTxposGreaterThan(
    String txid,
    int txpos, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'txid_txpos',
        lower: [txid, txpos],
        includeLower: include,
        upper: [txid],
      ));
    });
  }

  QueryBuilder<Utxo, Utxo, QAfterWhereClause> txidEqualToTxposLessThan(
    String txid,
    int txpos, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'txid_txpos',
        lower: [txid],
        upper: [txid, txpos],
        includeUpper: include,
      ));
    });
  }

  QueryBuilder<Utxo, Utxo, QAfterWhereClause> txidEqualToTxposBetween(
    String txid,
    int lowerTxpos,
    int upperTxpos, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'txid_txpos',
        lower: [txid, lowerTxpos],
        includeLower: includeLower,
        upper: [txid, upperTxpos],
        includeUpper: includeUpper,
      ));
    });
  }
}

extension UtxoQueryFilter on QueryBuilder<Utxo, Utxo, QFilterCondition> {
  QueryBuilder<Utxo, Utxo, QAfterFilterCondition> addressesElementEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'addresses',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Utxo, Utxo, QAfterFilterCondition> addressesElementGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'addresses',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Utxo, Utxo, QAfterFilterCondition> addressesElementLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'addresses',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Utxo, Utxo, QAfterFilterCondition> addressesElementBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'addresses',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Utxo, Utxo, QAfterFilterCondition> addressesElementStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'addresses',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Utxo, Utxo, QAfterFilterCondition> addressesElementEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'addresses',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Utxo, Utxo, QAfterFilterCondition> addressesElementContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'addresses',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Utxo, Utxo, QAfterFilterCondition> addressesElementMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'addresses',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Utxo, Utxo, QAfterFilterCondition> addressesElementIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'addresses',
        value: '',
      ));
    });
  }

  QueryBuilder<Utxo, Utxo, QAfterFilterCondition> addressesElementIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'addresses',
        value: '',
      ));
    });
  }

  QueryBuilder<Utxo, Utxo, QAfterFilterCondition> addressesLengthEqualTo(
      int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'addresses',
        length,
        true,
        length,
        true,
      );
    });
  }

  QueryBuilder<Utxo, Utxo, QAfterFilterCondition> addressesIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'addresses',
        0,
        true,
        0,
        true,
      );
    });
  }

  QueryBuilder<Utxo, Utxo, QAfterFilterCondition> addressesIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'addresses',
        0,
        false,
        999999,
        true,
      );
    });
  }

  QueryBuilder<Utxo, Utxo, QAfterFilterCondition> addressesLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'addresses',
        0,
        true,
        length,
        include,
      );
    });
  }

  QueryBuilder<Utxo, Utxo, QAfterFilterCondition> addressesLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'addresses',
        length,
        include,
        999999,
        true,
      );
    });
  }

  QueryBuilder<Utxo, Utxo, QAfterFilterCondition> addressesLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'addresses',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }

  QueryBuilder<Utxo, Utxo, QAfterFilterCondition> blockEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'block',
        value: value,
      ));
    });
  }

  QueryBuilder<Utxo, Utxo, QAfterFilterCondition> blockGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'block',
        value: value,
      ));
    });
  }

  QueryBuilder<Utxo, Utxo, QAfterFilterCondition> blockLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'block',
        value: value,
      ));
    });
  }

  QueryBuilder<Utxo, Utxo, QAfterFilterCondition> blockBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'block',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Utxo, Utxo, QAfterFilterCondition> flaggedForDeleteEqualTo(
      bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'flaggedForDelete',
        value: value,
      ));
    });
  }

  QueryBuilder<Utxo, Utxo, QAfterFilterCondition> idEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<Utxo, Utxo, QAfterFilterCondition> idGreaterThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<Utxo, Utxo, QAfterFilterCondition> idLessThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<Utxo, Utxo, QAfterFilterCondition> idBetween(
    Id lower,
    Id upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'id',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Utxo, Utxo, QAfterFilterCondition> txidEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'txid',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Utxo, Utxo, QAfterFilterCondition> txidGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'txid',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Utxo, Utxo, QAfterFilterCondition> txidLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'txid',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Utxo, Utxo, QAfterFilterCondition> txidBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'txid',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Utxo, Utxo, QAfterFilterCondition> txidStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'txid',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Utxo, Utxo, QAfterFilterCondition> txidEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'txid',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Utxo, Utxo, QAfterFilterCondition> txidContains(String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'txid',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Utxo, Utxo, QAfterFilterCondition> txidMatches(String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'txid',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Utxo, Utxo, QAfterFilterCondition> txidIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'txid',
        value: '',
      ));
    });
  }

  QueryBuilder<Utxo, Utxo, QAfterFilterCondition> txidIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'txid',
        value: '',
      ));
    });
  }

  QueryBuilder<Utxo, Utxo, QAfterFilterCondition> txposEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'txpos',
        value: value,
      ));
    });
  }

  QueryBuilder<Utxo, Utxo, QAfterFilterCondition> txposGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'txpos',
        value: value,
      ));
    });
  }

  QueryBuilder<Utxo, Utxo, QAfterFilterCondition> txposLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'txpos',
        value: value,
      ));
    });
  }

  QueryBuilder<Utxo, Utxo, QAfterFilterCondition> txposBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'txpos',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Utxo, Utxo, QAfterFilterCondition> valueEqualTo(
    double value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'value',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<Utxo, Utxo, QAfterFilterCondition> valueGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'value',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<Utxo, Utxo, QAfterFilterCondition> valueLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'value',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<Utxo, Utxo, QAfterFilterCondition> valueBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'value',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }
}

extension UtxoQueryObject on QueryBuilder<Utxo, Utxo, QFilterCondition> {}

extension UtxoQueryLinks on QueryBuilder<Utxo, Utxo, QFilterCondition> {}

extension UtxoQuerySortBy on QueryBuilder<Utxo, Utxo, QSortBy> {
  QueryBuilder<Utxo, Utxo, QAfterSortBy> sortByBlock() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'block', Sort.asc);
    });
  }

  QueryBuilder<Utxo, Utxo, QAfterSortBy> sortByBlockDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'block', Sort.desc);
    });
  }

  QueryBuilder<Utxo, Utxo, QAfterSortBy> sortByFlaggedForDelete() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'flaggedForDelete', Sort.asc);
    });
  }

  QueryBuilder<Utxo, Utxo, QAfterSortBy> sortByFlaggedForDeleteDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'flaggedForDelete', Sort.desc);
    });
  }

  QueryBuilder<Utxo, Utxo, QAfterSortBy> sortByTxid() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'txid', Sort.asc);
    });
  }

  QueryBuilder<Utxo, Utxo, QAfterSortBy> sortByTxidDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'txid', Sort.desc);
    });
  }

  QueryBuilder<Utxo, Utxo, QAfterSortBy> sortByTxpos() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'txpos', Sort.asc);
    });
  }

  QueryBuilder<Utxo, Utxo, QAfterSortBy> sortByTxposDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'txpos', Sort.desc);
    });
  }

  QueryBuilder<Utxo, Utxo, QAfterSortBy> sortByValue() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'value', Sort.asc);
    });
  }

  QueryBuilder<Utxo, Utxo, QAfterSortBy> sortByValueDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'value', Sort.desc);
    });
  }
}

extension UtxoQuerySortThenBy on QueryBuilder<Utxo, Utxo, QSortThenBy> {
  QueryBuilder<Utxo, Utxo, QAfterSortBy> thenByBlock() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'block', Sort.asc);
    });
  }

  QueryBuilder<Utxo, Utxo, QAfterSortBy> thenByBlockDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'block', Sort.desc);
    });
  }

  QueryBuilder<Utxo, Utxo, QAfterSortBy> thenByFlaggedForDelete() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'flaggedForDelete', Sort.asc);
    });
  }

  QueryBuilder<Utxo, Utxo, QAfterSortBy> thenByFlaggedForDeleteDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'flaggedForDelete', Sort.desc);
    });
  }

  QueryBuilder<Utxo, Utxo, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<Utxo, Utxo, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<Utxo, Utxo, QAfterSortBy> thenByTxid() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'txid', Sort.asc);
    });
  }

  QueryBuilder<Utxo, Utxo, QAfterSortBy> thenByTxidDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'txid', Sort.desc);
    });
  }

  QueryBuilder<Utxo, Utxo, QAfterSortBy> thenByTxpos() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'txpos', Sort.asc);
    });
  }

  QueryBuilder<Utxo, Utxo, QAfterSortBy> thenByTxposDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'txpos', Sort.desc);
    });
  }

  QueryBuilder<Utxo, Utxo, QAfterSortBy> thenByValue() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'value', Sort.asc);
    });
  }

  QueryBuilder<Utxo, Utxo, QAfterSortBy> thenByValueDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'value', Sort.desc);
    });
  }
}

extension UtxoQueryWhereDistinct on QueryBuilder<Utxo, Utxo, QDistinct> {
  QueryBuilder<Utxo, Utxo, QDistinct> distinctByAddresses() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'addresses');
    });
  }

  QueryBuilder<Utxo, Utxo, QDistinct> distinctByBlock() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'block');
    });
  }

  QueryBuilder<Utxo, Utxo, QDistinct> distinctByFlaggedForDelete() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'flaggedForDelete');
    });
  }

  QueryBuilder<Utxo, Utxo, QDistinct> distinctByTxid(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'txid', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Utxo, Utxo, QDistinct> distinctByTxpos() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'txpos');
    });
  }

  QueryBuilder<Utxo, Utxo, QDistinct> distinctByValue() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'value');
    });
  }
}

extension UtxoQueryProperty on QueryBuilder<Utxo, Utxo, QQueryProperty> {
  QueryBuilder<Utxo, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<Utxo, List<String>, QQueryOperations> addressesProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'addresses');
    });
  }

  QueryBuilder<Utxo, int, QQueryOperations> blockProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'block');
    });
  }

  QueryBuilder<Utxo, bool, QQueryOperations> flaggedForDeleteProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'flaggedForDelete');
    });
  }

  QueryBuilder<Utxo, String, QQueryOperations> txidProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'txid');
    });
  }

  QueryBuilder<Utxo, int, QQueryOperations> txposProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'txpos');
    });
  }

  QueryBuilder<Utxo, double, QQueryOperations> valueProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'value');
    });
  }
}
