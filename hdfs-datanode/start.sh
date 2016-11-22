#!/bin/bash
set -e
set -x
export CONF_DIR=/usr/hdp/hadoop/etc/hadoop
source /usr/hdp/hadoop-configurator.sh
configure core-site
configure hdfs-site
/usr/hdp/hadoop/bin/hdfs datanode
