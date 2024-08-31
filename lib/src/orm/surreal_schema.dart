String computeSurrealSchema(String ns, String db) {
  return "USE NS $ns; USE DB $db; $_surrealSchema";
}

final _surrealSchema = r'''
          DEFINE TABLE address SCHEMAFULL;
          DEFINE FIELD address ON TABLE address TYPE string;
          DEFINE FIELD status ON TABLE address TYPE string;
          DEFINE FIELD confirmed_balance ON TABLE address TYPE int;
          DEFINE FIELD unconfirmed_balance ON TABLE address TYPE int;
          DEFINE FIELD number_of_utxos ON TABLE address TYPE int;

          DEFINE TABLE block SCHEMAFULL;
          DEFINE FIELD height ON TABLE block TYPE int;
          DEFINE FIELD hash ON TABLE block TYPE string;
          DEFINE FIELD time ON TABLE block TYPE int;

          DEFINE TABLE utxo SCHEMAFULL;
          DEFINE FIELD txid ON TABLE utxo TYPE string;
          DEFINE FIELD txpos ON TABLE utxo TYPE int;
          DEFINE FIELD value ON TABLE utxo TYPE float;
          DEFINE FIELD block ON TABLE utxo TYPE record;
          DEFINE FIELD address ON TABLE utxo TYPE record;
          DEFINE FIELD spent_on_block ON TABLE utxo TYPE record;

          DEFINE TABLE utxo_spent_before_write SCHEMAFULL;
          DEFINE FIELD utxoId ON TABLE utxo_spent_before_write TYPE record;
          DEFINE FIELD spent_on_block ON TABLE utxo_spent_before_write TYPE record;

          DEFINE TABLE blockchain SCHEMALESS;

          DEFINE INDEX addressIndex ON TABLE utxo COLUMNS address;

          DEFINE FUNCTION fn::update_address($addr: record) {
          LET $utxos = SELECT * FROM utxo WHERE address = $addr;
          LET $confirmed_balance = math::round(math::product([math::sum(SELECT VALUE value FROM $utxos WHERE spent_on_block = <record> 'block:-2' AND block != <record> 'block:-1'), 1000000]));
          LET $unconfirmed_balance = math::round(math::product([math::sum(SELECT VALUE value FROM $utxos WHERE  block = <record> 'block:-1'), 1000000]));
          LET $number_of_utxos = array::first(SELECT VALUE count FROM (SELECT count() FROM $utxos WHERE spent_on_block = <record> 'block:-2' GROUP BY count)) ?? 0;
          LET $new_status = crypto::sha256(string::concat($confirmed_balance, $unconfirmed_balance, $number_of_utxos, $addr.address));
          UPDATE $addr SET confirmed_balance = $confirmed_balance, unconfirmed_balance = $unconfirmed_balance, number_of_utxos = $number_of_utxos, status = $new_status; 
          };

          DEFINE FUNCTION fn::merge_utxos() {
          LET $utxos_to_merge = SELECT * FROM utxo_spent_before_write;
            FOR $stored_utxo IN $utxos_to_merge {
                LET $utxo_res = SELECT id FROM $stored_utxo.utxoId;
                IF $utxo_res != [] THEN {
                UPDATE $stored_utxo.utxoId SET spent_on_block = $stored_utxo.spent_on_block;
                DELETE $stored_utxo;
                }
                END
            }
          };

          DEFINE FUNCTION fn::spend_utxo($utxoId: record, $blockHeight: int) {
          LET $utxo_to_spend = SELECT * from $utxoId;
          LET $blockHeightRecord = type::thing(string::concat("block:", $blockHeight));

          IF !$utxo_to_spend THEN {
              (CREATE utxo_spent_before_write SET utxoId = $utxoId, spent_on_block = $blockHeightRecord);
          }
          END;

          IF $utxo_to_spend AND array::first($utxo_to_spend.block) = 'block:-1' THEN 
              (UPDATE $utxoId SET block = $blockHeightRecord)
          END;

          IF $utxo_to_spend AND array::first($utxo_to_spend.spent_on_block) = 'block:-2' AND $blockHeight >= 0 THEN
              (UPDATE $utxoId SET spent_on_block = $blockHeightRecord)
          END;
          };
''';

final surrealSchemaAfterInitialSync = r'''
         DEFINE EVENT update_address_when_something_happens_in_utxo_table ON TABLE utxo WHEN $before != $after THEN (
            fn::update_address($after.address.id)
          );
''';

final surrealSchemaTriggerInitialAddressSync = r'''
          FOR $addressToSync IN (SELECT * FROM address WHERE status = '') {
            fn::update_address($addressToSync.id);
          };
          UPDATE blockchain:initial_sync_complete SET initial_sync_complete = true;
''';
