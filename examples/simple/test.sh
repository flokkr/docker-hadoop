#!/usr/bin/env bash
# Licensed to the Apache Software Foundation (ASF) under one
# or more contributor license agreements.  See the NOTICE file
# distributed with this work for additional information
# regarding copyright ownership.  The ASF licenses this file
# to you under the Apache License, Version 2.0 (the
# "License"); you may not use this file except in compliance
# with the License.  You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

set -e

export K8S_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

# shellcheck source=/dev/null
source "$K8S_DIR/testlib.sh"

export RESULT_DIR="${RESULT_DIR:-"$K8S_DIR/result"}"
rm -rf "$RESULT_DIR"
mkdir -p "$RESULT_DIR"

flekszible -s "$K8S_DIR" -d "$K8S_DIR" generate -t hdfs/onenode -t mount:path=/opt/smoketest,hostPath=$K8S_DIR/smoketest

kubectl apply -f "$K8S_DIR"

retry all_pods_are_running

retry grep_log hdfs-namenode-0 "Quota initialization completed"

retry grep_log yarn-resourcemanager-0 "Transitioned to active state"

sleep 10

#TOOD: this is a workaround. Most probably a DNS resolution issue.
kubectl delete pod -l component=nodemanager

sleep 10

execute_robot_test yarn-resourcemanager-0 /opt/smoketest/hdfs.robot "$RESULT_DIR/hadoop.xml"

