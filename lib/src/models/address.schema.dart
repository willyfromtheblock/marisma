// ignore_for_file: annotate_overrides

part of 'address.dart';

extension AddressRepositories on Database {
  AddressRepository get addresses => AddressRepository._(this);
}

abstract class AddressRepository
    implements
        ModelRepository,
        ModelRepositoryInsert<AddressInsertRequest>,
        ModelRepositoryUpdate<AddressUpdateRequest>,
        ModelRepositoryDelete<String> {
  factory AddressRepository._(Database db) = _AddressRepository;

  Future<AddressView?> queryAddress(String address);
  Future<List<AddressView>> queryAddresses([QueryParams? params]);
}

class _AddressRepository extends BaseRepository
    with
        RepositoryInsertMixin<AddressInsertRequest>,
        RepositoryUpdateMixin<AddressUpdateRequest>,
        RepositoryDeleteMixin<String>
    implements AddressRepository {
  _AddressRepository(super.db) : super(tableName: 'addresses', keyName: 'address');

  @override
  Future<AddressView?> queryAddress(String address) {
    return queryOne(address, AddressViewQueryable());
  }

  @override
  Future<List<AddressView>> queryAddresses([QueryParams? params]) {
    return queryMany(AddressViewQueryable(), params);
  }

  @override
  Future<void> insert(List<AddressInsertRequest> requests) async {
    if (requests.isEmpty) return;
    var values = QueryValues();
    await db.query(
      'INSERT INTO "addresses" ( "needs_updating", "address", "status", "confirmed_balance", "unconfirmed_balance", "utxo_history" )\n'
      'VALUES ${requests.map((r) => '( ${values.add(r.needsUpdating)}:boolean, ${values.add(r.address)}:text, ${values.add(r.status)}:text, ${values.add(r.confirmedBalance)}:int8, ${values.add(r.unconfirmedBalance)}:int8, ${values.add(r.utxoHistory)}:_text )').join(', ')}\n',
      values.values,
    );
  }

  @override
  Future<void> update(List<AddressUpdateRequest> requests) async {
    if (requests.isEmpty) return;
    var values = QueryValues();
    await db.query(
      'UPDATE "addresses"\n'
      'SET "needs_updating" = COALESCE(UPDATED."needs_updating", "addresses"."needs_updating"), "status" = COALESCE(UPDATED."status", "addresses"."status"), "confirmed_balance" = COALESCE(UPDATED."confirmed_balance", "addresses"."confirmed_balance"), "unconfirmed_balance" = COALESCE(UPDATED."unconfirmed_balance", "addresses"."unconfirmed_balance"), "utxo_history" = COALESCE(UPDATED."utxo_history", "addresses"."utxo_history")\n'
      'FROM ( VALUES ${requests.map((r) => '( ${values.add(r.needsUpdating)}:boolean::boolean, ${values.add(r.address)}:text::text, ${values.add(r.status)}:text::text, ${values.add(r.confirmedBalance)}:int8::int8, ${values.add(r.unconfirmedBalance)}:int8::int8, ${values.add(r.utxoHistory)}:_text::_text )').join(', ')} )\n'
      'AS UPDATED("needs_updating", "address", "status", "confirmed_balance", "unconfirmed_balance", "utxo_history")\n'
      'WHERE "addresses"."address" = UPDATED."address"',
      values.values,
    );
  }
}

class AddressInsertRequest {
  AddressInsertRequest({
    required this.needsUpdating,
    required this.address,
    required this.status,
    required this.confirmedBalance,
    required this.unconfirmedBalance,
    required this.utxoHistory,
  });

  final bool needsUpdating;
  final String address;
  final String status;
  final int confirmedBalance;
  final int unconfirmedBalance;
  final List<String> utxoHistory;
}

class AddressUpdateRequest {
  AddressUpdateRequest({
    this.needsUpdating,
    required this.address,
    this.status,
    this.confirmedBalance,
    this.unconfirmedBalance,
    this.utxoHistory,
  });

  final bool? needsUpdating;
  final String address;
  final String? status;
  final int? confirmedBalance;
  final int? unconfirmedBalance;
  final List<String>? utxoHistory;
}

class AddressViewQueryable extends KeyedViewQueryable<AddressView, String> {
  @override
  String get keyName => 'address';

  @override
  String encodeKey(String key) => TextEncoder.i.encode(key);

  @override
  String get query => 'SELECT "addresses".*, "utxos"."data" as "utxos"'
      'FROM "addresses"'
      'LEFT JOIN ('
      '  SELECT "utxos"."address_address",'
      '    to_jsonb(array_agg("utxos".*)) as data'
      '  FROM (${UtxoViewQueryable().query}) "utxos"'
      '  GROUP BY "utxos"."address_address"'
      ') "utxos"'
      'ON "addresses"."address" = "utxos"."address_address"';

  @override
  String get tableAlias => 'addresses';

  @override
  AddressView decode(TypedMap map) => AddressView(
      needsUpdating: map.get('needs_updating'),
      address: map.get('address'),
      status: map.get('status'),
      confirmedBalance: map.get('confirmed_balance'),
      unconfirmedBalance: map.get('unconfirmed_balance'),
      utxos: map.getListOpt('utxos', UtxoViewQueryable().decoder) ?? const [],
      utxoHistory: map.getListOpt('utxo_history') ?? const []);
}

class AddressView {
  AddressView({
    required this.needsUpdating,
    required this.address,
    required this.status,
    required this.confirmedBalance,
    required this.unconfirmedBalance,
    required this.utxos,
    required this.utxoHistory,
  });

  final bool needsUpdating;
  final String address;
  final String status;
  final int confirmedBalance;
  final int unconfirmedBalance;
  final List<UtxoView> utxos;
  final List<String> utxoHistory;
}
