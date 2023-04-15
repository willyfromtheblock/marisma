// ignore_for_file: annotate_overrides

part of 'block.dart';

extension BlockRepositories on Database {
  BlockRepository get blocks => BlockRepository._(this);
}

abstract class BlockRepository
    implements
        ModelRepository,
        ModelRepositoryInsert<BlockInsertRequest>,
        ModelRepositoryUpdate<BlockUpdateRequest>,
        ModelRepositoryDelete<int> {
  factory BlockRepository._(Database db) = _BlockRepository;

  Future<BlockView?> queryBlock(int id);
  Future<List<BlockView>> queryBlocks([QueryParams? params]);
}

class _BlockRepository extends BaseRepository
    with
        RepositoryInsertMixin<BlockInsertRequest>,
        RepositoryUpdateMixin<BlockUpdateRequest>,
        RepositoryDeleteMixin<int>
    implements BlockRepository {
  _BlockRepository(super.db) : super(tableName: 'blocks', keyName: 'id');

  @override
  Future<BlockView?> queryBlock(int id) {
    return queryOne(id, BlockViewQueryable());
  }

  @override
  Future<List<BlockView>> queryBlocks([QueryParams? params]) {
    return queryMany(BlockViewQueryable(), params);
  }

  @override
  Future<void> insert(List<BlockInsertRequest> requests) async {
    if (requests.isEmpty) return;
    var values = QueryValues();
    await db.query(
      'INSERT INTO "blocks" ( "id", "hash", "blocktime" )\n'
      'VALUES ${requests.map((r) => '( ${values.add(r.id)}:int8, ${values.add(r.hash)}:text, ${values.add(r.blocktime)}:int8 )').join(', ')}\n',
      values.values,
    );
  }

  @override
  Future<void> update(List<BlockUpdateRequest> requests) async {
    if (requests.isEmpty) return;
    var values = QueryValues();
    await db.query(
      'UPDATE "blocks"\n'
      'SET "hash" = COALESCE(UPDATED."hash", "blocks"."hash"), "blocktime" = COALESCE(UPDATED."blocktime", "blocks"."blocktime")\n'
      'FROM ( VALUES ${requests.map((r) => '( ${values.add(r.id)}:int8::int8, ${values.add(r.hash)}:text::text, ${values.add(r.blocktime)}:int8::int8 )').join(', ')} )\n'
      'AS UPDATED("id", "hash", "blocktime")\n'
      'WHERE "blocks"."id" = UPDATED."id"',
      values.values,
    );
  }
}

class BlockInsertRequest {
  BlockInsertRequest({
    required this.id,
    required this.hash,
    required this.blocktime,
  });

  final int id;
  final String hash;
  final int blocktime;
}

class BlockUpdateRequest {
  BlockUpdateRequest({
    required this.id,
    this.hash,
    this.blocktime,
  });

  final int id;
  final String? hash;
  final int? blocktime;
}

class BlockViewQueryable extends KeyedViewQueryable<BlockView, int> {
  @override
  String get keyName => 'id';

  @override
  String encodeKey(int key) => TextEncoder.i.encode(key);

  @override
  String get query => 'SELECT "blocks".*'
      'FROM "blocks"';

  @override
  String get tableAlias => 'blocks';

  @override
  BlockView decode(TypedMap map) =>
      BlockView(id: map.get('id'), hash: map.get('hash'), blocktime: map.get('blocktime'));
}

class BlockView {
  BlockView({
    required this.id,
    required this.hash,
    required this.blocktime,
  });

  final int id;
  final String hash;
  final int blocktime;
}
