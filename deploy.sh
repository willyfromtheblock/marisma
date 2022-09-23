mkdir hive
git pull
docker compose build --no-cache dart_utxo_server
docker compose up -d