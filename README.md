# UCSC Storage Client

## Usage
```
docker run --rm -e ACCESS_TOKEN=<your-access-token> \
-e REDWOOD_ENDPOINT=storage.ucsc-cgl.org \
-v `pwd`/my/data/dir:/data \
ucsc-storage-client bash

$ upload /data/foo.txt /data/bar.txt
```

### Configuration
For normal usage, you should only need to modify environment variables.
- ACCESS_TOKEN: your access token
  - should look like _7d426b9f-7ff5-4850-85d7-1c795f4e11e0_
- REDWOOD_ENDPOINT: hostname (or IP) of server running storage service
  - This defaults to _storage.ucsc-cgl.org_

Look in _/dcc/ucsc-storage-client/conf/_ for further configuration options.
