FROM golang:1.19-alpine AS builder
WORKDIR /go/src/github.com/gmr/template-aws-params
COPY . .
RUN apk add git make\
    && go get -u github.com/golang/dep/cmd/dep \
    && make all

FROM alpine:3.17
COPY --from=builder /go/src/github.com/gmr/template-aws-params/template-aws-params /
RUN apk add --no-cache ca-certificates

ENTRYPOINT [ "/template-aws-params" ]
