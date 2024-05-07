FROM golang:latest AS builder
WORKDIR /app

# https://tailscale.com/kb/1118/custom-derp-servers/
RUN CGO_ENABLED=0 GOOS=linux go install -tags netgo -ldflags '-w -extldflags "-static"' tailscale.com/cmd/derper@main

FROM alpine:latest
WORKDIR /app

RUN apk --no-cache add ca-certificates
RUN mkdir /app/certs

ENV DERP_HOSTNAME example.com
ENV DERP_CERTMODE letsencrypt
ENV DERP_ADDR :443
ENV DERP_VERIFY_CLIENTS false
ENV DERP_HTTP_PORT 80
ENV DERP_STUN_ENABLE true
ENV DERP_STUN_PORT 3478

COPY --from=builder /go/bin/derper .

VOLUME ["/app/certs"]

CMD /app/derper --hostname=$DERP_HOSTNAME \
    --a=$DERP_ADDR \
    --certdir=/app/certs \
    --verify-clients=$DERP_VERIFY_CLIENTS \
    --certmode=$DERP_CERTMODE \
    --http-port=$DERP_HTTP_PORT \
    --stun=$DERP_STUN_ENABLE \
    --stun-port=$DERP_STUN_PORT

# derper --help
# 使用方法说明:
#   -a string
#         服务器HTTP/HTTPS监听地址，格式为":port"、"ip:port"或IPv6的"[ip]:port"。如果省略IP地址，则默认监听所有接口。如果端口为443或使用-manual证书模式，则提供HTTPS服务，否则提供HTTP服务。 (默认 ":443")
#   -accept-connection-burst int
#         接受新连接的突发限制 (默认 9223372036854775807)
#   -accept-connection-limit float
#         接受新连接的速率限制 (默认 +Inf)
#   -bootstrap-dns-names string
#         可选的、以逗号分隔的主机名列表，这些主机名将在/bootstrap-dns上提供
#   -c string
#         配置文件路径
#   -certdir string
#         存储Let's Encrypt证书的目录，如果地址的端口为:443 
#   -certmode string
#         获取证书的模式。可能的选项包括：manual, letsencrypt (默认 "letsencrypt")
#   -derp
#         是否运行DERP服务器。设置为false的唯一原因是如果你正在停用服务器，但希望保持其引导DNS功能仍在运行。 (默认 true)
#   -dev
#         在本地开发模式下运行 (会覆盖 -a)
#   -hostname string
#         Let's Encrypt的主机名，如果地址的端口为:443 (默认 "derp.tailscale.com")
#   -http-port int
#         提供HTTP服务的端口。设置为-1以禁用。侦听器绑定到与-a标志指定的相同IP（如果有）。 (默认 80)
#   -mesh-psk-file string
#         如果非空，为包含网格预共享密钥文件的路径。它应该包含一些十六进制字符串；空白将被修剪。
#   -mesh-with string
#         可选的、以逗号分隔的主机名列表，用于网格连接；列表中可以包含服务器自己的主机名
#   -stun
#         是否运行STUN服务器。它将绑定到与--addr标志值相同的IP（如果有）。 (默认 true)
#   -stun-port int
#         提供STUN服务的UDP端口。监听器绑定到与-a标志指定的相同IP（如果有）。 (默认 3478)
#   -tcp-keepalive-time duration
#         TCP保活时间 (默认 10m0s)
#   -tcp-user-timeout duration
#         TCP用户超时时间 (默认 15s)
#   -unpublished-bootstrap-dns-names string
#         可选的、以逗号分隔的主机名列表，这些主机名将在/bootstrap-dns上提供，但不会公布在列表中
#   -verify-client-url string
#         如果非空，是一个准入控制器URL，用于允许客户端连接；参见 tailcfg.DERPAdmitClientRequest
#   -verify-client-url-fail-open
#         如果无法访问--verify-client-url，是否放行 (默认 true)
#   -verify-clients
#         通过本地tailscaled实例验证连接到此DERP服务器的客户端。
#   -version
#         打印版本并退出