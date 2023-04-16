// import 'dart:convert';
// import 'dart:io';

// import 'package:logger/logger.dart';
// import '../tools/logger.dart';

// class Reorganizer {
//   static final Map<String, Reorganizer> _cache = <String, Reorganizer>{};
//   late Isar _isar;
//   late Logger _logger;
//   Map<String, String> env = Platform.environment;

//   factory Reorganizer() {
//     return _cache.putIfAbsent('isar', () => Reorganizer._internal());
//   }
//   Reorganizer._internal();

//   Future<void> _deleteBlocks(int height) async {
//     await _isar.writeTxn(
//       () async {
//         await _isar.blocks
//             .where()
//             .idGreaterThan(height, include: true)
//             .deleteAll();
//       },
//     );
//   }

//   Future<void> _deleteUtxo(Utxo utxo) async {
//     await _isar.writeTxn(
//       () async => await _isar.utxos.delete(utxo.id),
//     );

//     for (var address in utxo.addresses) {
//       await _isar.writeTxn(
//         () async {
//           final addrInIsar = await _isar.addressModels.getByAddress(address);

//           if (addrInIsar != null) {
//             addrInIsar.needsUpdating = true;
//             await _isar.addressModels.put(addrInIsar);
//           }
//         },
//       );
//     }
//   }

//   Future<void> _restoreUtxos(int reorgHeight, int heightInIsar) async {
//     for (var i = reorgHeight; i <= heightInIsar; i++) {
//       //loop through affected blocks
//       final addresses = await _isar.addressModels
//           .filter()
//           .utxoHistoryElementContains('block":$i')
//           .findAll();

//       for (AddressModel addr in addresses) {
//         final matchingUtxos = addr.utxoHistory.where(
//           (utxoInHistory) => utxoInHistory.contains(
//             'block":$i',
//           ),
//         );

//         for (String matchedUtxo in matchingUtxos) {
//           final decoded = jsonDecode(matchedUtxo);
//           _logger.i(
//             'Reorganizer restoring utxo ${decoded['txid']} - ${decoded['tx_pos']} for ${addr.address}',
//           );

//           //remove from this addresses history
//           final historyCopy = List<String>.from(addr.utxoHistory);
//           historyCopy.remove(matchedUtxo);
//           addr.utxoHistory = historyCopy;
//           addr.needsUpdating = true;

//           await _isar.writeTxn(() async {
//             await _isar.addressModels.put(addr);
//           });

//           await IsarORM().createUtxo(
//             Utxo(
//               addresses: [addr.address],
//               block: decoded['block'],
//               txid: decoded['txid'],
//               txpos: decoded['tx_pos'],
//               value: decoded['value'],
//             ),
//           );
//         }
//       }
//     }
//   }

//   Future<void> performIsarReorg(int reorgHeight) async {
//     LoggerWrapper().init();
//     _logger = LoggerWrapper().logger;

//     _isar = await Isar.open(
//       [
//         AddressModelSchema,
//         BlockSchema,
//         UtxoSchema,
//       ],
//       directory: env["LOCAL_TESTING"] == "true" ? 'isar' : '/app/isar/',
//     );

//     IsarORM().initWithPrismaReference(_isar);

//     _logger.d('Reorganizer isar opened.');

//     final heightInIsar = await IsarORM().getHeightInIsar();

//     List<Future<void>> futures = [];

//     //delete blocks greater than height
//     futures.add(_deleteBlocks(reorgHeight));

//     //delete utxos greater than height and remove from utxo history
//     final utxos = await _isar.utxos
//         .filter()
//         .blockGreaterThan(reorgHeight, include: true)
//         .not()
//         .blockLessThan(0) //don't delete mempool utxos on reorg
//         .findAll();

//     for (var utxo in utxos) {
//       _logger.d('Reorganizer delete utxo ${utxo.txid} ${utxo.txpos}');
//       futures.add(_deleteUtxo(utxo));
//     }

//     //restore utxos from address history for affected blocks
//     futures.add(_restoreUtxos(reorgHeight, heightInIsar));

//     //execute futures
//     await Future.wait(futures).onError(
//       (e, _) {
//         _logger.e(e.toString());
//         throw Exception(e.toString());
//       },
//     );
//   }
// }
