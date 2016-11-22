#!/bin/bash
set -e
set -x
source /usr/hdp/hadoop-configurator.sh
export CONF_DIR=/usr/hdp/hadoop/etc/hadoop
initialize
configure core-site
configure yarn-site
/usr/hdp/hadoop/bin/yarn nodemanager
