#!/bin/bash
set -e
set -x
source /usr/hdp/hadoop-configurator.sh
export CONF_DIR=/usr/hdp/hadoop/etc/hadoop
initialize
configure yarn-site
[ -f /usr/hdp/hadoop/etc/hadoop/capacity-scheduler.xml ] || cp /usr/hdp/hadoop/etc/hadoop/capacity-scheduler.xml.default /usr/hdp/hadoop/etc/hadoop/capacity-scheduler.xml
/usr/hdp/hadoop/bin/yarn resourcemanager
