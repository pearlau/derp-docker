FROM golang:alpine AS builder
RUN go install tailscale.com/cmd/derper@latest

FROM alpine:latest
RUN apk update; \
    apk upgrade; \
    apk add --no-cache tzdata ca-certificates; \
    rm -rf /var/cache/apk/* /tmp/* /var/tmp/* $HOME/.cache

WORKDIR /app

COPY --from=builder /go/bin/derper .
ENTRYPOINT ["/app/derper"]
