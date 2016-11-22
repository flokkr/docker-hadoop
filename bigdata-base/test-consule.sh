#!/bin/bash
set -e
set -x
export CONF_DIR=/tmp/testconsule
export CONSUL_LOCATION=localhost:8500
export CONFIG_SERVER_URL=http://localhost:8888
export RUNTIME_ENV=dev
rm -rf $CONF_DIR
mkdir -p $CONF_DIR

source ./hadoop-configurator.sh 
configure core-site
