#!/usr/bin/env bash

set -e 

build() {
	echo ${URL} > hadoop/url
	docker build --label io.github.flokkr.hadoop.version=$HADOOP_VERSION -t flokkr/hadoop-runner:${TAG} runner
	docker tag flokkr/hadoop-runner:${TAG} flokkr/hadoop-runner:build
	docker build --label io.github.flokkr.hadoop.version=$HADOOP_VERSION -t flokkr/hadoop:${TAG} hadoop
}

deploy() {
	docker push flokkr/hadoop-runner:${TAG}
	docker push flokkr/hadoop:${TAG}
}

TAG=latest
HADOOP_VERSION=3.1.0

while getopts ":v:t:" opt; do
  case $opt in
    v)
      HADOOP_VERSION=$OPTARG >&2
      ;;
    t)
      TAG=${OPTARG:-$HADOOP_VERSION}
      ;;
    \?)
      echo "Invalid option: -$OPTARG" >&2
      ;;
  esac
done

if [ "$HADOOP_DOWNLOAD_URL" ]; then
  URL=$HADOOP_DOWNLOAD_URL
else
  URL="https://www-eu.apache.org/dist/hadoop/common/hadoop-$HADOOP_VERSION/hadoop-$HADOOP_VERSION.tar.gz"
fi
export URL
shift $(($OPTIND -1))
eval $*
