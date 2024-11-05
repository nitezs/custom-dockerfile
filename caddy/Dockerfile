FROM caddy:builder AS builder

RUN xcaddy build \
    --with github.com/caddyserver/nginx-adapter \
    --with github.com/caddy-dns/cloudflare \
    --with github.com/caddyserver/replace-response \
    --with github.com/mholt/caddy-webdav \
    --with github.com/mholt/caddy-ratelimit \
    --with github.com/WeidiDeng/caddy-cloudflare-ip \
    --with github.com/porech/caddy-maxmind-geolocation \
    --with github.com/mholt/caddy-l4/layer4

FROM caddy:latest

COPY --from=builder /usr/bin/caddy /usr/bin/caddy




