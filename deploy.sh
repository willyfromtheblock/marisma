git pull
npx prisma db push
docker compose build --no-cache marisma
docker compose down
docker compose up -d