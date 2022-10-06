CERT_DIR=./cert
#CERTGEN=certgen.zsh
CERTGEN=gencert.zsh
PINGPONG=./pingpong
UISRC=./ui/src
SERVER_DIR=./server
CLIENT_DIR=./client
export PATH := $(HOME)/.local/bin:$(PATH)

all: $(CERT_DIR)/server-cert.pem $(CLIENT_DIR)/main $(SERVER_DIR)/main

# Install certificates
$(CERT_DIR)/server-cert.pem : $(CERT_DIR)/$(CERTGEN) $(CERT_DIR)/server-ext.cnf
	$(CERT_DIR)/$(CERTGEN)

# Build Client
$(CLIENT_DIR)/main : $(CLIENT_DIR)/main.go
	go build -o $(CLIENT_DIR)/main $(CLIENT_DIR)/*.go

# Build Server
$(SERVER_DIR)/main : $(SERVER_DIR)/main.go $(SERVER_DIR)/server.go
	go build -o $(SERVER_DIR)/main $(SERVER_DIR)/*.go

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
