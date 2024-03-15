FROM golang:1.20

WORKDIR /go/src/app

COPY . .

RUN go build -mod=vendor -o /go/bin/app

ENV PORT=8080

CMD ["/bin/bash"]