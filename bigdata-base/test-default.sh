#!/bin/bash
set -e
set -x
export CONF_DIR=/tmp/testdefault
rm -rf $CONF_DIR
mkdir -p $CONF_DIR
echo "test1=default" >> $CONF_DIR/core-site.default
export CORE_SITE_test2=xxx
source ./hadoop-configurator.sh 
configure core-site
