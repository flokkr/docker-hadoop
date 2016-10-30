#!/bin/bash
set -e
set -x
source /usr/hdp/hadoop-configurator.sh
configure /usr/hdp/hadoop/etc/hadoop/yarn-site YARN_SITE 
/usr/hdp/hadoop/bin/yarn nodemanager
