package server

import (
	"context"
	"fmt"
	"net/http"
	"sync"
	"time"

	"go.uber.org/zap"
)

type Server struct {
	ctx        context.Context
	cancel     context.CancelFunc
	corsHeader string
	wg         *sync.WaitGroup
	log        *zap.Logger
}

func NewServer(
	ctx context.Context,
	corsHeader string,
	log *zap.Logger,
) *Server {
	ctx, cancel := context.WithCancel(ctx)
	return &Server{
		ctx:        ctx,
		cancel:     cancel,
		corsHeader: corsHeader,
		wg:         new(sync.WaitGroup),
		log:        log,
	}
}

func (s *Server) ListenAndServe(
	httpPort int,
) error {
	ctx, cancel := context.WithCancel(s.ctx)
	defer cancel()

	mux := http.NewServeMux()
	mux.HandleFunc("/", Handle404(s.log))
	mux.HandleFunc("/healthz", Handle200)
	mux.HandleFunc("/readyz", ReadyHandler)
	mux.HandleFunc("/align", s.handleAlign())

	srv := &http.Server{
		Handler:      mux,
		Addr:         fmt.Sprintf("0.0.0.0:%d", httpPort),
		WriteTimeout: 15 * time.Second,
		ReadTimeout:  15 * time.Second,
	}

	// Automatic graceful shutdown cannot occur within the
	// thread pool of the server because it will cause a deadlock.
	// Spawning a stray goroutine to handle shutdown is fine.
	go func() {
		<-ctx.Done()
		_ = srv.Shutdown(ctx)
	}()

	// Signal that the server is ready after a short delay.
	s.spawn(func() {
		select {
		case <-s.ctx.Done():
			return
		case <-time.After(500 * time.Millisecond):
			SignalReady(s.log)
		}
	})

	s.log.Info(
		"http server listening forever",
		zap.Int("port", httpPort),
		zap.String("corsHeader", s.corsHeader),
	)

	return srv.ListenAndServe()
}

func (s *Server) ShutDown() {
	s.cancel()
	s.wg.Wait()
}

func (s *Server) spawn(f func()) {
	s.wg.Add(1)
	go func() {
		defer s.wg.Done()
		f()
	}()
}

func (s *Server) handler(
	method string,
	f func(w http.ResponseWriter, r *http.Request) error,
) http.HandlerFunc {
	return func(w http.ResponseWriter, r *http.Request) {
		w.Header().Set("Access-Control-Allow-Origin", s.corsHeader)
		if r.Method == http.MethodOptions {
			AddPreflightHeaders(w)
			return
		}
		if err := func() (err error) {
			if method != "" && r.Method != method {
				w.WriteHeader(http.StatusBadRequest)
				return nil
			}
			return f(w, r)
		}(); err != nil {
			s.log.Error(r.RequestURI, zap.Error(err))
			http.Error(w, err.Error(), http.StatusInternalServerError)
		}
	}
}

func AddPreflightHeaders(w http.ResponseWriter) {
	w.Header().Set("Content-Type", "text/plain")
	w.Header().Set("Content-Length", "0")
	w.Header().Set("Access-Control-Max-Age", "1728000")
	w.Header().Set("Access-Control-Allow-Origin", "*")
	w.Header().Set("Access-Control-Allow-Credentials", "true")
	w.Header().Set("Access-Control-Allow-Methods", "GET, POST, OPTIONS")
	w.Header().Set("Access-Control-Allow-Headers", "AccessToken,DNT,X-CustomHeader,Keep-Alive,User-Agent,X-Requested-With,If-Modified-Since,Cache-Control,Content-Type")
	w.WriteHeader(http.StatusNoContent)
}
