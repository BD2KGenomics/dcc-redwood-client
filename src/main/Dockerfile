FROM ubuntu:16.04
MAINTAINER Carlos Espinosa <caaespin@ucsc.edu>

# install oracle java
RUN apt-get update
RUN apt-get install -y software-properties-common
RUN add-apt-repository -y ppa:webupd8team/java
RUN apt-get update
RUN echo oracle-java8-installer shared/accepted-oracle-license-v1-1 select true | /usr/bin/debconf-set-selections
RUN apt-get install -y oracle-java8-installer

#Setting up the spinnaker client
RUN apt-get update && apt-get install -y --force-yes \
    python-dev \
    python-pip \
    build-essential \
    libxml2-dev \
    libxslt-dev \
    lib32z1-dev \
    python-setuptools \
    git \
    uuid-runtime

RUN easy_install pip

RUN pip install \
    jsonschema \
    jsonmerge \
    openpyxl \
    sets \
    json-spec \
    elasticsearch \
    semver \
    luigi

# add dcc files
ENV DCC_HOME /dcc
WORKDIR ${DCC_HOME}
RUN mkdir -p ${DCC_HOME}
ADD bin ${DCC_HOME}/bin
ADD cert ${DCC_HOME}/cert
ADD lib ${DCC_HOME}/lib

# install spinnaker
RUN git clone -b release/1.0.0 --single-branch https://github.com/BD2KGenomics/dcc-spinnaker-client.git ${DCC_HOME}/dcc-spinnaker-client/
RUN cd ${DCC_HOME}/dcc-spinnaker-client/ && wget https://s3-us-west-2.amazonaws.com/beni-dcc-storage-dev/20161216_ucsc-storage-client.tar.gz && tar zxf 20161216_ucsc-storage-client.tar.gz && rm -f 20161216_ucsc-storage-client.tar.gz

# make everything runnable
RUN chmod a+x ${DCC_HOME}/bin/*

# Set environment variables
ENV PATH ${DCC_HOME}/bin:${DCC_HOME}/lib/dcc-metadata-client-0.0.16-SNAPSHOT/bin:${DCC_HOME}/lib/icgc-storage-client-1.0.14-SNAPSHOT/bin:$PATH
ENV REDWOOD_ENDPOINT storage.ucsc-cgl.org
