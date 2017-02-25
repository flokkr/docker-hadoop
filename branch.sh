#!/bin/bash
TAG=${DOCKER_TAG:-latest}
URL=$1
BASE_IMAGE=$(basename $(dirname $(find -name baseimage)))
echo $URL > $BASE_IMAGE/url
grep -l -r "$BASE_IMAGE:latest" | grep -v branch.sh |xargs sed -i "s/$BASE_IMAGE:latest/$BASE_IMAGE:$TAG/g"
