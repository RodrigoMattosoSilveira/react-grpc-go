# react-grpc-go
Learning how to integrate gRPC in a React / GO environment

# Installing PROTOBUF to generate web files
## make: protoc: Permission denied
I had to remove all `protoc` instances and reinstrall `protobuf` from scratch

## protoc-gen-js: program not found or is not executable
This is a bug in protobuf@21. I used [this recipe](https://github.com/protocolbuffers/protobuf-javascript/issues/127#issuecomment-1204202870) to fix it. I modified it by  placing `protoc-gen-js` in `usr/local/bin`.

# Building GRPC Server and Client 
## IDE does not recognize the import commands and types
I created `main.go` using `touch main.go`, preventing the IDE from knowing that `main.go` was a `GO` file!

# Building webapp
## npm ERR! cb.apply is not a function
I used this [SO Recipe](https://stackoverflow.com/questions/53657920/i-cant-install-react-using-npx-create-react-app)

## This site can’t be reached, localhost refused to connect.
### For Chrome
Used the instructions in the [SO Answer](https://stackoverflow.com/questions/7580508/getting-chrome-to-accept-self-signed-localhost-certificate)
### For Opera
### For Firefox
### mkcert
[mkcert](https://github.com/FiloSottile/mkcert) is a simple tool for making locally-trusted development certificates. It requires no configuration. Did not use it, but it has promise