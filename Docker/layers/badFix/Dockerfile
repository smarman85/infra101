FROM golang:1.20

WORKDIR /go/src/app

COPY . .

RUN go build -mod=vendor -o /go/bin/app

ENV PORT=8090

# for demo only, don't actually use this
RUN rm -rf /go/src/app

CMD ["/bin/bash"]