// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'block.dart';

// **************************************************************************
// _IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, invalid_use_of_protected_member, lines_longer_than_80_chars, constant_identifier_names, avoid_js_rounded_ints, no_leading_underscores_for_local_identifiers, require_trailing_commas, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_in_if_null_operators, library_private_types_in_public_api, prefer_const_constructors

extension GetBlockCollection on Isar {
  IsarCollection<int, Block> get blocks => this.collection();
}

const BlockSchema = IsarCollectionSchema(
  schema:
      '{"name":"Block","idName":"id","properties":[{"name":"hash","type":"String"},{"name":"blocktime","type":"Long"}]}',
  converter: IsarObjectConverter<int, Block>(
    serialize: serializeBlock,
    deserialize: deserializeBlock,
    deserializeProperty: deserializeBlockProp,
  ),
  embeddedSchemas: [],
  hash: -6243897465897407616,
);

@isarProtected
int serializeBlock(IsarWriter writer, Block object) {
  IsarCore.writeString(writer, 1, IsarCore.toNativeString(object.hash));
  IsarCore.writeLong(writer, 2, object.blocktime);
  return object.id;
}

@isarProtected
Block deserializeBlock(IsarReader reader) {
  final int _id;
  _id = IsarCore.readId(reader);
  final String _hash;
  _hash = IsarCore.readString(reader, 1) ?? '';
  final int _blocktime;
  _blocktime = IsarCore.readLong(reader, 2);
  final object = Block(
    id: _id,
    hash: _hash,
    blocktime: _blocktime,
  );
  return object;
}

@isarProtected
dynamic deserializeBlockProp(IsarReader reader, int property) {
  switch (property) {
    case 0:
      return IsarCore.readId(reader);
    case 1:
      return IsarCore.readString(reader, 1) ?? '';
    case 2:
      return IsarCore.readLong(reader, 2);
    default:
      throw ArgumentError('Unknown property: $property');
  }
}

sealed class _BlockUpdate {
  bool call({
    required int id,
    String? hash,
    int? blocktime,
  });
}

class _BlockUpdateImpl implements _BlockUpdate {
  const _BlockUpdateImpl(this.collection);

  final IsarCollection<int, Block> collection;

  @override
  bool call({
    required int id,
    Object? hash = ignore,
    Object? blocktime = ignore,
  }) {
    return collection.updateProperties([
          id
        ], {
          if (hash != ignore) 1: hash as String?,
          if (blocktime != ignore) 2: blocktime as int?,
        }) >
        0;
  }
}

sealed class _BlockUpdateAll {
  int call({
    required List<int> id,
    String? hash,
    int? blocktime,
  });
}

class _BlockUpdateAllImpl implements _BlockUpdateAll {
  const _BlockUpdateAllImpl(this.collection);

  final IsarCollection<int, Block> collection;

  @override
  int call({
    required List<int> id,
    Object? hash = ignore,
    Object? blocktime = ignore,
  }) {
    return collection.updateProperties(id, {
      if (hash != ignore) 1: hash as String?,
      if (blocktime != ignore) 2: blocktime as int?,
    });
  }
}

extension BlockUpdate on IsarCollection<int, Block> {
  _BlockUpdate get update => _BlockUpdateImpl(this);

  _BlockUpdateAll get updateAll => _BlockUpdateAllImpl(this);
}

sealed class _BlockQueryUpdate {
  int call({
    String? hash,
    int? blocktime,
  });
}

class _BlockQueryUpdateImpl implements _BlockQueryUpdate {
  const _BlockQueryUpdateImpl(this.query, {this.limit});

  final IsarQuery<Block> query;
  final int? limit;

  @override
  int call({
    Object? hash = ignore,
    Object? blocktime = ignore,
  }) {
    return query.updateProperties(limit: limit, {
      if (hash != ignore) 1: hash as String?,
      if (blocktime != ignore) 2: blocktime as int?,
    });
  }
}

extension BlockQueryUpdate on IsarQuery<Block> {
  _BlockQueryUpdate get updateFirst => _BlockQueryUpdateImpl(this, limit: 1);

  _BlockQueryUpdate get updateAll => _BlockQueryUpdateImpl(this);
}

extension BlockQueryFilter on QueryBuilder<Block, Block, QFilterCondition> {
  QueryBuilder<Block, Block, QAfterFilterCondition> idEqualTo(
    int value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        EqualCondition(
          property: 0,
          value: value,
        ),
      );
    });
  }

  QueryBuilder<Block, Block, QAfterFilterCondition> idGreaterThan(
    int value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterCondition(
          property: 0,
          value: value,
        ),
      );
    });
  }

  QueryBuilder<Block, Block, QAfterFilterCondition> idGreaterThanOrEqualTo(
    int value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterOrEqualCondition(
          property: 0,
          value: value,
        ),
      );
    });
  }

  QueryBuilder<Block, Block, QAfterFilterCondition> idLessThan(
    int value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessCondition(
          property: 0,
          value: value,
        ),
      );
    });
  }

  QueryBuilder<Block, Block, QAfterFilterCondition> idLessThanOrEqualTo(
    int value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessOrEqualCondition(
          property: 0,
          value: value,
        ),
      );
    });
  }

  QueryBuilder<Block, Block, QAfterFilterCondition> idBetween(
    int lower,
    int upper,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        BetweenCondition(
          property: 0,
          lower: lower,
          upper: upper,
        ),
      );
    });
  }

  QueryBuilder<Block, Block, QAfterFilterCondition> hashEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        EqualCondition(
          property: 1,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Block, Block, QAfterFilterCondition> hashGreaterThan(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterCondition(
          property: 1,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Block, Block, QAfterFilterCondition> hashGreaterThanOrEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterOrEqualCondition(
          property: 1,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Block, Block, QAfterFilterCondition> hashLessThan(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessCondition(
          property: 1,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Block, Block, QAfterFilterCondition> hashLessThanOrEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessOrEqualCondition(
          property: 1,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Block, Block, QAfterFilterCondition> hashBetween(
    String lower,
    String upper, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        BetweenCondition(
          property: 1,
          lower: lower,
          upper: upper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Block, Block, QAfterFilterCondition> hashStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        StartsWithCondition(
          property: 1,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Block, Block, QAfterFilterCondition> hashEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        EndsWithCondition(
          property: 1,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Block, Block, QAfterFilterCondition> hashContains(String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        ContainsCondition(
          property: 1,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Block, Block, QAfterFilterCondition> hashMatches(String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        MatchesCondition(
          property: 1,
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Block, Block, QAfterFilterCondition> hashIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const EqualCondition(
          property: 1,
          value: '',
        ),
      );
    });
  }

  QueryBuilder<Block, Block, QAfterFilterCondition> hashIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const GreaterCondition(
          property: 1,
          value: '',
        ),
      );
    });
  }

  QueryBuilder<Block, Block, QAfterFilterCondition> blocktimeEqualTo(
    int value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        EqualCondition(
          property: 2,
          value: value,
        ),
      );
    });
  }

  QueryBuilder<Block, Block, QAfterFilterCondition> blocktimeGreaterThan(
    int value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterCondition(
          property: 2,
          value: value,
        ),
      );
    });
  }

  QueryBuilder<Block, Block, QAfterFilterCondition>
      blocktimeGreaterThanOrEqualTo(
    int value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterOrEqualCondition(
          property: 2,
          value: value,
        ),
      );
    });
  }

  QueryBuilder<Block, Block, QAfterFilterCondition> blocktimeLessThan(
    int value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessCondition(
          property: 2,
          value: value,
        ),
      );
    });
  }

  QueryBuilder<Block, Block, QAfterFilterCondition> blocktimeLessThanOrEqualTo(
    int value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessOrEqualCondition(
          property: 2,
          value: value,
        ),
      );
    });
  }

  QueryBuilder<Block, Block, QAfterFilterCondition> blocktimeBetween(
    int lower,
    int upper,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        BetweenCondition(
          property: 2,
          lower: lower,
          upper: upper,
        ),
      );
    });
  }
}

extension BlockQueryObject on QueryBuilder<Block, Block, QFilterCondition> {}

extension BlockQuerySortBy on QueryBuilder<Block, Block, QSortBy> {
  QueryBuilder<Block, Block, QAfterSortBy> sortById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(0);
    });
  }

  QueryBuilder<Block, Block, QAfterSortBy> sortByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(0, sort: Sort.desc);
    });
  }

  QueryBuilder<Block, Block, QAfterSortBy> sortByHash(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(
        1,
        caseSensitive: caseSensitive,
      );
    });
  }

  QueryBuilder<Block, Block, QAfterSortBy> sortByHashDesc(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(
        1,
        sort: Sort.desc,
        caseSensitive: caseSensitive,
      );
    });
  }

  QueryBuilder<Block, Block, QAfterSortBy> sortByBlocktime() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(2);
    });
  }

  QueryBuilder<Block, Block, QAfterSortBy> sortByBlocktimeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(2, sort: Sort.desc);
    });
  }
}

extension BlockQuerySortThenBy on QueryBuilder<Block, Block, QSortThenBy> {
  QueryBuilder<Block, Block, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(0);
    });
  }

  QueryBuilder<Block, Block, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(0, sort: Sort.desc);
    });
  }

  QueryBuilder<Block, Block, QAfterSortBy> thenByHash(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(1, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Block, Block, QAfterSortBy> thenByHashDesc(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(1, sort: Sort.desc, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Block, Block, QAfterSortBy> thenByBlocktime() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(2);
    });
  }

  QueryBuilder<Block, Block, QAfterSortBy> thenByBlocktimeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(2, sort: Sort.desc);
    });
  }
}

extension BlockQueryWhereDistinct on QueryBuilder<Block, Block, QDistinct> {
  QueryBuilder<Block, Block, QAfterDistinct> distinctByHash(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(1, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Block, Block, QAfterDistinct> distinctByBlocktime() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(2);
    });
  }
}

extension BlockQueryProperty1 on QueryBuilder<Block, Block, QProperty> {
  QueryBuilder<Block, int, QAfterProperty> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(0);
    });
  }

  QueryBuilder<Block, String, QAfterProperty> hashProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(1);
    });
  }

  QueryBuilder<Block, int, QAfterProperty> blocktimeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(2);
    });
  }
}

extension BlockQueryProperty2<R> on QueryBuilder<Block, R, QAfterProperty> {
  QueryBuilder<Block, (R, int), QAfterProperty> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(0);
    });
  }

  QueryBuilder<Block, (R, String), QAfterProperty> hashProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(1);
    });
  }

  QueryBuilder<Block, (R, int), QAfterProperty> blocktimeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(2);
    });
  }
}

extension BlockQueryProperty3<R1, R2>
    on QueryBuilder<Block, (R1, R2), QAfterProperty> {
  QueryBuilder<Block, (R1, R2, int), QOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(0);
    });
  }

  QueryBuilder<Block, (R1, R2, String), QOperations> hashProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(1);
    });
  }

  QueryBuilder<Block, (R1, R2, int), QOperations> blocktimeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(2);
    });
  }
}
