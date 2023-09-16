// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'utxo.dart';

// **************************************************************************
// _IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, invalid_use_of_protected_member, lines_longer_than_80_chars, constant_identifier_names, avoid_js_rounded_ints, no_leading_underscores_for_local_identifiers, require_trailing_commas, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_in_if_null_operators, library_private_types_in_public_api, prefer_const_constructors
// ignore_for_file: type=lint

extension GetUtxoCollection on Isar {
  IsarCollection<int, Utxo> get utxos => this.collection();
}

const UtxoSchema = IsarGeneratedSchema(
  schema: IsarSchema(
    name: 'Utxo',
    idName: 'id',
    embedded: false,
    properties: [
      IsarPropertySchema(
        name: 'txid',
        type: IsarType.string,
      ),
      IsarPropertySchema(
        name: 'txpos',
        type: IsarType.long,
      ),
      IsarPropertySchema(
        name: 'value',
        type: IsarType.double,
      ),
      IsarPropertySchema(
        name: 'block',
        type: IsarType.long,
      ),
      IsarPropertySchema(
        name: 'addresses',
        type: IsarType.stringList,
      ),
      IsarPropertySchema(
        name: 'flaggedForDelete',
        type: IsarType.bool,
      ),
    ],
    indexes: [
      IsarIndexSchema(
        name: 'txid_txpos',
        properties: [
          "txid",
          "txpos",
        ],
        unique: true,
        hash: true,
      ),
    ],
  ),
  converter: IsarObjectConverter<int, Utxo>(
    serialize: serializeUtxo,
    deserialize: deserializeUtxo,
    deserializeProperty: deserializeUtxoProp,
  ),
  embeddedSchemas: [],
);

@isarProtected
int serializeUtxo(IsarWriter writer, Utxo object) {
  IsarCore.writeString(writer, 1, object.txid);
  IsarCore.writeLong(writer, 2, object.txpos);
  IsarCore.writeDouble(writer, 3, object.value);
  IsarCore.writeLong(writer, 4, object.block);
  {
    final list = object.addresses;
    final listWriter = IsarCore.beginList(writer, 5, list.length);
    for (var i = 0; i < list.length; i++) {
      IsarCore.writeString(listWriter, i, list[i]);
    }
    IsarCore.endList(writer, listWriter);
  }
  IsarCore.writeBool(writer, 6, object.flaggedForDelete);
  return object.id;
}

@isarProtected
Utxo deserializeUtxo(IsarReader reader) {
  final int _id;
  _id = IsarCore.readId(reader);
  final String _txid;
  _txid = IsarCore.readString(reader, 1) ?? '';
  final int _txpos;
  _txpos = IsarCore.readLong(reader, 2);
  final double _value;
  _value = IsarCore.readDouble(reader, 3);
  final int _block;
  _block = IsarCore.readLong(reader, 4);
  final List<String> _addresses;
  {
    final length = IsarCore.readList(reader, 5, IsarCore.readerPtrPtr);
    {
      final reader = IsarCore.readerPtr;
      if (reader.isNull) {
        _addresses = const <String>[];
      } else {
        final list = List<String>.filled(length, '', growable: true);
        for (var i = 0; i < length; i++) {
          list[i] = IsarCore.readString(reader, i) ?? '';
        }
        IsarCore.freeReader(reader);
        _addresses = list;
      }
    }
  }
  final object = Utxo(
    id: _id,
    txid: _txid,
    txpos: _txpos,
    value: _value,
    block: _block,
    addresses: _addresses,
  );
  object.flaggedForDelete = IsarCore.readBool(reader, 6);
  return object;
}

@isarProtected
dynamic deserializeUtxoProp(IsarReader reader, int property) {
  switch (property) {
    case 0:
      return IsarCore.readId(reader);
    case 1:
      return IsarCore.readString(reader, 1) ?? '';
    case 2:
      return IsarCore.readLong(reader, 2);
    case 3:
      return IsarCore.readDouble(reader, 3);
    case 4:
      return IsarCore.readLong(reader, 4);
    case 5:
      {
        final length = IsarCore.readList(reader, 5, IsarCore.readerPtrPtr);
        {
          final reader = IsarCore.readerPtr;
          if (reader.isNull) {
            return const <String>[];
          } else {
            final list = List<String>.filled(length, '', growable: true);
            for (var i = 0; i < length; i++) {
              list[i] = IsarCore.readString(reader, i) ?? '';
            }
            IsarCore.freeReader(reader);
            return list;
          }
        }
      }
    case 6:
      return IsarCore.readBool(reader, 6);
    default:
      throw ArgumentError('Unknown property: $property');
  }
}

sealed class _UtxoUpdate {
  bool call({
    required int id,
    String? txid,
    int? txpos,
    double? value,
    int? block,
    bool? flaggedForDelete,
  });
}

class _UtxoUpdateImpl implements _UtxoUpdate {
  const _UtxoUpdateImpl(this.collection);

  final IsarCollection<int, Utxo> collection;

  @override
  bool call({
    required int id,
    Object? txid = ignore,
    Object? txpos = ignore,
    Object? value = ignore,
    Object? block = ignore,
    Object? flaggedForDelete = ignore,
  }) {
    return collection.updateProperties([
          id
        ], {
          if (txid != ignore) 1: txid as String?,
          if (txpos != ignore) 2: txpos as int?,
          if (value != ignore) 3: value as double?,
          if (block != ignore) 4: block as int?,
          if (flaggedForDelete != ignore) 6: flaggedForDelete as bool?,
        }) >
        0;
  }
}

sealed class _UtxoUpdateAll {
  int call({
    required List<int> id,
    String? txid,
    int? txpos,
    double? value,
    int? block,
    bool? flaggedForDelete,
  });
}

class _UtxoUpdateAllImpl implements _UtxoUpdateAll {
  const _UtxoUpdateAllImpl(this.collection);

  final IsarCollection<int, Utxo> collection;

  @override
  int call({
    required List<int> id,
    Object? txid = ignore,
    Object? txpos = ignore,
    Object? value = ignore,
    Object? block = ignore,
    Object? flaggedForDelete = ignore,
  }) {
    return collection.updateProperties(id, {
      if (txid != ignore) 1: txid as String?,
      if (txpos != ignore) 2: txpos as int?,
      if (value != ignore) 3: value as double?,
      if (block != ignore) 4: block as int?,
      if (flaggedForDelete != ignore) 6: flaggedForDelete as bool?,
    });
  }
}

extension UtxoUpdate on IsarCollection<int, Utxo> {
  _UtxoUpdate get update => _UtxoUpdateImpl(this);

  _UtxoUpdateAll get updateAll => _UtxoUpdateAllImpl(this);
}

sealed class _UtxoQueryUpdate {
  int call({
    String? txid,
    int? txpos,
    double? value,
    int? block,
    bool? flaggedForDelete,
  });
}

class _UtxoQueryUpdateImpl implements _UtxoQueryUpdate {
  const _UtxoQueryUpdateImpl(this.query, {this.limit});

  final IsarQuery<Utxo> query;
  final int? limit;

  @override
  int call({
    Object? txid = ignore,
    Object? txpos = ignore,
    Object? value = ignore,
    Object? block = ignore,
    Object? flaggedForDelete = ignore,
  }) {
    return query.updateProperties(limit: limit, {
      if (txid != ignore) 1: txid as String?,
      if (txpos != ignore) 2: txpos as int?,
      if (value != ignore) 3: value as double?,
      if (block != ignore) 4: block as int?,
      if (flaggedForDelete != ignore) 6: flaggedForDelete as bool?,
    });
  }
}

extension UtxoQueryUpdate on IsarQuery<Utxo> {
  _UtxoQueryUpdate get updateFirst => _UtxoQueryUpdateImpl(this, limit: 1);

  _UtxoQueryUpdate get updateAll => _UtxoQueryUpdateImpl(this);
}

class _UtxoQueryBuilderUpdateImpl implements _UtxoQueryUpdate {
  const _UtxoQueryBuilderUpdateImpl(this.query, {this.limit});

  final QueryBuilder<Utxo, Utxo, QOperations> query;
  final int? limit;

  @override
  int call({
    Object? txid = ignore,
    Object? txpos = ignore,
    Object? value = ignore,
    Object? block = ignore,
    Object? flaggedForDelete = ignore,
  }) {
    final q = query.build();
    try {
      return q.updateProperties(limit: limit, {
        if (txid != ignore) 1: txid as String?,
        if (txpos != ignore) 2: txpos as int?,
        if (value != ignore) 3: value as double?,
        if (block != ignore) 4: block as int?,
        if (flaggedForDelete != ignore) 6: flaggedForDelete as bool?,
      });
    } finally {
      q.close();
    }
  }
}

extension UtxoQueryBuilderUpdate on QueryBuilder<Utxo, Utxo, QOperations> {
  _UtxoQueryUpdate get updateFirst =>
      _UtxoQueryBuilderUpdateImpl(this, limit: 1);

  _UtxoQueryUpdate get updateAll => _UtxoQueryBuilderUpdateImpl(this);
}

extension UtxoQueryFilter on QueryBuilder<Utxo, Utxo, QFilterCondition> {
  QueryBuilder<Utxo, Utxo, QAfterFilterCondition> idEqualTo(
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

  QueryBuilder<Utxo, Utxo, QAfterFilterCondition> idGreaterThan(
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

  QueryBuilder<Utxo, Utxo, QAfterFilterCondition> idGreaterThanOrEqualTo(
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

  QueryBuilder<Utxo, Utxo, QAfterFilterCondition> idLessThan(
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

  QueryBuilder<Utxo, Utxo, QAfterFilterCondition> idLessThanOrEqualTo(
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

  QueryBuilder<Utxo, Utxo, QAfterFilterCondition> idBetween(
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

  QueryBuilder<Utxo, Utxo, QAfterFilterCondition> txidEqualTo(
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

  QueryBuilder<Utxo, Utxo, QAfterFilterCondition> txidGreaterThan(
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

  QueryBuilder<Utxo, Utxo, QAfterFilterCondition> txidGreaterThanOrEqualTo(
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

  QueryBuilder<Utxo, Utxo, QAfterFilterCondition> txidLessThan(
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

  QueryBuilder<Utxo, Utxo, QAfterFilterCondition> txidLessThanOrEqualTo(
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

  QueryBuilder<Utxo, Utxo, QAfterFilterCondition> txidBetween(
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

  QueryBuilder<Utxo, Utxo, QAfterFilterCondition> txidStartsWith(
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

  QueryBuilder<Utxo, Utxo, QAfterFilterCondition> txidEndsWith(
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

  QueryBuilder<Utxo, Utxo, QAfterFilterCondition> txidContains(String value,
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

  QueryBuilder<Utxo, Utxo, QAfterFilterCondition> txidMatches(String pattern,
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

  QueryBuilder<Utxo, Utxo, QAfterFilterCondition> txidIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const EqualCondition(
          property: 1,
          value: '',
        ),
      );
    });
  }

  QueryBuilder<Utxo, Utxo, QAfterFilterCondition> txidIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const GreaterCondition(
          property: 1,
          value: '',
        ),
      );
    });
  }

  QueryBuilder<Utxo, Utxo, QAfterFilterCondition> txposEqualTo(
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

  QueryBuilder<Utxo, Utxo, QAfterFilterCondition> txposGreaterThan(
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

  QueryBuilder<Utxo, Utxo, QAfterFilterCondition> txposGreaterThanOrEqualTo(
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

  QueryBuilder<Utxo, Utxo, QAfterFilterCondition> txposLessThan(
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

  QueryBuilder<Utxo, Utxo, QAfterFilterCondition> txposLessThanOrEqualTo(
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

  QueryBuilder<Utxo, Utxo, QAfterFilterCondition> txposBetween(
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

  QueryBuilder<Utxo, Utxo, QAfterFilterCondition> valueEqualTo(
    double value, {
    double epsilon = Filter.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        EqualCondition(
          property: 3,
          value: value,
          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<Utxo, Utxo, QAfterFilterCondition> valueGreaterThan(
    double value, {
    double epsilon = Filter.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterCondition(
          property: 3,
          value: value,
          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<Utxo, Utxo, QAfterFilterCondition> valueGreaterThanOrEqualTo(
    double value, {
    double epsilon = Filter.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterOrEqualCondition(
          property: 3,
          value: value,
          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<Utxo, Utxo, QAfterFilterCondition> valueLessThan(
    double value, {
    double epsilon = Filter.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessCondition(
          property: 3,
          value: value,
          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<Utxo, Utxo, QAfterFilterCondition> valueLessThanOrEqualTo(
    double value, {
    double epsilon = Filter.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessOrEqualCondition(
          property: 3,
          value: value,
          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<Utxo, Utxo, QAfterFilterCondition> valueBetween(
    double lower,
    double upper, {
    double epsilon = Filter.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        BetweenCondition(
          property: 3,
          lower: lower,
          upper: upper,
          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<Utxo, Utxo, QAfterFilterCondition> blockEqualTo(
    int value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        EqualCondition(
          property: 4,
          value: value,
        ),
      );
    });
  }

  QueryBuilder<Utxo, Utxo, QAfterFilterCondition> blockGreaterThan(
    int value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterCondition(
          property: 4,
          value: value,
        ),
      );
    });
  }

  QueryBuilder<Utxo, Utxo, QAfterFilterCondition> blockGreaterThanOrEqualTo(
    int value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterOrEqualCondition(
          property: 4,
          value: value,
        ),
      );
    });
  }

  QueryBuilder<Utxo, Utxo, QAfterFilterCondition> blockLessThan(
    int value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessCondition(
          property: 4,
          value: value,
        ),
      );
    });
  }

  QueryBuilder<Utxo, Utxo, QAfterFilterCondition> blockLessThanOrEqualTo(
    int value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessOrEqualCondition(
          property: 4,
          value: value,
        ),
      );
    });
  }

  QueryBuilder<Utxo, Utxo, QAfterFilterCondition> blockBetween(
    int lower,
    int upper,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        BetweenCondition(
          property: 4,
          lower: lower,
          upper: upper,
        ),
      );
    });
  }

  QueryBuilder<Utxo, Utxo, QAfterFilterCondition> addressesElementEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        EqualCondition(
          property: 5,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Utxo, Utxo, QAfterFilterCondition> addressesElementGreaterThan(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterCondition(
          property: 5,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Utxo, Utxo, QAfterFilterCondition>
      addressesElementGreaterThanOrEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterOrEqualCondition(
          property: 5,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Utxo, Utxo, QAfterFilterCondition> addressesElementLessThan(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessCondition(
          property: 5,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Utxo, Utxo, QAfterFilterCondition>
      addressesElementLessThanOrEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessOrEqualCondition(
          property: 5,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Utxo, Utxo, QAfterFilterCondition> addressesElementBetween(
    String lower,
    String upper, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        BetweenCondition(
          property: 5,
          lower: lower,
          upper: upper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Utxo, Utxo, QAfterFilterCondition> addressesElementStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        StartsWithCondition(
          property: 5,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Utxo, Utxo, QAfterFilterCondition> addressesElementEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        EndsWithCondition(
          property: 5,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Utxo, Utxo, QAfterFilterCondition> addressesElementContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        ContainsCondition(
          property: 5,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Utxo, Utxo, QAfterFilterCondition> addressesElementMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        MatchesCondition(
          property: 5,
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Utxo, Utxo, QAfterFilterCondition> addressesElementIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const EqualCondition(
          property: 5,
          value: '',
        ),
      );
    });
  }

  QueryBuilder<Utxo, Utxo, QAfterFilterCondition> addressesElementIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const GreaterCondition(
          property: 5,
          value: '',
        ),
      );
    });
  }

  QueryBuilder<Utxo, Utxo, QAfterFilterCondition> addressesIsEmpty() {
    return not().addressesIsNotEmpty();
  }

  QueryBuilder<Utxo, Utxo, QAfterFilterCondition> addressesIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const GreaterOrEqualCondition(property: 5, value: null),
      );
    });
  }

  QueryBuilder<Utxo, Utxo, QAfterFilterCondition> flaggedForDeleteEqualTo(
    bool value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        EqualCondition(
          property: 6,
          value: value,
        ),
      );
    });
  }
}

extension UtxoQueryObject on QueryBuilder<Utxo, Utxo, QFilterCondition> {}

extension UtxoQuerySortBy on QueryBuilder<Utxo, Utxo, QSortBy> {
  QueryBuilder<Utxo, Utxo, QAfterSortBy> sortById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(0);
    });
  }

  QueryBuilder<Utxo, Utxo, QAfterSortBy> sortByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(0, sort: Sort.desc);
    });
  }

  QueryBuilder<Utxo, Utxo, QAfterSortBy> sortByTxid(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(
        1,
        caseSensitive: caseSensitive,
      );
    });
  }

  QueryBuilder<Utxo, Utxo, QAfterSortBy> sortByTxidDesc(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(
        1,
        sort: Sort.desc,
        caseSensitive: caseSensitive,
      );
    });
  }

  QueryBuilder<Utxo, Utxo, QAfterSortBy> sortByTxpos() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(2);
    });
  }

  QueryBuilder<Utxo, Utxo, QAfterSortBy> sortByTxposDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(2, sort: Sort.desc);
    });
  }

  QueryBuilder<Utxo, Utxo, QAfterSortBy> sortByValue() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(3);
    });
  }

  QueryBuilder<Utxo, Utxo, QAfterSortBy> sortByValueDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(3, sort: Sort.desc);
    });
  }

  QueryBuilder<Utxo, Utxo, QAfterSortBy> sortByBlock() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(4);
    });
  }

  QueryBuilder<Utxo, Utxo, QAfterSortBy> sortByBlockDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(4, sort: Sort.desc);
    });
  }

  QueryBuilder<Utxo, Utxo, QAfterSortBy> sortByFlaggedForDelete() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(6);
    });
  }

  QueryBuilder<Utxo, Utxo, QAfterSortBy> sortByFlaggedForDeleteDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(6, sort: Sort.desc);
    });
  }
}

extension UtxoQuerySortThenBy on QueryBuilder<Utxo, Utxo, QSortThenBy> {
  QueryBuilder<Utxo, Utxo, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(0);
    });
  }

  QueryBuilder<Utxo, Utxo, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(0, sort: Sort.desc);
    });
  }

  QueryBuilder<Utxo, Utxo, QAfterSortBy> thenByTxid(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(1, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Utxo, Utxo, QAfterSortBy> thenByTxidDesc(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(1, sort: Sort.desc, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Utxo, Utxo, QAfterSortBy> thenByTxpos() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(2);
    });
  }

  QueryBuilder<Utxo, Utxo, QAfterSortBy> thenByTxposDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(2, sort: Sort.desc);
    });
  }

  QueryBuilder<Utxo, Utxo, QAfterSortBy> thenByValue() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(3);
    });
  }

  QueryBuilder<Utxo, Utxo, QAfterSortBy> thenByValueDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(3, sort: Sort.desc);
    });
  }

  QueryBuilder<Utxo, Utxo, QAfterSortBy> thenByBlock() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(4);
    });
  }

  QueryBuilder<Utxo, Utxo, QAfterSortBy> thenByBlockDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(4, sort: Sort.desc);
    });
  }

  QueryBuilder<Utxo, Utxo, QAfterSortBy> thenByFlaggedForDelete() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(6);
    });
  }

  QueryBuilder<Utxo, Utxo, QAfterSortBy> thenByFlaggedForDeleteDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(6, sort: Sort.desc);
    });
  }
}

extension UtxoQueryWhereDistinct on QueryBuilder<Utxo, Utxo, QDistinct> {
  QueryBuilder<Utxo, Utxo, QAfterDistinct> distinctByTxid(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(1, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Utxo, Utxo, QAfterDistinct> distinctByTxpos() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(2);
    });
  }

  QueryBuilder<Utxo, Utxo, QAfterDistinct> distinctByValue() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(3);
    });
  }

  QueryBuilder<Utxo, Utxo, QAfterDistinct> distinctByBlock() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(4);
    });
  }

  QueryBuilder<Utxo, Utxo, QAfterDistinct> distinctByAddresses() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(5);
    });
  }

  QueryBuilder<Utxo, Utxo, QAfterDistinct> distinctByFlaggedForDelete() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(6);
    });
  }
}

extension UtxoQueryProperty1 on QueryBuilder<Utxo, Utxo, QProperty> {
  QueryBuilder<Utxo, int, QAfterProperty> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(0);
    });
  }

  QueryBuilder<Utxo, String, QAfterProperty> txidProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(1);
    });
  }

  QueryBuilder<Utxo, int, QAfterProperty> txposProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(2);
    });
  }

  QueryBuilder<Utxo, double, QAfterProperty> valueProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(3);
    });
  }

  QueryBuilder<Utxo, int, QAfterProperty> blockProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(4);
    });
  }

  QueryBuilder<Utxo, List<String>, QAfterProperty> addressesProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(5);
    });
  }

  QueryBuilder<Utxo, bool, QAfterProperty> flaggedForDeleteProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(6);
    });
  }
}

extension UtxoQueryProperty2<R> on QueryBuilder<Utxo, R, QAfterProperty> {
  QueryBuilder<Utxo, (R, int), QAfterProperty> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(0);
    });
  }

  QueryBuilder<Utxo, (R, String), QAfterProperty> txidProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(1);
    });
  }

  QueryBuilder<Utxo, (R, int), QAfterProperty> txposProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(2);
    });
  }

  QueryBuilder<Utxo, (R, double), QAfterProperty> valueProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(3);
    });
  }

  QueryBuilder<Utxo, (R, int), QAfterProperty> blockProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(4);
    });
  }

  QueryBuilder<Utxo, (R, List<String>), QAfterProperty> addressesProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(5);
    });
  }

  QueryBuilder<Utxo, (R, bool), QAfterProperty> flaggedForDeleteProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(6);
    });
  }
}

extension UtxoQueryProperty3<R1, R2>
    on QueryBuilder<Utxo, (R1, R2), QAfterProperty> {
  QueryBuilder<Utxo, (R1, R2, int), QOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(0);
    });
  }

  QueryBuilder<Utxo, (R1, R2, String), QOperations> txidProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(1);
    });
  }

  QueryBuilder<Utxo, (R1, R2, int), QOperations> txposProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(2);
    });
  }

  QueryBuilder<Utxo, (R1, R2, double), QOperations> valueProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(3);
    });
  }

  QueryBuilder<Utxo, (R1, R2, int), QOperations> blockProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(4);
    });
  }

  QueryBuilder<Utxo, (R1, R2, List<String>), QOperations> addressesProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(5);
    });
  }

  QueryBuilder<Utxo, (R1, R2, bool), QOperations> flaggedForDeleteProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(6);
    });
  }
}
