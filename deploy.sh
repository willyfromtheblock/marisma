mkdir isar
git pull
npx prisma generate
dart run build_runner build
npx prisma db push
docker compose build --no-cache marisma
docker compose down
docker compose up -d