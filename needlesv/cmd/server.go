package main

import (
	"os"

	"github.com/spf13/cobra"
	"github.com/thavlik/needlesv/pkg/server"
)

var serverArgs struct {
	port       int
	corsHeader string
}

var serverCmd = &cobra.Command{
	Use:  "server",
	Args: cobra.NoArgs,
	PreRunE: func(cmd *cobra.Command, args []string) error {
		if v, ok := os.LookupEnv("CORS_HEADER"); ok {
			serverArgs.corsHeader = v
		}
		return nil
	},
	RunE: func(cmd *cobra.Command, args []string) error {
		return server.Entry(
			cmd.Context(),
			serverArgs.port,
			serverArgs.corsHeader,
			DefaultLog,
		)
	},
}

func init() {
	rootCmd.AddCommand(serverCmd)
	serverCmd.PersistentFlags().IntVarP(&serverArgs.port, "port", "p", 80, "http service port")
	serverCmd.Flags().StringVar(&serverArgs.corsHeader, "cors-header", "", "Access-Control-Allow-Origin header")
}
