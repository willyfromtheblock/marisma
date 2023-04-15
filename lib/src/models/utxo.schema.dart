// ignore_for_file: annotate_overrides

part of 'utxo.dart';

extension UtxoRepositories on Database {
  UtxoRepository get utxos => UtxoRepository._(this);
}

abstract class UtxoRepository
    implements
        ModelRepository,
        KeyedModelRepositoryInsert<UtxoInsertRequest>,
        ModelRepositoryUpdate<UtxoUpdateRequest>,
        ModelRepositoryDelete<int> {
  factory UtxoRepository._(Database db) = _UtxoRepository;

  Future<UtxoView?> queryUtxo(int id);
  Future<List<UtxoView>> queryUtxos([QueryParams? params]);
}

class _UtxoRepository extends BaseRepository
    with
        KeyedRepositoryInsertMixin<UtxoInsertRequest>,
        RepositoryUpdateMixin<UtxoUpdateRequest>,
        RepositoryDeleteMixin<int>
    implements UtxoRepository {
  _UtxoRepository(super.db) : super(tableName: 'utxos', keyName: 'id');

  @override
  Future<UtxoView?> queryUtxo(int id) {
    return queryOne(id, UtxoViewQueryable());
  }

  @override
  Future<List<UtxoView>> queryUtxos([QueryParams? params]) {
    return queryMany(UtxoViewQueryable(), params);
  }

  @override
  Future<List<int>> insert(List<UtxoInsertRequest> requests) async {
    if (requests.isEmpty) return [];
    var values = QueryValues();
    var rows = await db.query(
      'INSERT INTO "utxos" ( "flagged_for_delete", "txid", "txpos", "value", "block", "addresses", "address_model_address" )\n'
      'VALUES ${requests.map((r) => '( ${values.add(r.flaggedForDelete)}:boolean, ${values.add(r.txid)}:text, ${values.add(r.txpos)}:int8, ${values.add(r.value)}:float8, ${values.add(r.block)}:int8, ${values.add(r.addresses)}:_text, ${values.add(r.addressModelAddress)}:text )').join(', ')}\n'
      'RETURNING "id"',
      values.values,
    );
    var result = rows.map<int>((r) => TextEncoder.i.decode(r.toColumnMap()['id'])).toList();

    return result;
  }

  @override
  Future<void> update(List<UtxoUpdateRequest> requests) async {
    if (requests.isEmpty) return;
    var values = QueryValues();
    await db.query(
      'UPDATE "utxos"\n'
      'SET "flagged_for_delete" = COALESCE(UPDATED."flagged_for_delete", "utxos"."flagged_for_delete"), "txid" = COALESCE(UPDATED."txid", "utxos"."txid"), "txpos" = COALESCE(UPDATED."txpos", "utxos"."txpos"), "value" = COALESCE(UPDATED."value", "utxos"."value"), "block" = COALESCE(UPDATED."block", "utxos"."block"), "addresses" = COALESCE(UPDATED."addresses", "utxos"."addresses"), "address_model_address" = COALESCE(UPDATED."address_model_address", "utxos"."address_model_address")\n'
      'FROM ( VALUES ${requests.map((r) => '( ${values.add(r.flaggedForDelete)}:boolean::boolean, ${values.add(r.id)}:int8::int8, ${values.add(r.txid)}:text::text, ${values.add(r.txpos)}:int8::int8, ${values.add(r.value)}:float8::float8, ${values.add(r.block)}:int8::int8, ${values.add(r.addresses)}:_text::_text, ${values.add(r.addressModelAddress)}:text::text )').join(', ')} )\n'
      'AS UPDATED("flagged_for_delete", "id", "txid", "txpos", "value", "block", "addresses", "address_model_address")\n'
      'WHERE "utxos"."id" = UPDATED."id"',
      values.values,
    );
  }
}

class UtxoInsertRequest {
  UtxoInsertRequest({
    required this.flaggedForDelete,
    required this.txid,
    required this.txpos,
    required this.value,
    required this.block,
    required this.addresses,
    this.addressModelAddress,
  });

  final bool flaggedForDelete;
  final String txid;
  final int txpos;
  final double value;
  final int block;
  final List<String> addresses;
  final String? addressModelAddress;
}

class UtxoUpdateRequest {
  UtxoUpdateRequest({
    this.flaggedForDelete,
    required this.id,
    this.txid,
    this.txpos,
    this.value,
    this.block,
    this.addresses,
    this.addressModelAddress,
  });

  final bool? flaggedForDelete;
  final int id;
  final String? txid;
  final int? txpos;
  final double? value;
  final int? block;
  final List<String>? addresses;
  final String? addressModelAddress;
}

class UtxoViewQueryable extends KeyedViewQueryable<UtxoView, int> {
  @override
  String get keyName => 'id';

  @override
  String encodeKey(int key) => TextEncoder.i.encode(key);

  @override
  String get query => 'SELECT "utxos".*'
      'FROM "utxos"';

  @override
  String get tableAlias => 'utxos';

  @override
  UtxoView decode(TypedMap map) => UtxoView(
      flaggedForDelete: map.get('flagged_for_delete'),
      id: map.get('id'),
      txid: map.get('txid'),
      txpos: map.get('txpos'),
      value: map.get('value'),
      block: map.get('block'),
      addresses: map.getListOpt('addresses') ?? const []);
}

class UtxoView {
  UtxoView({
    required this.flaggedForDelete,
    required this.id,
    required this.txid,
    required this.txpos,
    required this.value,
    required this.block,
    required this.addresses,
  });

  final bool flaggedForDelete;
  final int id;
  final String txid;
  final int txpos;
  final double value;
  final int block;
  final List<String> addresses;
}
