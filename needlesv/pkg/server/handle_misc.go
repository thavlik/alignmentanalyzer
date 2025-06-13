package server

import (
	"net/http"
	"os"
	"time"

	"github.com/pkg/errors"
	"go.uber.org/zap"
)

var (
	start     time.Time = time.Now()
	readyFile string    = "/etc/ready"
)

func Handle200(w http.ResponseWriter, r *http.Request) {}

func Handle404(
	log *zap.Logger,
) http.HandlerFunc {
	return func(w http.ResponseWriter, r *http.Request) {
		AddPreflightHeaders(w)
		msg := "404: the requested page could not be found"
		log.Error(r.RequestURI, zap.String("err", msg))
		http.Error(w, msg, http.StatusNotFound)
	}
}

func ReadyHandler(w http.ResponseWriter, r *http.Request) {
	if _, err := os.Stat(readyFile); err == nil {
		return
	}
	w.WriteHeader(http.StatusNotFound)
}

func SignalReady(log *zap.Logger) {
	log.Debug("signaling ready", Elapsed(start))
	if err := os.WriteFile(
		readyFile,
		[]byte{1},
		0644,
	); err != nil {
		panic(errors.Wrap(err, "failed to write ready file"))
	}
}

func Elapsed(since time.Time) zap.Field {
	return zap.String(
		"elapsed",
		time.Since(since).
			Round(time.Millisecond).
			String(),
	)
}
