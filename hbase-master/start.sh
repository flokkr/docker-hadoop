#!/bin/bash
set -e
set -x
source /opt/hadoop-configurator.sh
export CONF_DIR=/opt/hbase/conf
initialize
configure hbase-site
/opt/hbase/bin/hbase master start
