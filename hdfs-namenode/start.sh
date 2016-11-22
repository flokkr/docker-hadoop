#!/bin/bash
set -e
set -x
source /usr/hdp/hadoop-configurator.sh
export CONF_DIR=/usr/hdp/hadoop/etc/hadoop
initialize
configure core-site
configure hdfs-site
/usr/hdp/hadoop/bin/hdfs namenode
