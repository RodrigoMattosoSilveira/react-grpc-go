CERT=./cert
#CERTGEN=certgen.zsh
CERTGEN=gencert.zsh
PINGPONG=./pingpong
UISRC=./ui/src
SERVER_DIR=server
CLIENT_DIR=client
export PATH := $(HOME)/.local/bin:$(PATH)

## Install certificates
.PHONY: cert
cert:
	$(CERT)/$(CERTGEN)

## Generate gRPC Web files
.PHONY: protoweb
protoweb:
	protoc --js\_out=import\_style=commonjs,binary:$(UISRC)/ \
	--grpc-web\_out=import\_style=commonjs,mode=grpcwebtext:$(UISRC)/ \
	--go-grpc\_out=$(PINGPONG)/ \
	--go\_out=$(PINGPONG)/ \
	 $(PINGPONG)/service.proto

## Generate gRPC Server files
.PHONY: protoserver
protoserver:
	protoc --go_out. \
	--go_opt=paths=source_relative \
	--go-grpc_out=require_unimplemented_servers=false:$(PINGPONG)/ \
	--go-grpc_opt=paths=source_relative \
	$(PINGPONG)/service.proto

## Build Server
.PHONY:server
server:
	go build -o $(SERVER_DIR)/main $(SERVER_DIR)/*.go

## Build Client
.PHONY: client
client:
	go build -o $(CLIENT_DIR)/main $(CLIENT_DIR)/*.go

## Build both
.PHONY: cltsrvr
cltsrvr: client server
