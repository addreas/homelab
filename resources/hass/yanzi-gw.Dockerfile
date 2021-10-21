FROM nexus.yanzinetworks.com/yanzi/fiona-maven-gitlab:4.9.9
RUN apk add --no-cache libcap
RUN setcap cap_net_bind_service=+ep /usr/lib/jvm/default-jvm/jre/bin/java && \
    echo "/lib:/usr/local/lib:/usr/lib:/usr/lib/jvm/default-jvm/jre/lib/amd64:/usr/lib/jvm/default-jvm/jre/lib/amd64/jli:/usr/lib/jvm/default-jvm/jre/lib/amd64/server" > /etc/ld-musl-x86_64.path

