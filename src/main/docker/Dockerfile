FROM ubuntu:latest

# install oracle java
RUN apt-get update
RUN apt-get install -y software-properties-common
RUN add-apt-repository -y ppa:webupd8team/java
RUN apt-get update
RUN echo oracle-java8-installer shared/accepted-oracle-license-v1-1 select true | /usr/bin/debconf-set-selections
RUN apt-get install -y oracle-java8-installer

RUN apt-get update && apt-get install -y uuid-runtime

# add dcc files
ENV DCC_HOME /dcc
WORKDIR ${DCC_HOME}
RUN mkdir -p ${DCC_HOME}
ADD bin ${DCC_HOME}/bin
ADD cert ${DCC_HOME}/cert
ADD lib ${DCC_HOME}/lib

ENV PATH ${DCC_HOME}/bin:$PATH
ENV REDWOOD_ENDPOINT storage.ucsc-cgl.org
ENV UCSC_STORAGE_TRUSTSTORE_PASSWORD=changeit
