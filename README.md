# react-grpc-go
Learning how to integrate gRPC in a React / GO environment

# Installing PROTOBUF to generate web files
## make: protoc: Permission denied
I had to remove all `protoc` instances and reinstrall `protobuf` from scratch

## protoc-gen-js: program not found or is not executable
This is a bug in protobuf@21. I used [this recipe](https://github.com/protocolbuffers/protobuf-javascript/issues/127#issuecomment-1204202870) to fix it. I modified it by  placing `protoc-gen-js` in `usr/local/bin`.
