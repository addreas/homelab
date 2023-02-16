FROM quay.io/cilium/cilium:v1.13.0

RUN apt-get update && apt-get -y --no-install-recommends install \
        build-essential \
        cmake \
        wget \
        bzip2 \
        libmnl-dev \
        libnftnl-dev \
    && wget --no-check-certificate https://www.netfilter.org/projects/iptables/files/iptables-1.8.8.tar.bz2 \
    && bunzip2 iptables-1.8.8.tar.bz2 \
    && tar xf iptables-1.8.8.tar \
    && cd iptables-1.8.8 \
    && sh autogen.sh \
    && ./configure \
    && make \
    && make install \
    && cd ..\
    && rm -r iptables-1.8.8 \
    && apt-get purge -y \
        build-essential \
        cmake \
        bzip2 \
        libmnl-dev \
        libnftnl-dev


