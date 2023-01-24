# Marisma
A new utxo server written and dart and inspired by electrumx.  
Made awesome by Isar, Alfred and GRPC.
## Prerequisites
- docker compose
- supported coin with RPC and REST access enabled

## Development
### Generate proto files with  
`protoc --dart_out=grpc:lib/src/generated -Iprotos protos/marisma.proto`

### Generate Isar files with 
`dart run build_runner build`