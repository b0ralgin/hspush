 
```bash
stack install proto-lens
protoc --plugin=protoc-gen-haskell=`which proto-lens-protoc` --haskell_out=src/Grpc  proto/server.proto    
```


