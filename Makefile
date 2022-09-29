CERT=./cert
CERTGEN=certgen.zsh
PINGPONG=./pingpong
UISRC=./ui/src
export PATH := $(HOME)/.local/bin:$(PATH)

## Install certificates
.PHONY: cert
cert:
	$(CERT)/$(CERTGEN)

## Generate gRPC WEB files
.PHONY: protoweb
protoweb:
	protoc --js\_out=import\_style=commonjs,binary:$(UISRC)/ \
	--grpc-web\_out=import\_style=commonjs,mode=grpcwebtext:$(UISRC)/ \
	--go-grpc\_out=$(PINGPONG)/ \
	--go\_out=$(PINGPONG)/ \
	 $(PINGPONG)/service.proto

## Generate gRPC SERVER files
.PHONY: protoserver
protoserver:
	protoc --go_out. \
	--go_opt=paths=source_relative \
	--go-grpc_out=require_unimplemented_servers=false:$(PINGPONG)/ \
	--go-grpc_opt=paths=source_relative \
	$(PINGPONG)/service.proto
