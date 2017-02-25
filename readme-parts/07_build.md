## Local build

Custom version could be built by running `branch.sh` and `localbuild.sh`

First set DOCKER_TAG environment variable:

```
export DOCKER_TAG=3.0.0-alpha3-SNAPSHOT
```

After that you can modify the base image to download tar file from a custom location:

```
./branch.sh http://localhost/apache-hadoop.tar.gz
```

If url is replaced, you can build the images:

```
./localbuild.sh
```

After the build, you can use the images with the specified tag:

```
docker run .... elek/image_name:$DOCKER_TAG
```

Note: if you have tar file locally, you can server it with a simple http server:

With python3:
```
python3 -m http.server
```

With python2:
```
python -m SimpleHTTPServer
```
