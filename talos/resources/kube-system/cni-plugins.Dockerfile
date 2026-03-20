FROM nixery.dev/shell/curl/gnutar/gzip AS builder

RUN curl -sSLo cni-plugins.tgz https://github.com/containernetworking/plugins/releases/download/v1.9.1/cni-plugins-linux-amd64-v1.9.1.tgz
RUN tar xvf cni-plugins.tgz --directory /tmp

FROM alpine

COPY --from=builder /tmp /opt/cni/bin
