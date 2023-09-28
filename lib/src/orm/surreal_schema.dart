final surrealSchema = r'''
          DEFINE EVENT flag_needs_updating_on_create_or_update ON TABLE has_utxo WHEN $event = "CREATE" OR $event = "UPDATE" THEN (
            UPDATE $after.in SET needs_update = true, needs_update_reason = $event
          );

          DEFINE EVENT flag_needs_updating_on_delete ON TABLE has_utxo WHEN $event = "DELETE" THEN (
            UPDATE $before.in SET needs_update = true, needs_update_reason = $event
          );
''';
//TODO more table schemas

     // await surrealClient.query(
        //   '''
        //   DEFINE TABLE tx_history SCHEMAFULL PERMISSIONS NONE;
        //   DEFINE FIELD in ON TABLE tx_history TYPE string;
        //   DEFINE FIELD out ON TABLE tx_history TYPE string;
        //   DEFINE INDEX history_index ON TABLE tx_history COLUMNS out UNIQUE;
        //   ''',
        // );