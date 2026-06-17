FROM golang:alpine AS build

WORKDIR /go/src

RUN apk add --no-cache git
ARG VERSION_BRANCH=main
RUN git clone https://github.com/tailscale/tailscale.git --branch=$VERSION_BRANCH --depth=1
WORKDIR /go/src/tailscale

ARG TARGETARCH
RUN GOARCH=$TARGETARCH go install -v ./cmd/derper

FROM alpine:latest
RUN apk add --no-cache ca-certificates iptables iproute2 ip6tables curl

COPY --from=build /go/bin/* /usr/local/bin/
ENTRYPOINT [ "/usr/local/bin/derper" ]
