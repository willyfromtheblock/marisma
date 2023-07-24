// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'address.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, invalid_use_of_protected_member, lines_longer_than_80_chars, constant_identifier_names, avoid_js_rounded_ints, no_leading_underscores_for_local_identifiers, require_trailing_commas, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_in_if_null_operators, library_private_types_in_public_api

extension GetAddressModelCollection on Isar {
  IsarCollection<int, AddressModel> get addressModels => this.collection();
}

const AddressModelSchema = IsarCollectionSchema(
  schema:
      '{"name":"AddressModel","idName":"id","properties":[{"name":"address","type":"String"},{"name":"status","type":"String"},{"name":"confirmedBalance","type":"Long"},{"name":"unconfirmedBalance","type":"Long"},{"name":"needsUpdating","type":"Bool"},{"name":"utxos","type":"LongList"},{"name":"utxoHistory","type":"StringList"}]}',
  converter: IsarObjectConverter<int, AddressModel>(
    serialize: serializeAddressModel,
    deserialize: deserializeAddressModel,
    deserializeProperty: deserializeAddressModelProp,
  ),
  embeddedSchemas: [],
  hash: 4250850421886137324,
);

@isarProtected
int serializeAddressModel(IsarWriter writer, AddressModel object) {
  IsarCore.writeString(writer, 1, IsarCore.toNativeString(object.address));
  IsarCore.writeString(writer, 2, IsarCore.toNativeString(object.status));
  IsarCore.writeLong(writer, 3, object.confirmedBalance);
  IsarCore.writeLong(writer, 4, object.unconfirmedBalance);
  IsarCore.writeBool(writer, 5, object.needsUpdating);
  {
    final list = object.utxos;
    final listWriter = IsarCore.beginList(writer, 6, list.length);
    for (var i = 0; i < list.length; i++) {
      IsarCore.writeLong(listWriter, i, list[i]);
    }
    IsarCore.endList(writer, listWriter);
  }
  {
    final list = object.utxoHistory;
    final listWriter = IsarCore.beginList(writer, 7, list.length);
    for (var i = 0; i < list.length; i++) {
      IsarCore.writeString(listWriter, i, IsarCore.toNativeString(list[i]));
    }
    IsarCore.endList(writer, listWriter);
  }
  return object.id;
}

@isarProtected
AddressModel deserializeAddressModel(IsarReader reader) {
  final int _id;
  _id = IsarCore.readId(reader);
  final String _address;
  _address = IsarCore.readString(reader, 1) ?? '';
  final object = AddressModel(
    id: _id,
    address: _address,
  );
  object.status = IsarCore.readString(reader, 2) ?? '';
  object.confirmedBalance = IsarCore.readLong(reader, 3);
  object.unconfirmedBalance = IsarCore.readLong(reader, 4);
  object.needsUpdating = IsarCore.readBool(reader, 5);
  {
    final length = IsarCore.readList(reader, 6, IsarCore.readerPtrPtr);
    {
      final reader = IsarCore.readerPtr;
      if (reader.isNull) {
        object.utxos = const <int>[];
      } else {
        final list =
            List<int>.filled(length, -9223372036854775808, growable: true);
        for (var i = 0; i < length; i++) {
          list[i] = IsarCore.readLong(reader, i);
        }
        IsarCore.freeReader(reader);
        object.utxos = list;
      }
    }
  }
  {
    final length = IsarCore.readList(reader, 7, IsarCore.readerPtrPtr);
    {
      final reader = IsarCore.readerPtr;
      if (reader.isNull) {
        object.utxoHistory = const <String>[];
      } else {
        final list = List<String>.filled(length, '', growable: true);
        for (var i = 0; i < length; i++) {
          list[i] = IsarCore.readString(reader, i) ?? '';
        }
        IsarCore.freeReader(reader);
        object.utxoHistory = list;
      }
    }
  }
  return object;
}

@isarProtected
dynamic deserializeAddressModelProp(IsarReader reader, int property) {
  switch (property) {
    case 0:
      return IsarCore.readId(reader);
    case 1:
      return IsarCore.readString(reader, 1) ?? '';
    case 2:
      return IsarCore.readString(reader, 2) ?? '';
    case 3:
      return IsarCore.readLong(reader, 3);
    case 4:
      return IsarCore.readLong(reader, 4);
    case 5:
      return IsarCore.readBool(reader, 5);
    case 6:
      {
        final length = IsarCore.readList(reader, 6, IsarCore.readerPtrPtr);
        {
          final reader = IsarCore.readerPtr;
          if (reader.isNull) {
            return const <int>[];
          } else {
            final list =
                List<int>.filled(length, -9223372036854775808, growable: true);
            for (var i = 0; i < length; i++) {
              list[i] = IsarCore.readLong(reader, i);
            }
            IsarCore.freeReader(reader);
            return list;
          }
        }
      }
    case 7:
      {
        final length = IsarCore.readList(reader, 7, IsarCore.readerPtrPtr);
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
    default:
      throw ArgumentError('Unknown property: $property');
  }
}

sealed class _AddressModelUpdate {
  bool call(
    int id, {
    String? address,
    String? status,
    int? confirmedBalance,
    int? unconfirmedBalance,
    bool? needsUpdating,
  });
}

class _AddressModelUpdateImpl implements _AddressModelUpdate {
  const _AddressModelUpdateImpl(this.collection);

  final IsarCollection<int, AddressModel> collection;

  @override
  bool call(
    int id, {
    Object? address = ignore,
    Object? status = ignore,
    Object? confirmedBalance = ignore,
    Object? unconfirmedBalance = ignore,
    Object? needsUpdating = ignore,
  }) {
    return collection.updateProperties([
          id
        ], {
          if (address != ignore) 1: address as String?,
          if (status != ignore) 2: status as String?,
          if (confirmedBalance != ignore) 3: confirmedBalance as int?,
          if (unconfirmedBalance != ignore) 4: unconfirmedBalance as int?,
          if (needsUpdating != ignore) 5: needsUpdating as bool?,
        }) >
        0;
  }
}

sealed class _AddressModelUpdateAll {
  int call(
    List<int> id, {
    String? address,
    String? status,
    int? confirmedBalance,
    int? unconfirmedBalance,
    bool? needsUpdating,
  });
}

class _AddressModelUpdateAllImpl implements _AddressModelUpdateAll {
  const _AddressModelUpdateAllImpl(this.collection);

  final IsarCollection<int, AddressModel> collection;

  @override
  int call(
    List<int> id, {
    Object? address = ignore,
    Object? status = ignore,
    Object? confirmedBalance = ignore,
    Object? unconfirmedBalance = ignore,
    Object? needsUpdating = ignore,
  }) {
    return collection.updateProperties(id, {
      if (address != ignore) 1: address as String?,
      if (status != ignore) 2: status as String?,
      if (confirmedBalance != ignore) 3: confirmedBalance as int?,
      if (unconfirmedBalance != ignore) 4: unconfirmedBalance as int?,
      if (needsUpdating != ignore) 5: needsUpdating as bool?,
    });
  }
}

extension AddressModelUpdate on IsarCollection<int, AddressModel> {
  _AddressModelUpdate get update => _AddressModelUpdateImpl(this);

  _AddressModelUpdateAll get updateAll => _AddressModelUpdateAllImpl(this);
}

extension AddressModelQueryFilter
    on QueryBuilder<AddressModel, AddressModel, QFilterCondition> {
  QueryBuilder<AddressModel, AddressModel, QAfterFilterCondition> idEqualTo(
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

  QueryBuilder<AddressModel, AddressModel, QAfterFilterCondition> idGreaterThan(
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

  QueryBuilder<AddressModel, AddressModel, QAfterFilterCondition>
      idGreaterThanOrEqualTo(
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

  QueryBuilder<AddressModel, AddressModel, QAfterFilterCondition> idLessThan(
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

  QueryBuilder<AddressModel, AddressModel, QAfterFilterCondition>
      idLessThanOrEqualTo(
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

  QueryBuilder<AddressModel, AddressModel, QAfterFilterCondition> idBetween(
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

  QueryBuilder<AddressModel, AddressModel, QAfterFilterCondition>
      addressEqualTo(
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

  QueryBuilder<AddressModel, AddressModel, QAfterFilterCondition>
      addressGreaterThan(
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

  QueryBuilder<AddressModel, AddressModel, QAfterFilterCondition>
      addressGreaterThanOrEqualTo(
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

  QueryBuilder<AddressModel, AddressModel, QAfterFilterCondition>
      addressLessThan(
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

  QueryBuilder<AddressModel, AddressModel, QAfterFilterCondition>
      addressLessThanOrEqualTo(
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

  QueryBuilder<AddressModel, AddressModel, QAfterFilterCondition>
      addressBetween(
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

  QueryBuilder<AddressModel, AddressModel, QAfterFilterCondition>
      addressStartsWith(
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

  QueryBuilder<AddressModel, AddressModel, QAfterFilterCondition>
      addressEndsWith(
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

  QueryBuilder<AddressModel, AddressModel, QAfterFilterCondition>
      addressContains(String value, {bool caseSensitive = true}) {
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

  QueryBuilder<AddressModel, AddressModel, QAfterFilterCondition>
      addressMatches(String pattern, {bool caseSensitive = true}) {
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

  QueryBuilder<AddressModel, AddressModel, QAfterFilterCondition>
      addressIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const EqualCondition(
          property: 1,
          value: '',
        ),
      );
    });
  }

  QueryBuilder<AddressModel, AddressModel, QAfterFilterCondition>
      addressIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const GreaterCondition(
          property: 1,
          value: '',
        ),
      );
    });
  }

  QueryBuilder<AddressModel, AddressModel, QAfterFilterCondition> statusEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        EqualCondition(
          property: 2,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<AddressModel, AddressModel, QAfterFilterCondition>
      statusGreaterThan(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterCondition(
          property: 2,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<AddressModel, AddressModel, QAfterFilterCondition>
      statusGreaterThanOrEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterOrEqualCondition(
          property: 2,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<AddressModel, AddressModel, QAfterFilterCondition>
      statusLessThan(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessCondition(
          property: 2,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<AddressModel, AddressModel, QAfterFilterCondition>
      statusLessThanOrEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessOrEqualCondition(
          property: 2,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<AddressModel, AddressModel, QAfterFilterCondition> statusBetween(
    String lower,
    String upper, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        BetweenCondition(
          property: 2,
          lower: lower,
          upper: upper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<AddressModel, AddressModel, QAfterFilterCondition>
      statusStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        StartsWithCondition(
          property: 2,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<AddressModel, AddressModel, QAfterFilterCondition>
      statusEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        EndsWithCondition(
          property: 2,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<AddressModel, AddressModel, QAfterFilterCondition>
      statusContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        ContainsCondition(
          property: 2,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<AddressModel, AddressModel, QAfterFilterCondition> statusMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        MatchesCondition(
          property: 2,
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<AddressModel, AddressModel, QAfterFilterCondition>
      statusIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const EqualCondition(
          property: 2,
          value: '',
        ),
      );
    });
  }

  QueryBuilder<AddressModel, AddressModel, QAfterFilterCondition>
      statusIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const GreaterCondition(
          property: 2,
          value: '',
        ),
      );
    });
  }

  QueryBuilder<AddressModel, AddressModel, QAfterFilterCondition>
      confirmedBalanceEqualTo(
    int value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        EqualCondition(
          property: 3,
          value: value,
        ),
      );
    });
  }

  QueryBuilder<AddressModel, AddressModel, QAfterFilterCondition>
      confirmedBalanceGreaterThan(
    int value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterCondition(
          property: 3,
          value: value,
        ),
      );
    });
  }

  QueryBuilder<AddressModel, AddressModel, QAfterFilterCondition>
      confirmedBalanceGreaterThanOrEqualTo(
    int value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterOrEqualCondition(
          property: 3,
          value: value,
        ),
      );
    });
  }

  QueryBuilder<AddressModel, AddressModel, QAfterFilterCondition>
      confirmedBalanceLessThan(
    int value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessCondition(
          property: 3,
          value: value,
        ),
      );
    });
  }

  QueryBuilder<AddressModel, AddressModel, QAfterFilterCondition>
      confirmedBalanceLessThanOrEqualTo(
    int value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessOrEqualCondition(
          property: 3,
          value: value,
        ),
      );
    });
  }

  QueryBuilder<AddressModel, AddressModel, QAfterFilterCondition>
      confirmedBalanceBetween(
    int lower,
    int upper,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        BetweenCondition(
          property: 3,
          lower: lower,
          upper: upper,
        ),
      );
    });
  }

  QueryBuilder<AddressModel, AddressModel, QAfterFilterCondition>
      unconfirmedBalanceEqualTo(
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

  QueryBuilder<AddressModel, AddressModel, QAfterFilterCondition>
      unconfirmedBalanceGreaterThan(
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

  QueryBuilder<AddressModel, AddressModel, QAfterFilterCondition>
      unconfirmedBalanceGreaterThanOrEqualTo(
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

  QueryBuilder<AddressModel, AddressModel, QAfterFilterCondition>
      unconfirmedBalanceLessThan(
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

  QueryBuilder<AddressModel, AddressModel, QAfterFilterCondition>
      unconfirmedBalanceLessThanOrEqualTo(
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

  QueryBuilder<AddressModel, AddressModel, QAfterFilterCondition>
      unconfirmedBalanceBetween(
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

  QueryBuilder<AddressModel, AddressModel, QAfterFilterCondition>
      needsUpdatingEqualTo(
    bool value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        EqualCondition(
          property: 5,
          value: value,
        ),
      );
    });
  }

  QueryBuilder<AddressModel, AddressModel, QAfterFilterCondition>
      utxosElementEqualTo(
    int value,
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

  QueryBuilder<AddressModel, AddressModel, QAfterFilterCondition>
      utxosElementGreaterThan(
    int value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterCondition(
          property: 6,
          value: value,
        ),
      );
    });
  }

  QueryBuilder<AddressModel, AddressModel, QAfterFilterCondition>
      utxosElementGreaterThanOrEqualTo(
    int value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterOrEqualCondition(
          property: 6,
          value: value,
        ),
      );
    });
  }

  QueryBuilder<AddressModel, AddressModel, QAfterFilterCondition>
      utxosElementLessThan(
    int value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessCondition(
          property: 6,
          value: value,
        ),
      );
    });
  }

  QueryBuilder<AddressModel, AddressModel, QAfterFilterCondition>
      utxosElementLessThanOrEqualTo(
    int value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessOrEqualCondition(
          property: 6,
          value: value,
        ),
      );
    });
  }

  QueryBuilder<AddressModel, AddressModel, QAfterFilterCondition>
      utxosElementBetween(
    int lower,
    int upper,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        BetweenCondition(
          property: 6,
          lower: lower,
          upper: upper,
        ),
      );
    });
  }

  QueryBuilder<AddressModel, AddressModel, QAfterFilterCondition>
      utxosIsEmpty() {
    return not().utxosIsNotEmpty();
  }

  QueryBuilder<AddressModel, AddressModel, QAfterFilterCondition>
      utxosIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const GreaterOrEqualCondition(property: 6, value: null),
      );
    });
  }

  QueryBuilder<AddressModel, AddressModel, QAfterFilterCondition>
      utxoHistoryElementEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        EqualCondition(
          property: 7,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<AddressModel, AddressModel, QAfterFilterCondition>
      utxoHistoryElementGreaterThan(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterCondition(
          property: 7,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<AddressModel, AddressModel, QAfterFilterCondition>
      utxoHistoryElementGreaterThanOrEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterOrEqualCondition(
          property: 7,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<AddressModel, AddressModel, QAfterFilterCondition>
      utxoHistoryElementLessThan(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessCondition(
          property: 7,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<AddressModel, AddressModel, QAfterFilterCondition>
      utxoHistoryElementLessThanOrEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessOrEqualCondition(
          property: 7,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<AddressModel, AddressModel, QAfterFilterCondition>
      utxoHistoryElementBetween(
    String lower,
    String upper, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        BetweenCondition(
          property: 7,
          lower: lower,
          upper: upper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<AddressModel, AddressModel, QAfterFilterCondition>
      utxoHistoryElementStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        StartsWithCondition(
          property: 7,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<AddressModel, AddressModel, QAfterFilterCondition>
      utxoHistoryElementEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        EndsWithCondition(
          property: 7,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<AddressModel, AddressModel, QAfterFilterCondition>
      utxoHistoryElementContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        ContainsCondition(
          property: 7,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<AddressModel, AddressModel, QAfterFilterCondition>
      utxoHistoryElementMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        MatchesCondition(
          property: 7,
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<AddressModel, AddressModel, QAfterFilterCondition>
      utxoHistoryElementIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const EqualCondition(
          property: 7,
          value: '',
        ),
      );
    });
  }

  QueryBuilder<AddressModel, AddressModel, QAfterFilterCondition>
      utxoHistoryElementIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const GreaterCondition(
          property: 7,
          value: '',
        ),
      );
    });
  }

  QueryBuilder<AddressModel, AddressModel, QAfterFilterCondition>
      utxoHistoryIsEmpty() {
    return not().utxoHistoryIsNotEmpty();
  }

  QueryBuilder<AddressModel, AddressModel, QAfterFilterCondition>
      utxoHistoryIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const GreaterOrEqualCondition(property: 7, value: null),
      );
    });
  }
}

extension AddressModelQueryObject
    on QueryBuilder<AddressModel, AddressModel, QFilterCondition> {}

extension AddressModelQuerySortBy
    on QueryBuilder<AddressModel, AddressModel, QSortBy> {
  QueryBuilder<AddressModel, AddressModel, QAfterSortBy> sortById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(0);
    });
  }

  QueryBuilder<AddressModel, AddressModel, QAfterSortBy> sortByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(0, sort: Sort.desc);
    });
  }

  QueryBuilder<AddressModel, AddressModel, QAfterSortBy> sortByAddress(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(
        1,
        caseSensitive: caseSensitive,
      );
    });
  }

  QueryBuilder<AddressModel, AddressModel, QAfterSortBy> sortByAddressDesc(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(
        1,
        sort: Sort.desc,
        caseSensitive: caseSensitive,
      );
    });
  }

  QueryBuilder<AddressModel, AddressModel, QAfterSortBy> sortByStatus(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(
        2,
        caseSensitive: caseSensitive,
      );
    });
  }

  QueryBuilder<AddressModel, AddressModel, QAfterSortBy> sortByStatusDesc(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(
        2,
        sort: Sort.desc,
        caseSensitive: caseSensitive,
      );
    });
  }

  QueryBuilder<AddressModel, AddressModel, QAfterSortBy>
      sortByConfirmedBalance() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(3);
    });
  }

  QueryBuilder<AddressModel, AddressModel, QAfterSortBy>
      sortByConfirmedBalanceDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(3, sort: Sort.desc);
    });
  }

  QueryBuilder<AddressModel, AddressModel, QAfterSortBy>
      sortByUnconfirmedBalance() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(4);
    });
  }

  QueryBuilder<AddressModel, AddressModel, QAfterSortBy>
      sortByUnconfirmedBalanceDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(4, sort: Sort.desc);
    });
  }

  QueryBuilder<AddressModel, AddressModel, QAfterSortBy> sortByNeedsUpdating() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(5);
    });
  }

  QueryBuilder<AddressModel, AddressModel, QAfterSortBy>
      sortByNeedsUpdatingDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(5, sort: Sort.desc);
    });
  }
}

extension AddressModelQuerySortThenBy
    on QueryBuilder<AddressModel, AddressModel, QSortThenBy> {
  QueryBuilder<AddressModel, AddressModel, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(0);
    });
  }

  QueryBuilder<AddressModel, AddressModel, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(0, sort: Sort.desc);
    });
  }

  QueryBuilder<AddressModel, AddressModel, QAfterSortBy> thenByAddress(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(1, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<AddressModel, AddressModel, QAfterSortBy> thenByAddressDesc(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(1, sort: Sort.desc, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<AddressModel, AddressModel, QAfterSortBy> thenByStatus(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(2, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<AddressModel, AddressModel, QAfterSortBy> thenByStatusDesc(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(2, sort: Sort.desc, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<AddressModel, AddressModel, QAfterSortBy>
      thenByConfirmedBalance() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(3);
    });
  }

  QueryBuilder<AddressModel, AddressModel, QAfterSortBy>
      thenByConfirmedBalanceDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(3, sort: Sort.desc);
    });
  }

  QueryBuilder<AddressModel, AddressModel, QAfterSortBy>
      thenByUnconfirmedBalance() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(4);
    });
  }

  QueryBuilder<AddressModel, AddressModel, QAfterSortBy>
      thenByUnconfirmedBalanceDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(4, sort: Sort.desc);
    });
  }

  QueryBuilder<AddressModel, AddressModel, QAfterSortBy> thenByNeedsUpdating() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(5);
    });
  }

  QueryBuilder<AddressModel, AddressModel, QAfterSortBy>
      thenByNeedsUpdatingDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(5, sort: Sort.desc);
    });
  }
}

extension AddressModelQueryWhereDistinct
    on QueryBuilder<AddressModel, AddressModel, QDistinct> {
  QueryBuilder<AddressModel, AddressModel, QAfterDistinct> distinctByAddress(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(1, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<AddressModel, AddressModel, QAfterDistinct> distinctByStatus(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(2, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<AddressModel, AddressModel, QAfterDistinct>
      distinctByConfirmedBalance() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(3);
    });
  }

  QueryBuilder<AddressModel, AddressModel, QAfterDistinct>
      distinctByUnconfirmedBalance() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(4);
    });
  }

  QueryBuilder<AddressModel, AddressModel, QAfterDistinct>
      distinctByNeedsUpdating() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(5);
    });
  }

  QueryBuilder<AddressModel, AddressModel, QAfterDistinct> distinctByUtxos() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(6);
    });
  }

  QueryBuilder<AddressModel, AddressModel, QAfterDistinct>
      distinctByUtxoHistory() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(7);
    });
  }
}

extension AddressModelQueryProperty1
    on QueryBuilder<AddressModel, AddressModel, QProperty> {
  QueryBuilder<AddressModel, int, QAfterProperty> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(0);
    });
  }

  QueryBuilder<AddressModel, String, QAfterProperty> addressProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(1);
    });
  }

  QueryBuilder<AddressModel, String, QAfterProperty> statusProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(2);
    });
  }

  QueryBuilder<AddressModel, int, QAfterProperty> confirmedBalanceProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(3);
    });
  }

  QueryBuilder<AddressModel, int, QAfterProperty> unconfirmedBalanceProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(4);
    });
  }

  QueryBuilder<AddressModel, bool, QAfterProperty> needsUpdatingProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(5);
    });
  }

  QueryBuilder<AddressModel, List<int>, QAfterProperty> utxosProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(6);
    });
  }

  QueryBuilder<AddressModel, List<String>, QAfterProperty>
      utxoHistoryProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(7);
    });
  }
}

extension AddressModelQueryProperty2<R>
    on QueryBuilder<AddressModel, R, QAfterProperty> {
  QueryBuilder<AddressModel, (R, int), QAfterProperty> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(0);
    });
  }

  QueryBuilder<AddressModel, (R, String), QAfterProperty> addressProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(1);
    });
  }

  QueryBuilder<AddressModel, (R, String), QAfterProperty> statusProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(2);
    });
  }

  QueryBuilder<AddressModel, (R, int), QAfterProperty>
      confirmedBalanceProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(3);
    });
  }

  QueryBuilder<AddressModel, (R, int), QAfterProperty>
      unconfirmedBalanceProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(4);
    });
  }

  QueryBuilder<AddressModel, (R, bool), QAfterProperty>
      needsUpdatingProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(5);
    });
  }

  QueryBuilder<AddressModel, (R, List<int>), QAfterProperty> utxosProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(6);
    });
  }

  QueryBuilder<AddressModel, (R, List<String>), QAfterProperty>
      utxoHistoryProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(7);
    });
  }
}

extension AddressModelQueryProperty3<R1, R2>
    on QueryBuilder<AddressModel, (R1, R2), QAfterProperty> {
  QueryBuilder<AddressModel, (R1, R2, int), QOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(0);
    });
  }

  QueryBuilder<AddressModel, (R1, R2, String), QOperations> addressProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(1);
    });
  }

  QueryBuilder<AddressModel, (R1, R2, String), QOperations> statusProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(2);
    });
  }

  QueryBuilder<AddressModel, (R1, R2, int), QOperations>
      confirmedBalanceProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(3);
    });
  }

  QueryBuilder<AddressModel, (R1, R2, int), QOperations>
      unconfirmedBalanceProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(4);
    });
  }

  QueryBuilder<AddressModel, (R1, R2, bool), QOperations>
      needsUpdatingProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(5);
    });
  }

  QueryBuilder<AddressModel, (R1, R2, List<int>), QOperations> utxosProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(6);
    });
  }

  QueryBuilder<AddressModel, (R1, R2, List<String>), QOperations>
      utxoHistoryProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(7);
    });
  }
}
