package needle

import (
	"context"

	"github.com/pkg/errors"
)

// Command line options for EMBOSS needle.
type Input struct {
	GapOpen   float64 `json:"gapopen"`   // the gap open penalty
	GapExtend float64 `json:"gapextend"` // the gap extend penalty
	EndOpen   float64 `json:"endopen"`   // the end open penalty
	EndExtend float64 `json:"endextend"` // the end extend penalty
	SeqA      string  `json:"seqa"`      // the full first sequence
	SeqB      string  `json:"seqb"`      // the full second sequence
}

// A structure that richly represents an alignment between two sequences.
type Alignment struct {
	StartA int64  `json:"startA"` // Start index of the first sequence
	EndA   int64  `json:"endA"`   // End index of the first sequence
	StartB int64  `json:"startB"` // Start index of the second sequence
	EndB   int64  `json:"endB"`   // End index of the second sequence
	SeqA   string `json:"seqA"`   // The first sequence in the alignment
	Data   string `json:"data"`   // The alignment data (e.g., gaps, matches)
	SeqB   string `json:"seqB"`   // The second sequence in the alignment
}

// A structure that richly represents results from invoking needle.
type NeedleResult struct {
	Alignments []Alignment `json:"alignments"` // List of alignments found
	Stdout     string      `json:"stdout"`     // Raw stdout from the needle command
	Stderr     string      `json:"stderr"`     // Raw stderr from the needle command
}

// Output structure that contains results from running needle in both directions.
type Output struct {
	Forward  *NeedleResult `json:"forward"`
	Backward *NeedleResult `json:"backward"`
}

// Run invokes needle with the provided configuration.
func Run(ctx context.Context, input *Input) (*Output, error) {
	// Run needle with both sequences forwards.
	forward, err := execNeedle(ctx, input)
	if err != nil {
		return nil, errors.Wrap(err, "exec needle")
	}

	// Reverse the second sequence and run needle again.
	reversed := new(Input)
	*reversed = *input // Copy the input
	reversed.SeqB = reverse(input.SeqB)
	backward, err := execNeedle(ctx, reversed)
	if err != nil {
		return nil, errors.Wrap(err, "exec needle")
	}

	return &Output{
		Forward:  forward,
		Backward: backward,
	}, nil
}

// reverse reverses the input string.
func reverse(s string) string {
	r := make([]byte, len(s))
	for i := 0; i < len(s); i++ {
		r[i] = s[len(s)-1-i]
	}
	return string(r)
}
