package main

import (
	"context"
	"crypto/tls"
	"crypto/x509"
	"github.com/RodrigoMattosoSilveira/react-grpc-go/constants"
	"github.com/RodrigoMattosoSilveira/react-grpc-go/grpc/pingpong"
	"google.golang.org/grpc"
	"google.golang.org/grpc/credentials"
	"io/ioutil"
	"log"
)

func main() {
	ctx := context.Background()
	// Load our TLS certificate and use grpc/credentials to create new transport credentials
	creds := credentials.NewTLS(loadTLSCfg())
	// Create a new connection using the transport credentials
	conn, err := grpc.DialContext(ctx, "localhost:9990", grpc.WithTransportCredentials(creds))

	if err != nil {
		log.Fatal(err)
	}
	defer conn.Close()
	// A new GRPC client to use
	client := pingpong.NewPingPongClient(conn)

	pong, err := client.Ping(ctx, &pingpong.PingRequest{})
	if err != nil {
		log.Fatal(err)
	}
	log.Println(pong)
}

// loadTLSCfg will load a certificate and create a tls config
func loadTLSCfg() *tls.Config {
	//b, _ := ioutil.ReadFile("/Users/rodrigosilveira/projects/react-grpc-go/cert/server.crt")
	//b, _ := ioutil.ReadFile(constants.CertDir + "server.crt")
	b, _ := ioutil.ReadFile(constants.CertDir + "server-cert.pem")
	cp := x509.NewCertPool()
	if !cp.AppendCertsFromPEM(b) {
		log.Fatal("credentials: failed to append certificates")
	}
	config := &tls.Config{
		InsecureSkipVerify: false,
		RootCAs:            cp,
	}
	return config
}
