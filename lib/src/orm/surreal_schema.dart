final surrealSchema = r'''
          DEFINE TABLE address SCHEMAFULL;
          DEFINE FIELD address ON TABLE address TYPE string;
          DEFINE FIELD status ON TABLE address TYPE string;
          DEFINE FIELD confirmed_balance ON TABLE address TYPE int;
          DEFINE FIELD unconfirmed_balance ON TABLE address TYPE int;
          DEFINE FIELD number_of_utxos ON TABLE address TYPE int;

          DEFINE TABLE block SCHEMAFULL;
          DEFINE FIELD height ON TABLE block TYPE int;
          DEFINE FIELD hash ON TABLE block TYPE string;

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
          LET $confirmed_balance = math::round(math::product([math::sum(SELECT VALUE value FROM utxo WHERE address = $addr AND spent_on_block = 'block:-2' AND block.height >= 0), 1000000]));
          LET $unconfirmed_balance = math::round(math::product([math::sum(SELECT VALUE value FROM utxo WHERE address = $addr AND block = 'block:-1'), 1000000]));
          LET $number_of_utxos = array::first(SELECT VALUE count FROM (SELECT count() FROM utxo WHERE address = $addr AND spent_on_block = 'block:-2' GROUP BY count)) ?? 0;
          LET $old_values = SELECT address,status FROM $addr;
          LET $new_status = crypto::sha256(string::concat($confirmed_balance, $unconfirmed_balance, $number_of_utxos, $old_values));
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
''';

final surrealSchemaAfterInitialSync = r'''
          DEFINE EVENT update_on_utxo_event ON TABLE utxo THEN (
            fn::update_address($after.address)
          );
''';

final surrealSchemaTriggerInitialAddressSync = r'''
          FOR $addressToSync IN (SELECT * FROM address) {
            fn::update_address($addressToSync.id);
          };
          UPDATE blockchain:initial_sync_complete SET initial_sync_complete = true;
''';
