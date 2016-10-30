#!/bin/bash
set -e
set -x
source /usr/hdp/hadoop-configurator.sh
configure /usr/hdp/hadoop/etc/hadoop/yarn-site YARN_SITE 
[ -f /usr/hdp/hadoop/etc/hadoop/capacity-scheduler.xml ] || cp /usr/hdp/hadoop/etc/hadoop/capacity-scheduler.xml.default /usr/hdp/hadoop/etc/hadoop/capacity-scheduler.xml
/usr/hdp/hadoop/bin/yarn resourcemanager
