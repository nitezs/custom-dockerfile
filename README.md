# Environment Variables

| Name                | Description                                                                                                                                                                  | Default Value |
| ------------------- | ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ------------- |
| DERP_HOSTNAME       | Specifies the domain for the DERP server.                                                                                                                                    | `example.com` |
| DERP_CERTMODE       | Determines the SSL/TLS certificate management mode. Options: `manual`, `letsencrypt`                                                                                         | `letsencrypt` |
| DERP_ADDR           | Sets the server address and port to bind to.                                                                                                                                 | `:443`        |
| DERP_VERIFY_CLIENTS | Whether to verify clients connecting to the DERP server. [reference](https://tailscale.com/kb/1118/custom-derp-servers#optional-restricting-client-access-to-your-derp-node) | `false`       |
| DERP_HTTP_PORT      | Sets the port for the HTTP server.                                                                                                                                           | `80`          |
| DERP_STUN_ENABLE    | Whether to enable STUN.                                                                                                                                                      | `true`        |
| DERP_STUN_PORT      | Sets the port for the STUN server.                                                                                                                                           | `3478`        |

# Volumes

| Name       | Description                                      |
| ---------- | ------------------------------------------------ |
| /app/certs | Directory where SSL/TLS certificates are stored. |

# Usage

```shell
docker run -d --name derper \
  -p 80:80 -p 443:443 -p 3478:3478 \
  -e DERP_DOMAIN=example.com \
  nite07/tailscale-derp-docker:latest
```

[Adding DERP servers to your tailnet](https://tailscale.com/kb/1118/custom-derp-servers#step-2-adding-derp-servers-to-your-tailnet)
