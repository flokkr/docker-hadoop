#!/bin/bash
set -e
set -x
source /opt/hadoop-configurator.sh
export CONF_DIR=/opt/hadoop/etc/hadoop
initialize
configure core-site
configure hdfs-site
/opt/hadoop/bin/hdfs namenode
