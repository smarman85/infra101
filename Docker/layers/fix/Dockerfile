FROM golang:1.20 AS base

WORKDIR /go/src/app

ARG password=defaultValue

COPY go.mod go.sum vendor ./

RUN go mod download

COPY . .

RUN go build -mod=vendor -o /go/bin/app


# stage 2
FROM alpine:3.14

# https://stackoverflow.com/questions/66963068/docker-alpine-executable-binary-not-found-even-if-in-path
#RUN apk add libc6-compat

COPY --from=base /go/bin/app /app

ENV PORT=8100

CMD ["/bin/sh"]