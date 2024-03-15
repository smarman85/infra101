FROM golang:1.20.13-bullseye AS build

COPY . /optimizeImageSize

WORKDIR /optimizeImageSize/app

RUN CGO_ENABLED=0 GOOS=linux go build \
    -ldflags="-w -s"  -o /app /optimizeImageSize/app/main.go

# Same image
# FROM golang:1.20.13-bullseye
# COPY --from=build /app /app
# CMD ["/app"]

# FROM busybox
# COPY --from=build /app /app
# CMD ["/app"]

# Scratch with certs/timezone
FROM scratch
COPY --from=build /etc/ssl/certs/ca-certificates.crt /etc/ssl/certs/
COPY --from=build /usr/share/zoneinfo /usr/share/zoneinfo
COPY --from=build /app /app
CMD ["/app"]