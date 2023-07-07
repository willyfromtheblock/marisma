mkdir isar
git pull
docker compose build --no-cache --pull marisma
docker compose down
docker compose up -d