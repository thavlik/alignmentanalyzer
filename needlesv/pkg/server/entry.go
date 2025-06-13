package server

import (
	"context"

	"go.uber.org/zap"
)

func Entry(
	ctx context.Context,
	port int,
	corsHeader string,
	log *zap.Logger,
) error {
	ctx, cancel := context.WithCancel(ctx)
	defer cancel()

	s := NewServer(
		ctx,
		corsHeader,
		log,
	)
	defer s.ShutDown()

	return s.ListenAndServe(port)
}
