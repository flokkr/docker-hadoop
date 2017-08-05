#!/bin/bash
if [ -n "$ENSURE_NAMENODE_DIR" ]; then
   if [ ! -d "$ENSURE_NAMENODE_DIR" ]; then
      /opt/hadoop/bin/hdfs namenode -format
	fi
fi
/opt/hadoop/bin/hdfs namenode
exit $?
