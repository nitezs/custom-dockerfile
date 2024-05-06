FROM golang:latest AS builder
WORKDIR /app

# https://tailscale.com/kb/1118/custom-derp-servers/
RUN go install tailscale.com/cmd/derper@main

FROM alpine:latest
WORKDIR /app

RUN apk --no-cache add ca-certificates
RUN mkdir /app/certs

ENV DERP_DOMAIN example.com

COPY --from=builder /go/bin/derper .

EXPOSE 80 443 3478
VOLUME ["/app/certs"]

CMD /app/derper --hostname=$DERP_DOMAIN \
    --certdir=/app/certs \
    --verify-clients=true
