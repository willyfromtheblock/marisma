# Marisma
A new utxo server written and dart and inspired by electrumx.  
Made awesome by Prisma and gRPC.

## Core principiles 
- comes with no client session management or throttling (third party tools can reverse proxy gRPC no problem)
- serving speed over parsing speed
- only utxo history is kept, all other transactions are discarded 

## Prerequisites
- docker compose
- supported coin with RPC and REST access enabled

## Get started
- overwrite values in docker-compose.yml accordingly
- run ./deploy.sh
- create .env file containing DATABASE_URL, e.g. DATABASE_URL=postgres://postgres:postgres@localhost:5432/marisma
- ??? 
- you now have a marisma instance

## Development
### Generate proto files with  
`protoc --dart_out=grpc:lib/src/generated -Iprotos protos/marisma.proto`

### Handle Prisma with 
`npx prisma generate`
`dart run build_runner build`
`npx prisma db push`