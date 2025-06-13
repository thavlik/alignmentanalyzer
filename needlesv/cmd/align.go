package main

import (
	"encoding/json"

	"github.com/pkg/errors"
	"github.com/spf13/cobra"
	"github.com/thavlik/needlesv/pkg/needle"
)

var alignArgs struct {
	needle.Input
}

var alignCmd = &cobra.Command{
	Use:  "align",
	Args: cobra.NoArgs,
	PreRunE: func(cmd *cobra.Command, args []string) error {
		return nil
	},
	RunE: func(cmd *cobra.Command, args []string) error {
		result, err := needle.Run(cmd.Context(), &alignArgs.Input)
		if err != nil {
			return errors.Wrap(err, "Run")
		}
		body, err := json.MarshalIndent(result, "", "  ")
		if err != nil {
			return errors.Wrap(err, "json")
		}
		if _, err := cmd.OutOrStdout().Write(body); err != nil {
			return errors.Wrap(err, "write")
		}
		return nil
	},
}

func init() {
	rootCmd.AddCommand(alignCmd)
	alignCmd.Flags().StringVarP(&alignArgs.SeqA, "aseq", "a", "ACGTACGCTATCATGCGTACGACCCCCCCACGCTATCCCCCCCCCCCCCTCTAGT", "First sequence")
	alignCmd.Flags().StringVarP(&alignArgs.SeqB, "bseq", "b", "ACTAGCATGCCAGGTTACGTATACCGTGCGTATATATCCCCCCCCCCCTAGTCATG", "Second sequence")
	alignCmd.Flags().Float64Var(&alignArgs.GapOpen, "gapopen", 10.0, "Gap open penalty")
	alignCmd.Flags().Float64Var(&alignArgs.GapExtend, "gapextend", 0.5, "Gap extend penalty")
	alignCmd.Flags().Float64Var(&alignArgs.EndOpen, "endopen", 10.0, "End open penalty")
	alignCmd.Flags().Float64Var(&alignArgs.EndExtend, "endextend", 0.5, "End extend penalty")
}
