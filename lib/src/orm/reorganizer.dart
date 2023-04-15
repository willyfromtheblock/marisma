// import 'dart:convert';
// import 'dart:io';

// import 'package:isar/isar.dart';
// import 'package:logger/logger.dart';
// import 'package:marisma/src/orm/stromberry_orm.dart';
// import 'package:stormberry/stormberry.dart';

// import '../models/address.dart';
// import '../models/block.dart';
// import '../models/utxo.dart';
// import '../tools/logger.dart';

// class Reorganizer {
//   static final Map<String, Reorganizer> _cache = <String, Reorganizer>{};
//   late Database _db;
//   late Logger _logger;
//   Map<String, String> env = Platform.environment;

//   factory Reorganizer() {
//     return _cache.putIfAbsent('isar', () => Reorganizer._internal());
//   }
//   Reorganizer._internal();

//   Future<void> _deleteBlocks(int height) async {
//     await _db.writeTxn(
//       () async {
//         await _db.blocks
//             .where()
//             .idGreaterThan(height, include: true)
//             .deleteAll();
//       },
//     );
//   }

//   Future<void> _deleteUtxo(Utxo utxo) async {
//     await _db.writeTxn(
//       () async => await _db.utxos.delete(utxo.id),
//     );

//     for (var address in utxo.addresses) {
//       await _db.writeTxn(
//         () async {
//           final addrInIsar = await _db.addressModels.getByAddress(address);

//           if (addrInIsar != null) {
//             addrInIsar.needsUpdating = true;
//             await _db.addressModels.put(addrInIsar);
//           }
//         },
//       );
//     }
//   }

//   Future<void> _restoreUtxos(int reorgHeight, int heightInIsar) async {
//     for (var i = reorgHeight; i <= heightInIsar; i++) {
//       //loop through affected blocks
//       final addresses = await _db.addressModels
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

//           await _db.writeTxn(() async {
//             await _db.addressModels.put(addr);
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

//   Future<void> performPostgresReorg(int reorgHeight) async {
//     LoggerWrapper().init();
//     _logger = LoggerWrapper().logger;

//     _db = await StormberryORM().init();
//     _logger.d('Reorganizer DB opened.');

//     final heightInPostgres = await StormberryORM().getHeightInPostgres();

//     List<Future<void>> futures = [];

//     //delete blocks greater than height
//     futures.add(_deleteBlocks(reorgHeight));

//     //delete utxos greater than height and remove from utxo history
//     final utxos = await _db.utxos.queryUtxos(
//       QueryParams(
//         where: 'block >= $reorgHeight AND block > 0',
//       ),
//     );

//     for (var utxo in utxos) {
//       _logger.d('Reorganizer delete utxo ${utxo.txid} ${utxo.txpos}');
//       futures.add(_deleteUtxo(utxo));
//     }

//     //restore utxos from address history for affected blocks
//     futures.add(_restoreUtxos(reorgHeight, heightInPostgres));

//     //execute futures
//     await Future.wait(futures).onError(
//       (e, _) {
//         _logger.e(e.toString());
//         throw Exception(e.toString());
//       },
//     );
//   }
// }
