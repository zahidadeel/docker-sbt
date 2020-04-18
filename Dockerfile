FROM docker:latest

ARG SCALA_VERSION
ARG SBT_VERSION

ENV SCALA_VERSION ${SCALA_VERSION:-2.12.7}
ENV SBT_VERSION ${SBT_VERSION:-1.2.6}
RUN apk update && \
    apk --no-cache add openjdk8 --repository=http://dl-cdn.alpinelinux.org/alpine/edge/community && \
    apk add --no-cache bash && \
    apk add --no-cache git && \
    apk add --no-cache curl && \
    apk add --no-cache ncurses

RUN \
    mkdir -p /usr/lib/jvm/java-1.8-openjdk/jre && \
    touch /usr/lib/jvm/java-1.8-openjdk/jre/release && \
    curl -fsL http://downloads.typesafe.com/scala/$SCALA_VERSION/scala-$SCALA_VERSION.tgz | tar xfz - -C /usr/local && \
    ln -s /usr/local/scala-$SCALA_VERSION/bin/* /usr/local/bin/ && \
    scala -version && \
    scalac -version

RUN \
    curl -fsL https://github.com/sbt/sbt/releases/download/v$SBT_VERSION/sbt-$SBT_VERSION.tgz | tar xfz - -C /usr/local && \
    ln -s /usr/local/sbt/bin/* /usr/local/bin/ && \
    sbt sbtVersion || true
