#/usr/bin/env bash
set -x
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
      hdfs namenode &
		NNPID=$!
      for i in `seq 30` ; do
   
		   NAMENODE_ADDRESS=$(hdfs getconf -confkey dfs.namenode.rpc-address)
		   NN_WAITFOR_HOST=$(printf "%s\n" "$NAMENODE_ADDRESS"| cut -d : -f 1)
         NN_WAITFOR_PORT=$(printf "%s\n" "$NAMENODE_ADDRESS"| cut -d : -f 2)
         nc -z "$NN_WAITFOR_HOST" "$NN_WAITFOR_PORT" > /dev/null 2>&1

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
