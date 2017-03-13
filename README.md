# Redwood Client

## For Users
End users should use the [core-client](https://github.com/BD2KGenomics/dcc-spinnaker-client), which extends this client.

### Configuration
You probably just want to modify these environment variables.
- ACCESS_TOKEN: your access token
  - should look like _7d426b9f-7ff5-4850-85d7-1c795f4e11e0_
- REDWOOD_ENDPOINT: hostname (or IP) of server running storage service
  - This defaults to _redwood.io_

You can also replace or modify `/dcc/dcc-redwood-client/conf/application-redwood.properties` to set java configuration directly on the ICGC Storage System clients.

## For Developers
For developing the redwood-client

### Development
Build docker image with:
```
./mvnw && tar xf target/redwood-client-1.0.1-SNAPSHOT-dist.tar.gz && docker build -t quay.io/ucsc_cgl/redwood-client:dev redwood-client-1.0.1-SNAPSHOT; rm -r redwood-client-1.0.1-SNAPSHOT
```
(Use the `-P prod` maven profile for prod builds)

Use [dcc-ops](https://github.com/BD2KGenomics/dcc-ops) to test against a local storage system instance:
```
docker run --rm -it --net=redwood_default --link redwood-nginx:storage.redwood.io --link redwood-nginx:metadata.redwood.io -e ACCESS_TOKEN=<access_token> -e REDWOOD_ENDPOINT=redwood.io -v ~/data:/dcc/data quay.io/ucsc_cgl/redwood-client:dev bash
```
