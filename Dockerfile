FROM openjdk:8-jre-alpine as builder

LABEL maintainer="Wurstmeister"

ARG ZOOKEEPER_VERSION="3.4.14"

ENV DISTRO_NAME=zookeeper-${ZOOKEEPER_VERSION}

WORKDIR /tmp

RUN mkdir -p /opt && \
    apk add --update wget gnupg bash && \
    java -version && \
# Download Zookeeper
    wget -q "https://www.apache.org/dist/zookeeper/$DISTRO_NAME/$DISTRO_NAME.tar.gz"; \
    wget -q "https://www.apache.org/dist/zookeeper/KEYS" && \
    wget -q "https://www.apache.org/dist/zookeeper/${DISTRO_NAME}/${DISTRO_NAME}.tar.gz.asc" && \
    wget -q "https://www.apache.org/dist/zookeeper/${DISTRO_NAME}/${DISTRO_NAME}.tar.gz.sha256" && \
    wget -q "https://www.apache.org/dist/zookeeper/${DISTRO_NAME}/${DISTRO_NAME}.tar.gz.sha512" && \
# Verify download
    sha256sum -c zookeeper-${ZOOKEEPER_VERSION}.tar.gz.sha256 && \
    sha512sum -c zookeeper-${ZOOKEEPER_VERSION}.tar.gz.sha512 && \
    gpg --import KEYS && \
    gpg --verify ${DISTRO_NAME}.tar.gz.asc && \
# Install
    tar -xzf ${DISTRO_NAME}.tar.gz -C /opt && \
# Configure
    mv /opt/${DISTRO_NAME} /opt/zk && \
    echo "${ZOOKEEPER_VERSION}" > /opt/zk/VERSION && \
    mv /opt/zk/conf/zoo_sample.cfg /opt/zk/conf/zoo.cfg && \
    sed -i "s|/tmp/zookeeper|/opt/zk/data|g" /opt/zk/conf/zoo.cfg && \
    mkdir /opt/zk/data

###############################################################################
FROM openjdk:8-jre-alpine

RUN apk add --update bash

COPY --from=builder /opt/zk /opt/zk

ADD start-zk.sh /usr/bin/start-zk.sh

EXPOSE 2181 2888 3888

WORKDIR /opt/zk
VOLUME ["/opt/zk/conf", "/opt/zk/data"]

HEALTHCHECK --interval=10m --timeout=3s --retries=3 \
    CMD sh -c bin/zkServer.sh status

CMD /usr/bin/start-zk.sh
