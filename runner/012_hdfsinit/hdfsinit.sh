#/usr/bin/env bash
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
if [ -n "$ENSURE_NAMENODE_DIR" ]; then
   CLUSTERID_OPTS=""
   if [ -n "$ENSURE_NAMENODE_CLUSTERID" ]; then
      CLUSTERID_OPTS="-clusterid $ENSURE_NAMENODE_CLUSTERID"
   fi
   if [ ! -d "$ENSURE_NAMENODE_DIR" ]; then
      /opt/hadoop/bin/hdfs namenode -format -force $CLUSTERID_OPTS
        fi
fi


if [ -n "$ENSURE_STANDBY_NAMENODE_DIR" ]; then
   if [ ! -d "$ENSURE_STANDBY_NAMENODE_DIR" ]; then
      /opt/hadoop/bin/hdfs namenode -bootstrapStandby
    fi
fi

if [ -n "$ENSURE_SCM_INITIALIZED" ]; then
   if [ ! -f "$ENSURE_SCM_INITIALIZED" ]; then
     if [ -f "/opt/hadoop/bin/ozone" ]; then
        /opt/hadoop/bin/ozone scm -init
      else
        /opt/hadoop/bin/hdfs scm -init
      fi
   fi
fi


if [ -n "$ENSURE_KSM_INITIALIZED" ]; then
   if [ ! -f "$ENSURE_KSM_INITIALIZED" ]; then
     if [ -f "/opt/hadoop/bin/ozone" ]; then
      /opt/hadoop/bin/ozone ksm -createObjectStore
    else
      /opt/hadoop/bin/hdfs ksm -createObjectStore
    fi
   fi
fi

call-next-plugin "$@"
