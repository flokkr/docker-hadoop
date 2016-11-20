#!/bin/bash

function env-to-conf() {
   env | grep $2 |  sed -e "s/^$2_//" | awk -F "=" '{gsub("_",".",$1);print tolower($1) "=" $2}' >> $1.env
}

function merge() {
   cat $1.env $1.default | awk -F "=" '{if (!seen[$1]++) print}' > $1.conf
}

function prop-to-xml() {
      filename="${1%.*}"
      echo "<configuration>" > $filename.xml
      cat $1 | awk -F: '{ st = index($0,":");print "<property><name>" $1 "</name><value>" substr($0,st+2) "</value></property>"}' >> $filename.xml
      echo "</configuration>" >> $filename.xml
}

function to-xml() {
      filename="${1%.*}"
      echo "<configuration>" > $filename.xml
      cat $1 | awk -F "=" 'NF {print "<property><name>" $1 "</name><value>" $2 "</value></property>"}' >> $filename.xml
      echo "</configuration>" >> $filename.xml
}



function configure (){
   env-to-conf $1 $2
   merge $1 $2
   [ -f $1.xml ] || to-xml $1 $2
}

function wounderscore(){
   filename=$1
   fixedfilename=${1/_/-}
   mv $filename $fixedfilename
}


