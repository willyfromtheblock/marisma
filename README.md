# Marisma
A new utxo server written in Dart. Inspired by electrumx.  
Made awesome by SurrealDB and gRPC.

## Core principiles 
- comes with no client session management or throttling; third party tools can reverse proxy gRPC no problem and handle this, if needed
- serving speed over parsing speed
- only utxo history is kept, all other transactions are discarded 

## Prerequisites
- docker compose
- supported coin with RPC and REST access enabled
- built coinlib (e. g. dart run coinlib:build_macos on macOS)

## Get started
- create .env file accordingly, .env.example is available
- run ./deploy.sh
- ??? 
- you now have a marisma instance

## Development
### Generate gRPC proto files with  
`protoc --dart_out=grpc:lib/src/generated -Iprotos protos/marisma.proto`