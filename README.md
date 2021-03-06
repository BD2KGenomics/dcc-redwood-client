# Redwood Client

## For Users
End users should use the [core-client](https://github.com/BD2KGenomics/dcc-spinnaker-client), which extends this client.

### Getting Started
Download the config file and edit it to specify your redwood access token.
```
wget https://raw.githubusercontent.com/BD2KGenomics/dcc-redwood-client/develop/src/main/conf/application-redwood.properties
```

Now you can invoke the client (or derived clients) by mounting in the config file as a volume and specifying the REDWOOD_ENDPOINT environment variable:
```
docker run -it -e REDWOOD_ENDPOINT=<redwood_endpoint> -v $(pwd)/application-redwood.properties:/dcc/dcc-redwood-client/conf/application-redwood.properties -v ~/data:/dcc/data quay.io/ucsc_cgl/redwood-client:1.2.2 bash
```

Note: you can also specify `-e ACCESS_TOKEN=<your-access-token>` when you invoke `docker run` instead of using the config file (as long as you're on a private machine).

## Specification
The redwood client is released as the `quay.io/ucsc_cgl/redwood-client` docker image.

The following commands are exposed (help commands shown):
- `upload -h` upload a set of files
- `download -h` download individual files
- `redwood-download -h` download via manifest
- `icgc-storage-client help` underlying storage client
- `dcc-metadata-client help` underlying metadata client

Configuration on the underlying igcg clients can be set via (from highest to lowest precedence):
- `/dcc/dcc-redwood-client/conf/application-redwood.properties` java properties file
- `REDWOOD_PROPERTIES`, `ACCESS_TOKEN`, and `REDWOOD_LOG_DIR` environment variables
- Java system properties specified in the JAVA_OPTS environment variable

## For Developers
Please update the [change log](CHANGELOG.md) to reflect each user-facing change you make

### Development
Build docker image with:
```
./mvnw
```
(Use the `-P prod` maven profile for prod builds)

Use [dcc-ops](https://github.com/BD2KGenomics/dcc-ops) to test against a local (dev mode) storage system instance:
```
docker run --rm -it --net=redwood_internal --link redwood-nginx:storage.redwood.io --link redwood-nginx:metadata.redwood.io -e ACCESS_TOKEN=<access_token> -v ~/data:/dcc/data quay.io/ucsc_cgl/redwood-client:1.2.2-SNAPSHOT bash
```

_Tip:_ If you're using a local redwood instance and the redwood cli is on your path you can create an access token and launch the client in one line:
```
docker run --rm -it --net=redwood_internal --link redwood-nginx:storage.redwood.io --link redwood-nginx:metadata.redwood.io -e ACCESS_TOKEN=$(redwood token create) -v ~/data:/dcc/data quay.io/ucsc_cgl/redwood-client:1.2.2-SNAPSHOT bash
```

### Release
- Bump  the version number in _pom.xml_
- Login to quay.io on the command line 'docker login quay.io'
- `./mvnw deploy` to build and push the docker image to _quay.io_
- Update this README to use the latest version number
- Edit the version on the pom.xml to the `next_version-SNAPSHOT`
- Update the [change log](CHANGELOG.md) (rename the "Unreleased" section, etc.)
