#!/usr/bin/env bash
set -e
version=${1}

tar xf target/redwood-client-${version}-dist.tar.gz
docker build -t quay.io/ucsc_cgl/redwood-client:${version} redwood-client-${version}
rm -r redwood-client-${version}
echo "$(basename $0): built docker image: quay.io/ucsc_cgl/redwood-client:${version}"
