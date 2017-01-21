#!/bin/bash
TAG=$1
URL=$2
BASE_IMAGE="hadoop"
echo $URL > $BASE_IMAGE/url
grep -l -r "$BASE_IMAGE:latest" | grep -v branch.sh |xargs sed -i "s/$BASE_IMAGE:latest/$BASE_IMAGE:$TAG/g"
