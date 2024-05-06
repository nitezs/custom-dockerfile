# Usage

```shell
docker run -d --name derper \
  -p 80:80 -p 443:443 -p 3478:3478 \
  -e DERP_DOMAIN=example.com \
  -v /path/to/certs:/app/certs \
  nite07/tailscale-derp-docker:latest
```

## Docker Compose

```yaml
version: "3.8"
services:
  derper:
    container_name: derper
    ports:
      - 80:80
      - 443:443
      - 3478:3478
    environment:
      - DERP_DOMAIN=example.com
    volumes:
      - /path/to/certs:/app/certs
    image: nite07/tailscale-derp-docker:latest
```

# Env

| Name        | Description        |
| ----------- | ------------------ |
| DERP_DOMAIN | The domain to use. |
