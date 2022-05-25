FROM europe-docker.pkg.dev/yanzi-1143/yanzi-docker/yanzi/fiona-maven-gitlab-java-11:4.10.9
RUN apk add --no-cache libcap
RUN setcap cap_net_bind_service=+ep /usr/lib/jvm/default-jvm/jre/bin/java && \
    echo "/lib:/usr/local/lib:/usr/lib:/usr/lib/jvm/default-jvm/jre/lib/amd64:/usr/lib/jvm/default-jvm/jre/lib/amd64/jli:/usr/lib/jvm/default-jvm/jre/lib/amd64/server" > /etc/ld-musl-x86_64.path

