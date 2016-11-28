#!/bin/bash
set -e
set -x
source /usr/hdp/hadoop-configurator.sh
export CONF_DIR=/usr/hdp/hbase/conf
initialize
configure hbase-site
/usr/hdp/hbase/bin/hbase regionserver start
