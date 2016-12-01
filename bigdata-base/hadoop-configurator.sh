#!/bin/bash

function env-to-conf() {
   envname=`echo $1 | awk '{print toupper($1)}'`
   env | grep $envname |  sed -e "s/^$envname_//" | awk -F "=" '{gsub("_",".",$1);print tolower($1) "=" $2}' >> $CONF_DIR/$1.env
   env | grep ${envname/-/_} |  sed -e "s/^${envname/-/_}_//" | awk -F "=" '{gsub("_",".",$1);print tolower($1) "=" $2}' >> $CONF_DIR/$1.env
}

function merge() {
   cat $CONF_DIR/$1.env $CONF_DIR/$1.default | awk -F "=" '{if (!seen[$1]++) print}' > $CONF_DIR/$1.conf
}

function prop-to-xml() {
      filename="${1%.*}"
      echo "<configuration>" > $filename.xml
      cat $1 | awk -F: '{ st = index($0,":");print "<property><name>" $1 "</name><value>" substr($0,st+2) "</value></property>"}' >> $filename.xml
      echo "</configuration>" >> $filename.xml
}

function env-to-xml() {
      filename="${1%.*}"
      echo "<configuration>" > $filename.xml
      cat $1 | awk -F "=" 'NF {print "<property><name>" $1 "</name><value>" $2 "</value></property>"}' >> $filename.xml
      echo "</configuration>" >> $filename.xml
}


function configure-from-consul() {
   configsafename=${1/-/_}
   echo $configsafename
   wget $CONFIG_SERVER_URL/$configsafename-$RUNTIME_ENV.properties -O /tmp/$configsafename.properties
   wounderscore /tmp/$configsafename.properties
   prop-to-xml /tmp/$1.properties
   /usr/bin/consul-template -once -consul $CONSUL_LOCATION -template /tmp/$1.xml:$CONF_DIR/$1.xml
}

function configure-from-defaults() {
   env-to-conf $1
   merge $1
   [ -f $CONF_DIR/$1.xml ] || env-to-xml $CONF_DIR/$1.conf
}

function initialize(){
   if [ ! -z "$CONSUL_LOCATION" ]; then
      until $(curl --output /dev/null --silent --fail $CONSUL_LOCATION/v1/agent/self -o /tmp/self); do
         echo "query the consul agent..."
         sleep 1
      done
      export ADVERTISED_ADDR=$(cat /tmp/self | jq -r '.Config.AdvertiseAddr')
      echo "Advertised address is $ADVERTISED_ADDR"
   fi
}

function configure(){
   if [ -z "$CONSUL_LOCATION" ]; then
      configure-from-defaults $1
   else
      configure-from-consul $1
   fi
}

function wounderscore(){
   filename=$1
   fixedfilename=${1/_/-}
   mv $filename $fixedfilename
}


