package main

import (
	"context"
	pingpong2 "github.com/RodrigoMattosoSilveira/react-grpc-go/grpc/pingpong"
)

// Server is the Logic handler for the server
// It has to fulfill the GRPC schema generated Interface
// In this case its only 1 function called Ping
type Server struct {
	pingpong2.UnimplementedPingPongServer
}

// Ping fullfills the requirement for PingPong Server interface
func (s *Server) Ping(ctx context.Context, ping *pingpong2.PingRequest) (*pingpong2.PongResponse, error) {
	return &pingpong2.PongResponse{
		Ok: true,
	}, nil
}
