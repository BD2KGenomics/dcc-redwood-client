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
docker run -it -e REDWOOD_ENDPOINT=<redwood_endpoint> -v $(pwd)/application-redwood.properties:/dcc/dcc-redwood-client/conf/application-redwood.properties -v ~/data:/dcc/data quay.io/ucsc_cgl/redwood-client:1.1.1 bash
```

Note: you can also specify `-e ACCESS_TOKEN=<your-access-token>` when you invoke `docker run` instead of using the config file (as long as you're on a private machine).

## Specification
The redwood client is released as the `quay.io/ucsc_cgl/redwood-client` docker image.

The following commands are exposed (help commands shown):
`upload -h` upload a set of files
`download -h` download individual files
`redwood-download -h` download via manifest
`icgc-storage-client help` underlying storage client
`dcc-metadata-client help` underlying metadata client

Configuration on the underlying igcg clients can be set via (from highest to lowest precedence):
`/dcc/dcc-redwood-client/conf/application-redwood.properties` java
`REDWOOD_PROPERTIES` or `ACCESS_TOKEN` environment variables

## For Developers
For developing the redwood-client

### Development
Build docker image with:
```
./mvnw
```
(Use the `-P prod` maven profile for prod builds)

Use [dcc-ops](https://github.com/BD2KGenomics/dcc-ops) to test against a local storage system instance:
```
docker run --rm -it --net=redwood_default --link redwood-nginx:storage.redwood.io --link redwood-nginx:metadata.redwood.io -e ACCESS_TOKEN=<access_token> -v ~/data:/dcc/data quay.io/ucsc_cgl/redwood-client:1.1.2-SNAPSHOT bash
```

_Tip:_ From the _dcc-ops/redwood_ directory you can create an access token and launch the client in one line:
```
docker run --rm -it --net=redwood_default --link redwood-nginx:storage.redwood.io --link redwood-nginx:metadata.redwood.io -e ACCESS_TOKEN=$(scripts/createAccessToken.sh) -v ~/data:/dcc/data quay.io/ucsc_cgl/redwood-client:1.1.2-SNAPSHOT bash
```

### Release
- Bump  the version number in _pom.xml_
- Build and push the docker image to _quay.io_
- Update this README to use the latest version number
