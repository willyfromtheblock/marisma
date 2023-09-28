final surrealSchema = r'''
          DEFINE TABLE address SCHEMAFULL;
          DEFINE FIELD address ON TABLE address TYPE string;
          DEFINE FIELD status ON TABLE address TYPE string;
          DEFINE FIELD confirmed_balance ON TABLE address TYPE int;
          DEFINE FIELD unconfirmed_balance ON TABLE address TYPE int;
          DEFINE FIELD needs_update ON TABLE address TYPE bool;

          DEFINE TABLE block SCHEMAFULL;
          DEFINE FIELD height ON TABLE block TYPE int;
          DEFINE FIELD hash ON TABLE block TYPE string;
          DEFINE FIELD blocktime ON TABLE block TYPE int;

          DEFINE TABLE tx SCHEMAFULL;
          DEFINE FIELD txid ON TABLE tx TYPE string;
          DEFINE FIELD block ON TABLE tx TYPE int;

          DEFINE TABLE utxo SCHEMAFULL;
          DEFINE FIELD txid ON TABLE utxo TYPE record();
          DEFINE FIELD txpos ON TABLE utxo TYPE int;
          DEFINE FIELD value ON TABLE utxo TYPE float;
          DEFINE FIELD block ON TABLE utxo TYPE record();
          DEFINE FIELD addresses ON TABLE utxo TYPE array;
          DEFINE FIELD addresses.* ON TABLE utxo TYPE record();

          DEFINE EVENT flag_needs_updating_on_create_or_update ON TABLE has_utxo WHEN $event = "CREATE" OR $event = "UPDATE" THEN (
            UPDATE $after.in SET needs_update = true
          );

          DEFINE EVENT flag_needs_updating_on_delete ON TABLE has_utxo WHEN $event = "DELETE" THEN (
            UPDATE $before.in SET needs_update = true
          );
''';

     // await surrealClient.query(
        //   '''
        //   DEFINE TABLE tx_history SCHEMAFULL PERMISSIONS NONE;
        //   DEFINE FIELD in ON TABLE tx_history TYPE string;
        //   DEFINE FIELD out ON TABLE tx_history TYPE string;
        //   DEFINE INDEX history_index ON TABLE tx_history COLUMNS out UNIQUE;
        //   ''',
        // );