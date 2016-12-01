#!/bin/bash
set -e
set -x
source /opt/hadoop-configurator.sh
export CONF_DIR=/opt/hadoop/etc/hadoop
initialize
configure yarn-site
[ -f /opt/hadoop/etc/hadoop/capacity-scheduler.xml ] || cp /opt/hadoop/etc/hadoop/capacity-scheduler.xml.default /opt/hadoop/etc/hadoop/capacity-scheduler.xml
/opt/hadoop/bin/yarn resourcemanager
