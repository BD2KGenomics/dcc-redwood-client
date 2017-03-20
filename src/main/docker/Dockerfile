FROM ubuntu:16.04

# dependencies
RUN apt-get update
RUN apt-get install -y uuid-runtime

# java
RUN apt-get install -y software-properties-common
RUN add-apt-repository -y ppa:webupd8team/java
RUN apt-get update
RUN echo oracle-java8-installer shared/accepted-oracle-license-v1-1 select true | /usr/bin/debconf-set-selections
RUN apt-get install -y oracle-java8-installer
# update default truststore
ADD cert/cacerts /usr/lib/jvm/java-8-oracle/jre/lib/security/cacerts

# add dcc files
ENV DCC_HOME /dcc
ENV REDWOOD_CLIENT_HOME ${DCC_HOME}/dcc-redwood-client
WORKDIR ${DCC_HOME}
RUN mkdir -p ${REDWOOD_CLIENT_HOME}

RUN mkdir ${REDWOOD_CLIENT_HOME}/token
ADD bin ${REDWOOD_CLIENT_HOME}/bin
ADD cert ${REDWOOD_CLIENT_HOME}/cert
ADD lib ${REDWOOD_CLIENT_HOME}/lib
ADD maven2 ${REDWOOD_CLIENT_HOME}/maven2
ADD conf ${REDWOOD_CLIENT_HOME}/conf

RUN ln -s ${REDWOOD_CLIENT_HOME}/lib/icgc-storage-client-1.0.24-SNAPSHOT/ ${DCC_HOME}/icgc-storage-client
RUN ln -s ${REDWOOD_CLIENT_HOME}/lib/dcc-metadata-client-0.0.23-SNAPSHOT/ ${DCC_HOME}/dcc-metadata-client

RUN ln -s ${REDWOOD_CLIENT_HOME}/conf/application-redwood.properties ${DCC_HOME}/dcc-metadata-client/conf/application-redwood.properties
RUN ln -s ${REDWOOD_CLIENT_HOME}/conf/application-redwood.properties ${DCC_HOME}/icgc-storage-client/conf/application-redwood.properties

# set environment variables
ENV PATH ${REDWOOD_CLIENT_HOME}/bin:${DCC_HOME}/dcc-metadata-client/bin:${DCC_HOME}/icgc-storage-client/bin:${PATH}
ENV SPRING_PROFILES_ACTIVE redwood
ENV REDWOOD_ENDPOINT redwood.io
