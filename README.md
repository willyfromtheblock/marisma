# Marisma
A new utxo server written and dart.  
Made awesome by Isar and GRPC.
## Prerequisites
- docker compose
- supported coin with RPC and REST access enabled

## Development
### Generate proto files with  
`protoc --dart_out=grpc:lib/src/generated -Iprotos protos/marisma.proto`

### Generate isar files with 
`dart run build_runner build`