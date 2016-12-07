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
WORKDIR $DCC_HOME
RUN mkdir -p $DCC_HOME

# can pass in archive or use built archive
ARG DCC_ARCHIVE
COPY ${DCC_ARCHIVE:-./artifacts/ucsc-storage-client-dist.tar.gz} $DCC_HOME/ucsc-storage-client-dist.tar.gz
RUN tar xf $DCC_HOME/ucsc-storage-client-dist.tar.gz
ENV PATH $DCC_HOME/ucsc-storage-client/bin:$PATH

ENV REDWOOD_ENDPOINT storage.ucsc-cgl.org
ENV UCSC_STORAGE_METADATA_SERVER https://${REDWOOD_ENDPOINT}:8444
ENV UCSC_STORAGE_STORAGE_SERVER https://${REDWOOD_ENDPOINT}:5431
ENV UCSC_STORAGE_TRUSTSTORE_PASSWORD=changeit
