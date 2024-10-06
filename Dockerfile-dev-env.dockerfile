FROM debian:12

RUN apt-get update && apt-get install -y \
    curl \
    git \
    vim \
    wget \
    unzip \
    make \
    gcc \
    build-essential

ENV GO_VERSION=1.23.2
RUN curl -OL https://go.dev/dl/go${GO_VERSION}.linux-amd64.tar.gz
RUN tar -C /usr/local -xzf go${GO_VERSION}.linux-amd64.tar.gz
RUN rm go${GO_VERSION}.linux-amd64.tar.gz

ENV PATH=$PATH:/usr/local/go/bin
ENV GOPATH=/go
ENV PATH=$PATH:$GOPATH/bin

WORKDIR /workspace

RUN go install github.com/go-delve/delve/cmd/dlv@latest
RUN go install golang.org/x/tools/gopls@latest
RUN go install github.com/golangci/golangci-lint/cmd/golangci-lint@latest
RUN go install github.com/goreleaser/goreleaser/v2@latest

CMD ["bash"]
