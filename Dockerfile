FROM docker:latest

ARG SCALA_VERSION
ARG SBT_VERSION

RUN apk update && \
    apk --no-cache add openjdk8 --repository=http://dl-cdn.alpinelinux.org/alpine/edge/community && \
    apk add --no-cache bash git curl ncurses

ENV SCALA_VERSION ${SCALA_VERSION:-2.12.10}
RUN \
    mkdir -p /usr/lib/jvm/java-1.8-openjdk/jre && \
    touch /usr/lib/jvm/java-1.8-openjdk/jre/release && \
    curl -fsL http://downloads.typesafe.com/scala/$SCALA_VERSION/scala-$SCALA_VERSION.tgz | tar xfz - -C /usr/local && \
    ln -s /usr/local/scala-$SCALA_VERSION/bin/* /usr/local/bin/ && \
    scala -version && \
    scalac -version

ENV SBT_VERSION ${SBT_VERSION:-1.2.8}
RUN \
    curl -fsL https://github.com/sbt/sbt/releases/download/v$SBT_VERSION/sbt-$SBT_VERSION.tgz | tar xfz - -C /usr/local && \
    ln -s /usr/local/sbt/bin/* /usr/local/bin/ && \
    sbt sbtVersion || true
