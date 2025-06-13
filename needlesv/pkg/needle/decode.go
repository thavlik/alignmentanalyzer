package needle

import (
	"bufio"
	"context"
	"fmt"
	"io"
	"strconv"
	"strings"
	"unicode"

	"github.com/pkg/errors"
)

// decodeResult decodes the result from the needle output into a structured format.
func decodeResult(ctx context.Context, r io.Reader) ([]Alignment, error) {
	scanner := bufio.NewScanner(r)
	if err := seekBody(scanner); err != nil {
		return nil, errors.Wrap(err, "seek body")
	}
	var alignments []Alignment
	var current *Alignment
	for {
		if !scanner.Scan() {
			if err := scanner.Err(); err != nil {
				return nil, errors.Wrap(err, "scanner")
			}
			break
		}
		line := scanner.Text()
		if strings.HasPrefix(line, "#") {
			// Comment line, skip it.
			continue
		}
		trim := strings.TrimSpace(line)
		if trim == "" {
			// This may be a blank line or it could be a line for the alignment,
			// and there is no homology.
			continue
		}
		//fmt.Printf("$$$ %s\n", line)
		parts := strings.Fields(trim)
		startIndex, err := strconv.ParseInt(parts[0], 10, 64)
		if err == nil {
			endIndex, err := strconv.ParseInt(parts[2], 10, 64)
			if err != nil {
				return nil, errors.Wrap(err, "parse end index")
			}
			// Index is valid, so this is a line with a sequence.
			if current == nil {
				// Create a new alignment entry.
				trim := strings.TrimLeftFunc(line, unicode.IsSpace)[len(parts[0]):]
				trim = trim[:len(trim)-len(parts[2])]
				trim = strings.TrimSpace(trim)
				current = &Alignment{
					StartA: startIndex,
					EndA:   endIndex,
					SeqA:   trim,
				}
			} else {
				// Current alignment object already exists, so this is the
				// second sequence in the alignment.
				trim := strings.TrimLeftFunc(line, unicode.IsSpace)[len(parts[0]):]
				cut := len(line) - len(trim) + 1
				trim = trim[:len(trim)-len(parts[2])]
				trim = strings.TrimSpace(trim)
				current.StartB = startIndex
				current.EndB = endIndex
				current.SeqB = trim
				if current.Data != "" {
					// Fix the alignment data
					if len(current.Data) < cut {
						// Sanity check: if the data is too short, return an error.
						return nil, fmt.Errorf("alignment data is too short: %d < %d, line='%s', data='%s', aseq='%s', bseq='%s'", len(current.Data), cut, line, current.Data, current.SeqA, current.SeqB)
					}
					current.Data = current.Data[cut:]
				}
				alignments = append(alignments, *current)
				current = nil // Reset current for the next alignment
			}
		} else {
			if current == nil {
				// If current is nil, we are not in an alignment context,
				continue
			}
			// A non-empty line that does not start with a number.
			// Assume this is a line with alignment itself, e.g. | or .
			// The leading spaces will be trimmed off when the
			// following sequence is processed.
			current.Data = line
		}
	}
	return alignments, nil
}

// seekBody seeks to the body of the needle output, skipping any initial comments.
func seekBody(scanner *bufio.Scanner) error {
	expected := "#======================================="
	for {
		if !scanner.Scan() {
			if err := scanner.Err(); err != nil {
				return err
			}
			return errors.New("unexpected end of input")
		}
		line := scanner.Text()
		line = strings.TrimSpace(line)
		if line == "" {
			continue
		}
		if line == expected {
			return nil
		}
	}
}
