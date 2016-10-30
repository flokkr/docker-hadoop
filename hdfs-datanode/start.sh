#!/bin/bash
set -e
set -x
source /usr/hdp/hadoop-configurator.sh
configure /usr/hdp/hadoop/etc/hadoop/core-site CORE_SITE 
configure /usr/hdp/hadoop/etc/hadoop/hdfs-site HDFS_SITE 
/usr/hdp/hadoop/bin/hdfs datanode
