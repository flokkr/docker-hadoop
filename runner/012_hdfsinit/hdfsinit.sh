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
   if [ "$NAMENODE_INIT" ]; then
      hdfs namenode -Ddfs.namenode.rpc-address=127.0.0.1:1111 &
		NNPID=$!
      for i in `seq 30` ; do
         nc -z "127.0.0.1" "1111" > /dev/null 2>&1

         result=$?
         if [ $result -eq 0 ] ; then
            eval "$NAMENODE_INIT"
            kill $NNPID
				sleep 3
            call-next-plugin "$@"  
         fi     
         sleep 1
      done                          
      echo "Operation timed out" >&2
      exit 1
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

if [ -n "$ENSURE_OM_INITIALIZED" ]; then
   if [ ! -f "$ENSURE_OM_INITIALIZED" ]; then
      # To make sure SCM is running in dockerized environment we will sleep
      # Could be removed after HDFS-13203
      echo "Waiting 15 seconds for SCM startup"
      sleep 15
      /opt/hadoop/bin/ozone om -createObjectStore
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
