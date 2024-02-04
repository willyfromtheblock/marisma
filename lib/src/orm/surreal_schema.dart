final surrealSchema = r'''
          DEFINE TABLE address SCHEMAFULL;
          DEFINE FIELD address ON TABLE address TYPE string;
          DEFINE FIELD status ON TABLE address TYPE string;
          DEFINE FIELD confirmed_balance ON TABLE address TYPE int;
          DEFINE FIELD unconfirmed_balance ON TABLE address TYPE int;
          DEFINE FIELD number_of_utxos ON TABLE address TYPE int;
          DEFINE FIELD needs_update ON TABLE address TYPE bool;

          DEFINE TABLE block SCHEMAFULL;
          DEFINE FIELD height ON TABLE block TYPE int;
          DEFINE FIELD hash ON TABLE block TYPE string;

          DEFINE TABLE utxo SCHEMAFULL;
          DEFINE FIELD txid ON TABLE utxo TYPE string;
          DEFINE FIELD txpos ON TABLE utxo TYPE int;
          DEFINE FIELD value ON TABLE utxo TYPE float;
          DEFINE FIELD block ON TABLE utxo TYPE record();
          DEFINE FIELD address ON TABLE utxo TYPE record();
          DEFINE FIELD spent_on_block ON TABLE utxo TYPE record();

          DEFINE EVENT flag_needs_updating_on_create_or_update ON TABLE utxo WHEN ($event = "CREATE" OR $event = "UPDATE") AND $after.address.needs_update = false THEN (
            UPDATE $after.address SET needs_update = true
          );

          DEFINE INDEX addressIndex ON TABLE utxo COLUMNS address;

          DEFINE FUNCTION fn::update_address($addr: record()) {
          LET $confirmed_balance = math::round(math::product([math::sum(SELECT VALUE value FROM utxo WHERE address = $addr AND spent_on_block = 'block:-2'), 1000000]));
          LET $unconfirmed_balance = math::round(math::product([math::sum(SELECT VALUE value FROM utxo WHERE address = $addr AND spent_on_block = 'block:-1'), 1000000]));
          LET $number_of_utxos = array::first(SELECT VALUE count FROM (SELECT count() FROM utxo WHERE address = $addr AND spent_on_block = 'block:-2' GROUP BY count)) ?? 0;
          LET $old_values = SELECT address,status FROM $addr;
          LET $new_status = crypto::sha256(string::concat($confirmed_balance, $unconfirmed_balance, $number_of_utxos, $old_values));
          UPDATE $addr SET confirmed_balance = $confirmed_balance, unconfirmed_balance = $unconfirmed_balance, number_of_utxos = $number_of_utxos, status = $new_status, needs_update = false; 
          }
''';
