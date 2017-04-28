set -e
DOCKER_TAG=${1:-latest}
docker build -t elek/hadoop:$DOCKER_TAG hadoop
docker build -t elek/hadoop-hdfs-datanode:$DOCKER_TAG hdfs-datanode
docker build -t elek/hadoop-hdfs-namenode:$DOCKER_TAG hdfs-namenode
docker build -t elek/hadoop-yarn-nodemanager:$DOCKER_TAG yarn-nodemanager
docker build -t elek/hadoop-yarn-resourcemanager:$DOCKER_TAG yarn-resourcemanager
