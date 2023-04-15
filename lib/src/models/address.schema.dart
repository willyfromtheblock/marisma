// ignore_for_file: annotate_overrides

part of 'address.dart';

extension AddressRepositories on Database {
  AddressModelRepository get addressModels => AddressModelRepository._(this);
}

abstract class AddressModelRepository
    implements
        ModelRepository,
        ModelRepositoryInsert<AddressModelInsertRequest>,
        ModelRepositoryUpdate<AddressModelUpdateRequest>,
        ModelRepositoryDelete<String> {
  factory AddressModelRepository._(Database db) = _AddressModelRepository;

  Future<AddressModelView?> queryAddressModel(String address);
  Future<List<AddressModelView>> queryAddressModels([QueryParams? params]);
}

class _AddressModelRepository extends BaseRepository
    with
        RepositoryInsertMixin<AddressModelInsertRequest>,
        RepositoryUpdateMixin<AddressModelUpdateRequest>,
        RepositoryDeleteMixin<String>
    implements AddressModelRepository {
  _AddressModelRepository(super.db) : super(tableName: 'address_models', keyName: 'address');

  @override
  Future<AddressModelView?> queryAddressModel(String address) {
    return queryOne(address, AddressModelViewQueryable());
  }

  @override
  Future<List<AddressModelView>> queryAddressModels([QueryParams? params]) {
    return queryMany(AddressModelViewQueryable(), params);
  }

  @override
  Future<void> insert(List<AddressModelInsertRequest> requests) async {
    if (requests.isEmpty) return;
    var values = QueryValues();
    await db.query(
      'INSERT INTO "address_models" ( "needs_updating", "address", "status", "confirmed_balance", "unconfirmed_balance", "utxo_history" )\n'
      'VALUES ${requests.map((r) => '( ${values.add(r.needsUpdating)}:boolean, ${values.add(r.address)}:text, ${values.add(r.status)}:text, ${values.add(r.confirmedBalance)}:int8, ${values.add(r.unconfirmedBalance)}:int8, ${values.add(r.utxoHistory)}:_text )').join(', ')}\n',
      values.values,
    );
  }

  @override
  Future<void> update(List<AddressModelUpdateRequest> requests) async {
    if (requests.isEmpty) return;
    var values = QueryValues();
    await db.query(
      'UPDATE "address_models"\n'
      'SET "needs_updating" = COALESCE(UPDATED."needs_updating", "address_models"."needs_updating"), "status" = COALESCE(UPDATED."status", "address_models"."status"), "confirmed_balance" = COALESCE(UPDATED."confirmed_balance", "address_models"."confirmed_balance"), "unconfirmed_balance" = COALESCE(UPDATED."unconfirmed_balance", "address_models"."unconfirmed_balance"), "utxo_history" = COALESCE(UPDATED."utxo_history", "address_models"."utxo_history")\n'
      'FROM ( VALUES ${requests.map((r) => '( ${values.add(r.needsUpdating)}:boolean::boolean, ${values.add(r.address)}:text::text, ${values.add(r.status)}:text::text, ${values.add(r.confirmedBalance)}:int8::int8, ${values.add(r.unconfirmedBalance)}:int8::int8, ${values.add(r.utxoHistory)}:_text::_text )').join(', ')} )\n'
      'AS UPDATED("needs_updating", "address", "status", "confirmed_balance", "unconfirmed_balance", "utxo_history")\n'
      'WHERE "address_models"."address" = UPDATED."address"',
      values.values,
    );
  }
}

class AddressModelInsertRequest {
  AddressModelInsertRequest({
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

class AddressModelUpdateRequest {
  AddressModelUpdateRequest({
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

class AddressModelViewQueryable extends KeyedViewQueryable<AddressModelView, String> {
  @override
  String get keyName => 'address';

  @override
  String encodeKey(String key) => TextEncoder.i.encode(key);

  @override
  String get query => 'SELECT "address_models".*, "utxos"."data" as "utxos"'
      'FROM "address_models"'
      'LEFT JOIN ('
      '  SELECT "utxos"."address_model_address",'
      '    to_jsonb(array_agg("utxos".*)) as data'
      '  FROM (${UtxoViewQueryable().query}) "utxos"'
      '  GROUP BY "utxos"."address_model_address"'
      ') "utxos"'
      'ON "address_models"."address" = "utxos"."address_model_address"';

  @override
  String get tableAlias => 'address_models';

  @override
  AddressModelView decode(TypedMap map) => AddressModelView(
      needsUpdating: map.get('needs_updating'),
      address: map.get('address'),
      status: map.get('status'),
      confirmedBalance: map.get('confirmed_balance'),
      unconfirmedBalance: map.get('unconfirmed_balance'),
      utxos: map.getListOpt('utxos', UtxoViewQueryable().decoder) ?? const [],
      utxoHistory: map.getListOpt('utxo_history') ?? const []);
}

class AddressModelView {
  AddressModelView({
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
