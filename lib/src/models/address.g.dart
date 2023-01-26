// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'address.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters

extension GetAddressModelCollection on Isar {
  IsarCollection<AddressModel> get addressModels => this.collection();
}

const AddressModelSchema = CollectionSchema(
  name: r'AddressModel',
  id: 7170850215293375062,
  properties: {
    r'address': PropertySchema(
      id: 0,
      name: r'address',
      type: IsarType.string,
    ),
    r'confirmedBalance': PropertySchema(
      id: 1,
      name: r'confirmedBalance',
      type: IsarType.long,
    ),
    r'needsUpdating': PropertySchema(
      id: 2,
      name: r'needsUpdating',
      type: IsarType.bool,
    ),
    r'status': PropertySchema(
      id: 3,
      name: r'status',
      type: IsarType.string,
    ),
    r'unconfirmedBalance': PropertySchema(
      id: 4,
      name: r'unconfirmedBalance',
      type: IsarType.long,
    )
  },
  estimateSize: _addressModelEstimateSize,
  serialize: _addressModelSerialize,
  deserialize: _addressModelDeserialize,
  deserializeProp: _addressModelDeserializeProp,
  idName: r'id',
  indexes: {
    r'address': IndexSchema(
      id: -259407546592846288,
      name: r'address',
      unique: true,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'address',
          type: IndexType.hash,
          caseSensitive: true,
        )
      ],
    )
  },
  links: {
    r'utxos': LinkSchema(
      id: -4097434629454181895,
      name: r'utxos',
      target: r'Utxo',
      single: false,
    ),
    r'transactions': LinkSchema(
      id: 5689002463644763805,
      name: r'transactions',
      target: r'Tx',
      single: false,
    )
  },
  embeddedSchemas: {},
  getId: _addressModelGetId,
  getLinks: _addressModelGetLinks,
  attach: _addressModelAttach,
  version: '3.0.6-dev.0',
);

int _addressModelEstimateSize(
  AddressModel object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.address.length * 3;
  bytesCount += 3 + object.status.length * 3;
  return bytesCount;
}

void _addressModelSerialize(
  AddressModel object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.address);
  writer.writeLong(offsets[1], object.confirmedBalance);
  writer.writeBool(offsets[2], object.needsUpdating);
  writer.writeString(offsets[3], object.status);
  writer.writeLong(offsets[4], object.unconfirmedBalance);
}

AddressModel _addressModelDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = AddressModel(
    address: reader.readString(offsets[0]),
  );
  object.confirmedBalance = reader.readLong(offsets[1]);
  object.id = id;
  object.needsUpdating = reader.readBool(offsets[2]);
  object.status = reader.readString(offsets[3]);
  object.unconfirmedBalance = reader.readLong(offsets[4]);
  return object;
}

P _addressModelDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readString(offset)) as P;
    case 1:
      return (reader.readLong(offset)) as P;
    case 2:
      return (reader.readBool(offset)) as P;
    case 3:
      return (reader.readString(offset)) as P;
    case 4:
      return (reader.readLong(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _addressModelGetId(AddressModel object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _addressModelGetLinks(AddressModel object) {
  return [object.utxos, object.transactions];
}

void _addressModelAttach(
    IsarCollection<dynamic> col, Id id, AddressModel object) {
  object.id = id;
  object.utxos.attach(col, col.isar.collection<Utxo>(), r'utxos', id);
  object.transactions
      .attach(col, col.isar.collection<Tx>(), r'transactions', id);
}

extension AddressModelByIndex on IsarCollection<AddressModel> {
  Future<AddressModel?> getByAddress(String address) {
    return getByIndex(r'address', [address]);
  }

  AddressModel? getByAddressSync(String address) {
    return getByIndexSync(r'address', [address]);
  }

  Future<bool> deleteByAddress(String address) {
    return deleteByIndex(r'address', [address]);
  }

  bool deleteByAddressSync(String address) {
    return deleteByIndexSync(r'address', [address]);
  }

  Future<List<AddressModel?>> getAllByAddress(List<String> addressValues) {
    final values = addressValues.map((e) => [e]).toList();
    return getAllByIndex(r'address', values);
  }

  List<AddressModel?> getAllByAddressSync(List<String> addressValues) {
    final values = addressValues.map((e) => [e]).toList();
    return getAllByIndexSync(r'address', values);
  }

  Future<int> deleteAllByAddress(List<String> addressValues) {
    final values = addressValues.map((e) => [e]).toList();
    return deleteAllByIndex(r'address', values);
  }

  int deleteAllByAddressSync(List<String> addressValues) {
    final values = addressValues.map((e) => [e]).toList();
    return deleteAllByIndexSync(r'address', values);
  }

  Future<Id> putByAddress(AddressModel object) {
    return putByIndex(r'address', object);
  }

  Id putByAddressSync(AddressModel object, {bool saveLinks = true}) {
    return putByIndexSync(r'address', object, saveLinks: saveLinks);
  }

  Future<List<Id>> putAllByAddress(List<AddressModel> objects) {
    return putAllByIndex(r'address', objects);
  }

  List<Id> putAllByAddressSync(List<AddressModel> objects,
      {bool saveLinks = true}) {
    return putAllByIndexSync(r'address', objects, saveLinks: saveLinks);
  }
}

extension AddressModelQueryWhereSort
    on QueryBuilder<AddressModel, AddressModel, QWhere> {
  QueryBuilder<AddressModel, AddressModel, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension AddressModelQueryWhere
    on QueryBuilder<AddressModel, AddressModel, QWhereClause> {
  QueryBuilder<AddressModel, AddressModel, QAfterWhereClause> idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<AddressModel, AddressModel, QAfterWhereClause> idNotEqualTo(
      Id id) {
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

  QueryBuilder<AddressModel, AddressModel, QAfterWhereClause> idGreaterThan(
      Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<AddressModel, AddressModel, QAfterWhereClause> idLessThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<AddressModel, AddressModel, QAfterWhereClause> idBetween(
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

  QueryBuilder<AddressModel, AddressModel, QAfterWhereClause> addressEqualTo(
      String address) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'address',
        value: [address],
      ));
    });
  }

  QueryBuilder<AddressModel, AddressModel, QAfterWhereClause> addressNotEqualTo(
      String address) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'address',
              lower: [],
              upper: [address],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'address',
              lower: [address],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'address',
              lower: [address],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'address',
              lower: [],
              upper: [address],
              includeUpper: false,
            ));
      }
    });
  }
}

extension AddressModelQueryFilter
    on QueryBuilder<AddressModel, AddressModel, QFilterCondition> {
  QueryBuilder<AddressModel, AddressModel, QAfterFilterCondition>
      addressEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'address',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AddressModel, AddressModel, QAfterFilterCondition>
      addressGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'address',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AddressModel, AddressModel, QAfterFilterCondition>
      addressLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'address',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AddressModel, AddressModel, QAfterFilterCondition>
      addressBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'address',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AddressModel, AddressModel, QAfterFilterCondition>
      addressStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'address',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AddressModel, AddressModel, QAfterFilterCondition>
      addressEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'address',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AddressModel, AddressModel, QAfterFilterCondition>
      addressContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'address',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AddressModel, AddressModel, QAfterFilterCondition>
      addressMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'address',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AddressModel, AddressModel, QAfterFilterCondition>
      addressIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'address',
        value: '',
      ));
    });
  }

  QueryBuilder<AddressModel, AddressModel, QAfterFilterCondition>
      addressIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'address',
        value: '',
      ));
    });
  }

  QueryBuilder<AddressModel, AddressModel, QAfterFilterCondition>
      confirmedBalanceEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'confirmedBalance',
        value: value,
      ));
    });
  }

  QueryBuilder<AddressModel, AddressModel, QAfterFilterCondition>
      confirmedBalanceGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'confirmedBalance',
        value: value,
      ));
    });
  }

  QueryBuilder<AddressModel, AddressModel, QAfterFilterCondition>
      confirmedBalanceLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'confirmedBalance',
        value: value,
      ));
    });
  }

  QueryBuilder<AddressModel, AddressModel, QAfterFilterCondition>
      confirmedBalanceBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'confirmedBalance',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<AddressModel, AddressModel, QAfterFilterCondition> idEqualTo(
      Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<AddressModel, AddressModel, QAfterFilterCondition> idGreaterThan(
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

  QueryBuilder<AddressModel, AddressModel, QAfterFilterCondition> idLessThan(
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

  QueryBuilder<AddressModel, AddressModel, QAfterFilterCondition> idBetween(
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

  QueryBuilder<AddressModel, AddressModel, QAfterFilterCondition>
      needsUpdatingEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'needsUpdating',
        value: value,
      ));
    });
  }

  QueryBuilder<AddressModel, AddressModel, QAfterFilterCondition> statusEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'status',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AddressModel, AddressModel, QAfterFilterCondition>
      statusGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'status',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AddressModel, AddressModel, QAfterFilterCondition>
      statusLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'status',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AddressModel, AddressModel, QAfterFilterCondition> statusBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'status',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AddressModel, AddressModel, QAfterFilterCondition>
      statusStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'status',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AddressModel, AddressModel, QAfterFilterCondition>
      statusEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'status',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AddressModel, AddressModel, QAfterFilterCondition>
      statusContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'status',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AddressModel, AddressModel, QAfterFilterCondition> statusMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'status',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AddressModel, AddressModel, QAfterFilterCondition>
      statusIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'status',
        value: '',
      ));
    });
  }

  QueryBuilder<AddressModel, AddressModel, QAfterFilterCondition>
      statusIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'status',
        value: '',
      ));
    });
  }

  QueryBuilder<AddressModel, AddressModel, QAfterFilterCondition>
      unconfirmedBalanceEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'unconfirmedBalance',
        value: value,
      ));
    });
  }

  QueryBuilder<AddressModel, AddressModel, QAfterFilterCondition>
      unconfirmedBalanceGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'unconfirmedBalance',
        value: value,
      ));
    });
  }

  QueryBuilder<AddressModel, AddressModel, QAfterFilterCondition>
      unconfirmedBalanceLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'unconfirmedBalance',
        value: value,
      ));
    });
  }

  QueryBuilder<AddressModel, AddressModel, QAfterFilterCondition>
      unconfirmedBalanceBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'unconfirmedBalance',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension AddressModelQueryObject
    on QueryBuilder<AddressModel, AddressModel, QFilterCondition> {}

extension AddressModelQueryLinks
    on QueryBuilder<AddressModel, AddressModel, QFilterCondition> {
  QueryBuilder<AddressModel, AddressModel, QAfterFilterCondition> utxos(
      FilterQuery<Utxo> q) {
    return QueryBuilder.apply(this, (query) {
      return query.link(q, r'utxos');
    });
  }

  QueryBuilder<AddressModel, AddressModel, QAfterFilterCondition>
      utxosLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'utxos', length, true, length, true);
    });
  }

  QueryBuilder<AddressModel, AddressModel, QAfterFilterCondition>
      utxosIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'utxos', 0, true, 0, true);
    });
  }

  QueryBuilder<AddressModel, AddressModel, QAfterFilterCondition>
      utxosIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'utxos', 0, false, 999999, true);
    });
  }

  QueryBuilder<AddressModel, AddressModel, QAfterFilterCondition>
      utxosLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'utxos', 0, true, length, include);
    });
  }

  QueryBuilder<AddressModel, AddressModel, QAfterFilterCondition>
      utxosLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'utxos', length, include, 999999, true);
    });
  }

  QueryBuilder<AddressModel, AddressModel, QAfterFilterCondition>
      utxosLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(
          r'utxos', lower, includeLower, upper, includeUpper);
    });
  }

  QueryBuilder<AddressModel, AddressModel, QAfterFilterCondition> transactions(
      FilterQuery<Tx> q) {
    return QueryBuilder.apply(this, (query) {
      return query.link(q, r'transactions');
    });
  }

  QueryBuilder<AddressModel, AddressModel, QAfterFilterCondition>
      transactionsLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'transactions', length, true, length, true);
    });
  }

  QueryBuilder<AddressModel, AddressModel, QAfterFilterCondition>
      transactionsIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'transactions', 0, true, 0, true);
    });
  }

  QueryBuilder<AddressModel, AddressModel, QAfterFilterCondition>
      transactionsIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'transactions', 0, false, 999999, true);
    });
  }

  QueryBuilder<AddressModel, AddressModel, QAfterFilterCondition>
      transactionsLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'transactions', 0, true, length, include);
    });
  }

  QueryBuilder<AddressModel, AddressModel, QAfterFilterCondition>
      transactionsLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'transactions', length, include, 999999, true);
    });
  }

  QueryBuilder<AddressModel, AddressModel, QAfterFilterCondition>
      transactionsLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(
          r'transactions', lower, includeLower, upper, includeUpper);
    });
  }
}

extension AddressModelQuerySortBy
    on QueryBuilder<AddressModel, AddressModel, QSortBy> {
  QueryBuilder<AddressModel, AddressModel, QAfterSortBy> sortByAddress() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'address', Sort.asc);
    });
  }

  QueryBuilder<AddressModel, AddressModel, QAfterSortBy> sortByAddressDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'address', Sort.desc);
    });
  }

  QueryBuilder<AddressModel, AddressModel, QAfterSortBy>
      sortByConfirmedBalance() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'confirmedBalance', Sort.asc);
    });
  }

  QueryBuilder<AddressModel, AddressModel, QAfterSortBy>
      sortByConfirmedBalanceDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'confirmedBalance', Sort.desc);
    });
  }

  QueryBuilder<AddressModel, AddressModel, QAfterSortBy> sortByNeedsUpdating() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'needsUpdating', Sort.asc);
    });
  }

  QueryBuilder<AddressModel, AddressModel, QAfterSortBy>
      sortByNeedsUpdatingDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'needsUpdating', Sort.desc);
    });
  }

  QueryBuilder<AddressModel, AddressModel, QAfterSortBy> sortByStatus() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'status', Sort.asc);
    });
  }

  QueryBuilder<AddressModel, AddressModel, QAfterSortBy> sortByStatusDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'status', Sort.desc);
    });
  }

  QueryBuilder<AddressModel, AddressModel, QAfterSortBy>
      sortByUnconfirmedBalance() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'unconfirmedBalance', Sort.asc);
    });
  }

  QueryBuilder<AddressModel, AddressModel, QAfterSortBy>
      sortByUnconfirmedBalanceDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'unconfirmedBalance', Sort.desc);
    });
  }
}

extension AddressModelQuerySortThenBy
    on QueryBuilder<AddressModel, AddressModel, QSortThenBy> {
  QueryBuilder<AddressModel, AddressModel, QAfterSortBy> thenByAddress() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'address', Sort.asc);
    });
  }

  QueryBuilder<AddressModel, AddressModel, QAfterSortBy> thenByAddressDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'address', Sort.desc);
    });
  }

  QueryBuilder<AddressModel, AddressModel, QAfterSortBy>
      thenByConfirmedBalance() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'confirmedBalance', Sort.asc);
    });
  }

  QueryBuilder<AddressModel, AddressModel, QAfterSortBy>
      thenByConfirmedBalanceDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'confirmedBalance', Sort.desc);
    });
  }

  QueryBuilder<AddressModel, AddressModel, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<AddressModel, AddressModel, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<AddressModel, AddressModel, QAfterSortBy> thenByNeedsUpdating() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'needsUpdating', Sort.asc);
    });
  }

  QueryBuilder<AddressModel, AddressModel, QAfterSortBy>
      thenByNeedsUpdatingDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'needsUpdating', Sort.desc);
    });
  }

  QueryBuilder<AddressModel, AddressModel, QAfterSortBy> thenByStatus() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'status', Sort.asc);
    });
  }

  QueryBuilder<AddressModel, AddressModel, QAfterSortBy> thenByStatusDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'status', Sort.desc);
    });
  }

  QueryBuilder<AddressModel, AddressModel, QAfterSortBy>
      thenByUnconfirmedBalance() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'unconfirmedBalance', Sort.asc);
    });
  }

  QueryBuilder<AddressModel, AddressModel, QAfterSortBy>
      thenByUnconfirmedBalanceDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'unconfirmedBalance', Sort.desc);
    });
  }
}

extension AddressModelQueryWhereDistinct
    on QueryBuilder<AddressModel, AddressModel, QDistinct> {
  QueryBuilder<AddressModel, AddressModel, QDistinct> distinctByAddress(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'address', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<AddressModel, AddressModel, QDistinct>
      distinctByConfirmedBalance() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'confirmedBalance');
    });
  }

  QueryBuilder<AddressModel, AddressModel, QDistinct>
      distinctByNeedsUpdating() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'needsUpdating');
    });
  }

  QueryBuilder<AddressModel, AddressModel, QDistinct> distinctByStatus(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'status', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<AddressModel, AddressModel, QDistinct>
      distinctByUnconfirmedBalance() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'unconfirmedBalance');
    });
  }
}

extension AddressModelQueryProperty
    on QueryBuilder<AddressModel, AddressModel, QQueryProperty> {
  QueryBuilder<AddressModel, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<AddressModel, String, QQueryOperations> addressProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'address');
    });
  }

  QueryBuilder<AddressModel, int, QQueryOperations> confirmedBalanceProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'confirmedBalance');
    });
  }

  QueryBuilder<AddressModel, bool, QQueryOperations> needsUpdatingProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'needsUpdating');
    });
  }

  QueryBuilder<AddressModel, String, QQueryOperations> statusProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'status');
    });
  }

  QueryBuilder<AddressModel, int, QQueryOperations>
      unconfirmedBalanceProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'unconfirmedBalance');
    });
  }
}
