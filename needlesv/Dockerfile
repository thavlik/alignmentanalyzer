ARG RUNTIME_BASE_IMAGE="debian:bullseye-slim"
FROM golang:latest AS builder
WORKDIR /go/src/github.com/thavlik/needlesv
RUN apt-get update \
    && apt-get install -y emboss \
    && apt-get clean
COPY go.mod .
COPY go.sum .
RUN go mod download
COPY cmd cmd
COPY pkg pkg
WORKDIR /go/src/github.com/thavlik/needlesv/cmd
RUN GOOS=linux GOARCH=amd64 CGO_ENABLED=0 go build -o needlesv
FROM ${RUNTIME_BASE_IMAGE}
RUN apt-get update \
    && apt-get install -y emboss \
    && apt-get clean
COPY --from=builder /go/src/github.com/thavlik/needlesv/cmd/needlesv /usr/local/bin
CMD ["needlesv"]
