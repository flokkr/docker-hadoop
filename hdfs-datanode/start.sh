#!/bin/bash
set -e
set -x
export CONF_DIR=/opt/hadoop/etc/hadoop
source /opt/hadoop-configurator.sh
initialize
configure core-site
configure hdfs-site
configure yarn-site
/opt/hadoop/bin/hdfs datanode
