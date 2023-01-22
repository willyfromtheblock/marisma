// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tx.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters

extension GetTxCollection on Isar {
  IsarCollection<Tx> get txs => this.collection();
}

const TxSchema = CollectionSchema(
  name: r'Tx',
  id: 4184853192607142548,
  properties: {
    r'block': PropertySchema(
      id: 0,
      name: r'block',
      type: IsarType.long,
    ),
    r'rawTx': PropertySchema(
      id: 1,
      name: r'rawTx',
      type: IsarType.string,
    ),
    r'txid': PropertySchema(
      id: 2,
      name: r'txid',
      type: IsarType.string,
    )
  },
  estimateSize: _txEstimateSize,
  serialize: _txSerialize,
  deserialize: _txDeserialize,
  deserializeProp: _txDeserializeProp,
  idName: r'id',
  indexes: {
    r'txid': IndexSchema(
      id: 7339874292043634331,
      name: r'txid',
      unique: true,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'txid',
          type: IndexType.hash,
          caseSensitive: true,
        )
      ],
    )
  },
  links: {},
  embeddedSchemas: {},
  getId: _txGetId,
  getLinks: _txGetLinks,
  attach: _txAttach,
  version: '3.0.5',
);

int _txEstimateSize(
  Tx object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.rawTx.length * 3;
  bytesCount += 3 + object.txid.length * 3;
  return bytesCount;
}

void _txSerialize(
  Tx object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeLong(offsets[0], object.block);
  writer.writeString(offsets[1], object.rawTx);
  writer.writeString(offsets[2], object.txid);
}

Tx _txDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = Tx(
    block: reader.readLong(offsets[0]),
    rawTx: reader.readString(offsets[1]),
    txid: reader.readString(offsets[2]),
  );
  object.id = id;
  return object;
}

P _txDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readLong(offset)) as P;
    case 1:
      return (reader.readString(offset)) as P;
    case 2:
      return (reader.readString(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _txGetId(Tx object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _txGetLinks(Tx object) {
  return [];
}

void _txAttach(IsarCollection<dynamic> col, Id id, Tx object) {
  object.id = id;
}

extension TxByIndex on IsarCollection<Tx> {
  Future<Tx?> getByTxid(String txid) {
    return getByIndex(r'txid', [txid]);
  }

  Tx? getByTxidSync(String txid) {
    return getByIndexSync(r'txid', [txid]);
  }

  Future<bool> deleteByTxid(String txid) {
    return deleteByIndex(r'txid', [txid]);
  }

  bool deleteByTxidSync(String txid) {
    return deleteByIndexSync(r'txid', [txid]);
  }

  Future<List<Tx?>> getAllByTxid(List<String> txidValues) {
    final values = txidValues.map((e) => [e]).toList();
    return getAllByIndex(r'txid', values);
  }

  List<Tx?> getAllByTxidSync(List<String> txidValues) {
    final values = txidValues.map((e) => [e]).toList();
    return getAllByIndexSync(r'txid', values);
  }

  Future<int> deleteAllByTxid(List<String> txidValues) {
    final values = txidValues.map((e) => [e]).toList();
    return deleteAllByIndex(r'txid', values);
  }

  int deleteAllByTxidSync(List<String> txidValues) {
    final values = txidValues.map((e) => [e]).toList();
    return deleteAllByIndexSync(r'txid', values);
  }

  Future<Id> putByTxid(Tx object) {
    return putByIndex(r'txid', object);
  }

  Id putByTxidSync(Tx object, {bool saveLinks = true}) {
    return putByIndexSync(r'txid', object, saveLinks: saveLinks);
  }

  Future<List<Id>> putAllByTxid(List<Tx> objects) {
    return putAllByIndex(r'txid', objects);
  }

  List<Id> putAllByTxidSync(List<Tx> objects, {bool saveLinks = true}) {
    return putAllByIndexSync(r'txid', objects, saveLinks: saveLinks);
  }
}

extension TxQueryWhereSort on QueryBuilder<Tx, Tx, QWhere> {
  QueryBuilder<Tx, Tx, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension TxQueryWhere on QueryBuilder<Tx, Tx, QWhereClause> {
  QueryBuilder<Tx, Tx, QAfterWhereClause> idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<Tx, Tx, QAfterWhereClause> idNotEqualTo(Id id) {
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

  QueryBuilder<Tx, Tx, QAfterWhereClause> idGreaterThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<Tx, Tx, QAfterWhereClause> idLessThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<Tx, Tx, QAfterWhereClause> idBetween(
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

  QueryBuilder<Tx, Tx, QAfterWhereClause> txidEqualTo(String txid) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'txid',
        value: [txid],
      ));
    });
  }

  QueryBuilder<Tx, Tx, QAfterWhereClause> txidNotEqualTo(String txid) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'txid',
              lower: [],
              upper: [txid],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'txid',
              lower: [txid],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'txid',
              lower: [txid],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'txid',
              lower: [],
              upper: [txid],
              includeUpper: false,
            ));
      }
    });
  }
}

extension TxQueryFilter on QueryBuilder<Tx, Tx, QFilterCondition> {
  QueryBuilder<Tx, Tx, QAfterFilterCondition> blockEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'block',
        value: value,
      ));
    });
  }

  QueryBuilder<Tx, Tx, QAfterFilterCondition> blockGreaterThan(
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

  QueryBuilder<Tx, Tx, QAfterFilterCondition> blockLessThan(
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

  QueryBuilder<Tx, Tx, QAfterFilterCondition> blockBetween(
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

  QueryBuilder<Tx, Tx, QAfterFilterCondition> idEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<Tx, Tx, QAfterFilterCondition> idGreaterThan(
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

  QueryBuilder<Tx, Tx, QAfterFilterCondition> idLessThan(
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

  QueryBuilder<Tx, Tx, QAfterFilterCondition> idBetween(
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

  QueryBuilder<Tx, Tx, QAfterFilterCondition> rawTxEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'rawTx',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Tx, Tx, QAfterFilterCondition> rawTxGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'rawTx',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Tx, Tx, QAfterFilterCondition> rawTxLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'rawTx',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Tx, Tx, QAfterFilterCondition> rawTxBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'rawTx',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Tx, Tx, QAfterFilterCondition> rawTxStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'rawTx',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Tx, Tx, QAfterFilterCondition> rawTxEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'rawTx',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Tx, Tx, QAfterFilterCondition> rawTxContains(String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'rawTx',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Tx, Tx, QAfterFilterCondition> rawTxMatches(String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'rawTx',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Tx, Tx, QAfterFilterCondition> rawTxIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'rawTx',
        value: '',
      ));
    });
  }

  QueryBuilder<Tx, Tx, QAfterFilterCondition> rawTxIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'rawTx',
        value: '',
      ));
    });
  }

  QueryBuilder<Tx, Tx, QAfterFilterCondition> txidEqualTo(
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

  QueryBuilder<Tx, Tx, QAfterFilterCondition> txidGreaterThan(
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

  QueryBuilder<Tx, Tx, QAfterFilterCondition> txidLessThan(
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

  QueryBuilder<Tx, Tx, QAfterFilterCondition> txidBetween(
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

  QueryBuilder<Tx, Tx, QAfterFilterCondition> txidStartsWith(
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

  QueryBuilder<Tx, Tx, QAfterFilterCondition> txidEndsWith(
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

  QueryBuilder<Tx, Tx, QAfterFilterCondition> txidContains(String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'txid',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Tx, Tx, QAfterFilterCondition> txidMatches(String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'txid',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Tx, Tx, QAfterFilterCondition> txidIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'txid',
        value: '',
      ));
    });
  }

  QueryBuilder<Tx, Tx, QAfterFilterCondition> txidIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'txid',
        value: '',
      ));
    });
  }
}

extension TxQueryObject on QueryBuilder<Tx, Tx, QFilterCondition> {}

extension TxQueryLinks on QueryBuilder<Tx, Tx, QFilterCondition> {}

extension TxQuerySortBy on QueryBuilder<Tx, Tx, QSortBy> {
  QueryBuilder<Tx, Tx, QAfterSortBy> sortByBlock() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'block', Sort.asc);
    });
  }

  QueryBuilder<Tx, Tx, QAfterSortBy> sortByBlockDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'block', Sort.desc);
    });
  }

  QueryBuilder<Tx, Tx, QAfterSortBy> sortByRawTx() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'rawTx', Sort.asc);
    });
  }

  QueryBuilder<Tx, Tx, QAfterSortBy> sortByRawTxDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'rawTx', Sort.desc);
    });
  }

  QueryBuilder<Tx, Tx, QAfterSortBy> sortByTxid() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'txid', Sort.asc);
    });
  }

  QueryBuilder<Tx, Tx, QAfterSortBy> sortByTxidDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'txid', Sort.desc);
    });
  }
}

extension TxQuerySortThenBy on QueryBuilder<Tx, Tx, QSortThenBy> {
  QueryBuilder<Tx, Tx, QAfterSortBy> thenByBlock() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'block', Sort.asc);
    });
  }

  QueryBuilder<Tx, Tx, QAfterSortBy> thenByBlockDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'block', Sort.desc);
    });
  }

  QueryBuilder<Tx, Tx, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<Tx, Tx, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<Tx, Tx, QAfterSortBy> thenByRawTx() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'rawTx', Sort.asc);
    });
  }

  QueryBuilder<Tx, Tx, QAfterSortBy> thenByRawTxDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'rawTx', Sort.desc);
    });
  }

  QueryBuilder<Tx, Tx, QAfterSortBy> thenByTxid() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'txid', Sort.asc);
    });
  }

  QueryBuilder<Tx, Tx, QAfterSortBy> thenByTxidDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'txid', Sort.desc);
    });
  }
}

extension TxQueryWhereDistinct on QueryBuilder<Tx, Tx, QDistinct> {
  QueryBuilder<Tx, Tx, QDistinct> distinctByBlock() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'block');
    });
  }

  QueryBuilder<Tx, Tx, QDistinct> distinctByRawTx({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'rawTx', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Tx, Tx, QDistinct> distinctByTxid({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'txid', caseSensitive: caseSensitive);
    });
  }
}

extension TxQueryProperty on QueryBuilder<Tx, Tx, QQueryProperty> {
  QueryBuilder<Tx, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<Tx, int, QQueryOperations> blockProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'block');
    });
  }

  QueryBuilder<Tx, String, QQueryOperations> rawTxProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'rawTx');
    });
  }

  QueryBuilder<Tx, String, QQueryOperations> txidProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'txid');
    });
  }
}
