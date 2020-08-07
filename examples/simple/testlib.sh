#!/usr/bin/env bash

retry() {
   n=0
   until [ $n -ge 30 ]
   do
      "$@" && break
      n=$[$n+1]
      echo "$n '$@' is failed..."
      sleep 3
   done
}

grep_log() {
   CONTAINER="$1"
   PATTERN="$2"
   kubectl logs "$1"  | grep "$PATTERN"
}

all_pods_are_running() {
   RUNNING_COUNT=$(kubectl get pod --field-selector status.phase=Running | wc -l)
   ALL_COUNT=$(kubectl get pod | wc -l)
   RUNNING_COUNT=$((RUNNING_COUNT - 1))
   ALL_COUNT=$((ALL_COUNT - 1))
   if [ "$RUNNING_COUNT" -lt "3" ]; then
      echo "$RUNNING_COUNT pods are running. Waiting for more."
      return 1
   elif [ "$RUNNING_COUNT" -ne "$ALL_COUNT" ]; then
      echo "$RUNNING_COUNT pods are running out from the $ALL_COUNT"
      return 2
   else
      STARTED=true
      return 0
   fi
}

execute_robot_test() {
   set -x
   CONTAINER="$1"
   TEST="$2"
   kubectl exec -it "${CONTAINER}" -- bash -c 'rm -rf /tmp/report'
   kubectl exec -it "${CONTAINER}" -- bash -c 'mkdir -p  /tmp/report'
   kubectl exec -it "${CONTAINER}" -- robot -d /tmp/report "${TEST}" || true
   kubectl cp "${CONTAINER}":/tmp/report/output.xml "${3:-output.xml}" || true
}
