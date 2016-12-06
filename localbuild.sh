set -e
docker build -t elek/hadoop hadoop
docker build -t elek/hadoop-hdfs-datanode hdfs-datanode
docker build -t elek/hadoop-hdfs-namenode hdfs-namenode
docker build -t elek/hadoop-yarn-nodemanager yarn-nodemanager
docker build -t elek/hadoop-yarn-resourcemanager yarn-resourcemanager
