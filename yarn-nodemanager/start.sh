#!/bin/bash
set -e
set -x
source /opt/hadoop-configurator.sh
export CONF_DIR=/opt/hadoop/etc/hadoop
initialize
configure core-site
configure yarn-site
/opt/hadoop/bin/yarn nodemanager
