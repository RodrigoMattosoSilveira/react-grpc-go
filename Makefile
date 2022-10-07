CERT_DIR=./cert
#CERTGEN=certgen.zsh
CERTGEN=gencert.zsh
SERVER_DIR=./server
CLIENT_DIR=./client

## Generate gRPC Web files
GRPC=./grpc
GRPC_PINGPONG=$(GRPC)/pingpong
GRPC_PINGPONG_PROTO=$(GRPC_PINGPONG)/pingpong.proto
GRPC_PINGPONG_PB_GO=$(GRPC_PINGPONG)/pingpong.pb.go

export PATH := $(HOME)/.local/bin:$(PATH)

all: $(CERT_DIR)/server-cert.pem $(GRPC_PINGPONG_PB_GO) $(CLIENT_DIR)/main $(SERVER_DIR)/main

# Install certificates
$(CERT_DIR)/server-cert.pem : $(CERT_DIR)/$(CERTGEN) $(CERT_DIR)/server-ext.cnf
	$(CERT_DIR)/$(CERTGEN)

# Build Client
$(CLIENT_DIR)/main : $(CLIENT_DIR)/main.go  $(GRPC_PINGPONG_PROTO)
	go build -o $(CLIENT_DIR)/main $(CLIENT_DIR)/*.go

# Build Server
$(SERVER_DIR)/main : $(SERVER_DIR)/main.go $(SERVER_DIR)/server.go $(GRPC_PINGPONG_PROTO)
	go build -o $(SERVER_DIR)/main $(SERVER_DIR)/*.go
$(GRPC_PINGPONG_PB_GO): $(GRPC_PINGPONG_PROTO)
	protoc --js\_out=import\_style=commonjs,binary:./ \
	--grpc-web\_out=import\_style=commonjs,mode=grpcwebtext:./ \
	--go-grpc\_out=$(GRPC_PINGPONG)/ \
	--go\_out=$(GRPC_PINGPONG)/ \
	 $(GRPC_PINGPONG_PROTO)

