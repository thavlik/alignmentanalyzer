package needle

import (
	"bytes"
	"context"
	"crypto/rand"
	"fmt"
	"math/big"
	"os"
	"os/exec"

	"github.com/pkg/errors"
)

// execNeedle executes the needle command with the provided sequences.
func execNeedle(ctx context.Context, input *Input) (*NeedleResult, error) {
	// Generate a random number to create unique temporary file names.
	r, err := rand.Int(rand.Reader, big.NewInt(100000000))
	if err != nil {
		return nil, errors.Wrap(err, "generate random number")
	}

	// Write the first sequence to a temporary file.
	apath := fmt.Sprintf("/tmp/in-%s.aseq", r.String())
	if err := os.WriteFile(apath, []byte(input.SeqA), 0644); err != nil {
		return nil, errors.Wrap(err, "write aseq")
	}
	defer os.Remove(apath)

	// Write the second sequence to a temporary file.
	bpath := fmt.Sprintf("/tmp/in-%s.bseq", r.String())
	if err := os.WriteFile(bpath, []byte(input.SeqB), 0644); err != nil {
		return nil, errors.Wrap(err, "write bseq")
	}
	defer os.Remove(bpath)

	// Prepare the command to run needle.
	cmd := exec.CommandContext(
		ctx,
		"needle",
		"-auto",
		"-snucleotide1",
		"-snucleotide2",
		"-datafile", "EDNAFULL",
		"-aformat3", "pair",
		"-outfile", "/dev/stdout",
		"-gapopen", fmt.Sprintf("%.1f", input.GapOpen),
		"-gapextend", fmt.Sprintf("%.1f", input.GapExtend),
		"-endopen", fmt.Sprintf("%.1f", input.EndOpen),
		"-endextend", fmt.Sprintf("%.1f", input.EndExtend),
		"-asequence", apath,
		"-bsequence", bpath,
	)

	// Set up buffers to capture standard output and error.
	var stdout, stderr bytes.Buffer
	cmd.Stdout = &stdout
	cmd.Stderr = &stderr

	// Run the command and capture the output.
	if err := cmd.Run(); err != nil {
		return nil, errors.Wrapf(err, "command: stdout=%s, stderr=%s", stdout.String(), stderr.String())
	}

	// Decode the result from the command output.
	result, err := decodeResult(ctx, bytes.NewReader(stdout.Bytes()))
	if err != nil {
		return nil, errors.Wrap(err, "decode result")
	}

	return &NeedleResult{
		Alignments: result,
		Stdout:     stdout.String(),
		Stderr:     stderr.String(),
	}, nil
}
