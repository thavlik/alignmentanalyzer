package main

import (
	"context"
	"crypto/rand"
	"math/big"
	"testing"

	"github.com/pkg/errors"
	"github.com/thavlik/needlesv/pkg/needle"
)

func randomDNASequence(length int) string {
	// Generate a random DNA sequence of the given length.
	const letters = "ACGT"
	result := make([]byte, length)
	m := big.NewInt(int64(len(letters)))
	for i := range result {
		n, _ := rand.Int(rand.Reader, m)
		result[i] = letters[n.Int64()]
	}
	return string(result)
}

func doBenchmarkAlign(b *testing.B, aSeqLen int, bSeqLen int) {
	for i := 0; i < b.N; i++ {
		_, err := needle.Run(context.TODO(), &needle.Input{
			GapOpen:   10.0,
			GapExtend: 0.5,
			EndOpen:   10.0,
			EndExtend: 0.5,
			SeqA:      randomDNASequence(aSeqLen),
			SeqB:      randomDNASequence(bSeqLen),
		})
		if err != nil {
			b.Fatal(errors.Wrap(err, "Run"))
		}
	}
}

func BenchmarkAlign30(b *testing.B) {
	for i := 0; i < b.N; i++ {
		doBenchmarkAlign(b, 30, 30)
	}
}

func BenchmarkAlign50(b *testing.B) {
	for i := 0; i < b.N; i++ {
		doBenchmarkAlign(b, 50, 50)
	}
}

func BenchmarkAlign200(b *testing.B) {
	for i := 0; i < b.N; i++ {
		doBenchmarkAlign(b, 200, 200)
	}
}

func BenchmarkAlign500(b *testing.B) {
	for i := 0; i < b.N; i++ {
		doBenchmarkAlign(b, 500, 500)
	}
}

func BenchmarkAlign1000(b *testing.B) {
	for i := 0; i < b.N; i++ {
		doBenchmarkAlign(b, 1000, 1000)
	}
}

func BenchmarkAlign5000(b *testing.B) {
	for i := 0; i < b.N; i++ {
		doBenchmarkAlign(b, 5000, 5000)
	}
}
