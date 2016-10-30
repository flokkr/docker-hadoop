#!/bin/bash

function env-to-conf() {
   env | grep $2 |  sed -e "s/^$2_//" | awk -F "=" '{gsub("_",".",$1);print tolower($1) "=" $2}' >> $1.env
}

function merge() {
   cat $1.env $1.default | awk -F "=" '{if (!seen[$1]++) print}' > $1.conf
}

function to-xml() {
      echo "<configuration>" > $1.xml
      cat $1.conf | awk -F "=" 'NF {print "<property><name>" $1 "</name><value>" $2 "</value></property>"}' >> $1.xml
      echo "</configuration>" >> $1.xml
}

function configure (){
   env-to-conf $1 $2
   merge $1 $2
   [ -f $1.xml ] || to-xml $1 $2
}
