#!/usr/bin/env bash

set -e 

build() {
   IFS=', ' read -r -a TAGA <<< "$TAGS"
   TAG=${TAGA[0]}
   echo ${URL} > hadoop/url
   docker build --label io.github.flokkr.hadoop.version=$HADOOP_VERSION -t flokkr/hadoop-runner:${TAG} runner
   docker tag flokkr/hadoop-runner:${TAG} flokkr/hadoop-runner:build
   docker build --label io.github.flokkr.hadoop.version=$HADOOP_VERSION -t flokkr/hadoop:${TAG} hadoop
}

deploy() {
   IFS=', ' read -r -a TAGA <<< "$TAGS"
   TAG=${TAGA[0]}
   for CT in "${TAGA[@]}"
   do
      if [ "$TAG" != "$CT" ]; then
         docker tag flokkr/hadoop-runner:${TAG} flokkr/hadoop-runner:${CT}
         docker tag flokkr/hadoop:${TAG} flokkr/hadoop:${CT}
      fi
         docker push flokkr/hadoop-runner:${CT}
         docker push flokkr/hadoop:${CT}
   done
}

TAGS=latest
HADOOP_VERSION=3.1.0

while getopts ":v:t:" opt; do
  case $opt in
    v)
      HADOOP_VERSION=$OPTARG >&2
      ;;
    t)
      TAGS=${OPTARG:-$HADOOP_VERSION}
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
  CHECK=$(curl -I HEAD $URL 2>/dev/null | head -n 1 | cut -d$' ' -f2)
  if [ $CHECK == "404" ]; then
      echo "$URL is not found. Trying to use an archive link."
      URL="https://archive.apache.org/dist/hadoop/common/hadoop-$HADOOP_VERSION/hadoop-$HADOOP_VERSION.tar.gz"
  fi
fi
export URL
shift $(($OPTIND -1))
eval $*
