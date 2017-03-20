# Redwood Client

## For Users
End users should use the [core-client](https://github.com/BD2KGenomics/dcc-spinnaker-client), which extends this client.

### Getting Started
Download the config file and edit it to specify your redwood access token.
```
wget https://raw.githubusercontent.com/BD2KGenomics/dcc-redwood-client/develop/src/main/conf/application-redwood.properties
```

Now you can invoke the client (or derived clients) by mounting in the config file as a volume as specifying the REDWOOD_ENDPOINT environment variable:
```
docker run -it -e ACCESS_TOKEN=<access_token> -v $(pwd)/application-redwood.properties:/dcc/dcc-redwood-client/conf/application-redwood.properties -v ~/data:/dcc/data quay.io/ucsc_cgl/redwood-client:dev bash
```

Note: you can also specify `-e ACCESS_TOKEN=<your-access-token>` when you invoke `docker run` instead of using the config file (as long as you're on a private machine).

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
docker run --rm -it --net=redwood_default --link redwood-nginx:storage.redwood.io --link redwood-nginx:metadata.redwood.io -e ACCESS_TOKEN=<access_token> -v ~/data:/dcc/data quay.io/ucsc_cgl/redwood-client:dev bash
```
