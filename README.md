# Environment Variables

| Name          | Description                                                                          | Default Value |
| ------------- | ------------------------------------------------------------------------------------ | ------------- |
| DERP_HOSTNAME | Specifies the domain for the DERP server.                                            | `example.com` |
| DERP_CERTMODE | Determines the SSL/TLS certificate management mode. Options: `manual`, `letsencrypt` | `letsencrypt` |
| DERP_ADDR     | Sets the server address and port to bind to.                                         | `:443`        |

# Volumes

| Name       | Description                                      |
| ---------- | ------------------------------------------------ |
| /app/certs | Directory where SSL/TLS certificates are stored. |

# Usage

## Running Directly with SSL/TLS

```shell
docker run -d --name derper \
  -p 443:443 -p 3478:3478 \
  -e DERP_DOMAIN=example.com \
  -e DERP_CERTMODE=manual \
  -v /path/to/certs:/app/certs \
  nite07/tailscale-derp-docker:latest
```

## Running Behind a Reverse Proxy

```shell
docker run -d --name derper \
  -p 8080:80 -p 3478:3478 \
  -e DERP_DOMAIN=example.com \
  -e DERP_ADDR=:80 \
  nite07/tailscale-derp-docker:latest
```

## Adding DERP servers to your tailnet

reference: https://tailscale.com/kb/1118/custom-derp-servers#step-2-adding-derp-servers-to-your-tailnet
