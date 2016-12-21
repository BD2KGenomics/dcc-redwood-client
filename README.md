# Redwood Client

## Usage
```
docker run --rm -e ACCESS_TOKEN=<your-access-token> \
-e REDWOOD_ENDPOINT=storage.ucsc-cgl.org \
-v `pwd`/my/data/dir:/data \
ucsc-storage-client bash

$ upload /data/foo.txt /data/bar.txt
```

## Configuration
For normal usage, you should only need to modify environment variables.
- ACCESS_TOKEN: your access token
  - should look like _7d426b9f-7ff5-4850-85d7-1c795f4e11e0_
- REDWOOD_ENDPOINT: hostname (or IP) of server running storage service
  - This defaults to _storage.ucsc-cgl.org_

Look in _/dcc/ucsc-storage-client/conf/_ for further configuration options.

## Development
Build docker image with:
```
mvn && tar xf target/redwood-client-1.0.1-SNAPSHOT-dist.tar.gz && docker build -t quay.io/ucsc_cgl/core-client:1.0.0 redwood-client-1.0.1-SNAPSHOT; rm -r redwood-client-1.0.1-SNAPSHOT
```

## Upload via Spinnaker

Create a manifest that links your metdata and data.  Your `manifest.tsv` should be a TSV based on this [template](https://docs.google.com/spreadsheets/d/13fqil92C-Evi-4cy_GTnzNMmrD0ssuSCx3-cveZ4k70/edit?usp=sharing).

You need to include file paths to your upload files that start with `/dcc/data` since that's the location used in the docker run below.

You should create a directory where you want to have your files for upload (assumed to be `pwd`), place your `manifest.tsv` in this directory along with all your files for upload, and then execute the following:

    docker run --rm -it -e ACCESS_TOKEN=<access_token> -e REDWOOD_ENDPOINT=storage.ucsc-cgl.org -v `pwd`:/dcc/data quay.io/ucsc_cgl/core-client:1.0.0 spinnaker-upload /dcc/data/sample.tsv
    
    
## Download via Manifest

This assumes the current working directory (`pwd`) has a manifest, like the ones you can download from http://ucsc-cgl.org/file_browser/.  The command below will then download the files to the current working directory.  

NOTE: make sure you have enough space in `pwd`!!!

    docker run --rm -e ACCESS_TOKEN=<access_token> -e REDWOOD_ENDPOINT=storage.ucsc-cgl.org -v `pwd`:/dcc/data quay.io/ucsc_cgl/core-client:1.0.0 redwood-download /dcc/data/manifest.tsv /dcc/data/
