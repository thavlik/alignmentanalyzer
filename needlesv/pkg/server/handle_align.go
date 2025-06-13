package server

import (
	"encoding/json"
	"net/http"

	"github.com/pkg/errors"
	"github.com/thavlik/needlesv/pkg/needle"
)

func (s *Server) handleAlign() http.HandlerFunc {
	return s.handler(
		http.MethodPost,
		func(w http.ResponseWriter, r *http.Request) error {
			var input needle.Input
			if err := json.NewDecoder(r.Body).Decode(&input); err != nil {
				return err
			}
			result, err := needle.Run(r.Context(), &input)
			if err != nil {
				return errors.Wrap(err, "needle")
			}
			return json.NewEncoder(w).Encode(result)
		},
	)
}
