#!/bin/bash
set -e
set -x
export CONSUL_LOCATION=172.17.0.1:8500
export CONFIG_SERVER_URL=http://172.17.0.1:8888
export RUNTIME_ENV=dev
export CONF_DIR=/usr/hdp/hadoop/etc/hadoop
source /usr/hdp/hadoop-configurator.sh
configure core-site
configure hdfs-site
/usr/hdp/hadoop/bin/hdfs datanode
