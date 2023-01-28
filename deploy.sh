mkdir isar
git pull
docker compose build --no-cache marisma
docker compose down
docker compose up -d