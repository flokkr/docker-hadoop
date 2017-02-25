
## Examples

You can find multiple examples in the [umbrella repository](https://github.com/elek/bigdata-docker).

For example you can start a simple HDFS cluster with the following compose file:

```
version: "2"
services:
   namenode:
      image: elek/hadoop-hdfs-namenode:latest
      container_name: hdfs_namenode
      hostname: namenode
      volumes:
         - /tmp:/data
      ports:
         - 50070:50070
         - 9870:9870
      environment:
          HADOOP_OPTS: "-agentlib:jdwp=transport=dt_socket,server=y,suspend=n,address=5005"
          HDFS-SITE.XML_dfs.namenode.rpc-address: "namenode:9000"
          HDFS-SITE.XML_dfs.replication: "1"
          HDFS-SITE.XML_dfs.permissions.superusergroup: "admin"
          HDFS-SITE.XML_dfs.namenode.name.dir: "/data/namenode"
          HDFS-SITE.XML_dfs.namenode.http-bind-host: "0.0.0.0"
          LOG4J.PROPERTIES_log4j.rootLogger: "INFO, stdout"
          LOG4J.PROPERTIES_log4j.appender.stdout: "org.apache.log4j.ConsoleAppender"
          LOG4J.PROPERTIES_log4j.appender.stdout.layout: "org.apache.log4j.PatternLayout"
          LOG4J.PROPERTIES_log4j.appender.stdout.layout.ConversionPattern: "%d{yyyy-MM-dd HH:mm:ss} %-5p %c{1}:%L - %m%n"
   datanode:
      image: elek/hadoop-hdfs-datanode:latest
      volumes:
        - /tmp:/data
      links:
         - namenode
      environment:
          HDFS-SITE.XML_dfs.namenode.rpc-address: "namenode:9000"
          HDFS-SITE.XML_dfs.replication: "1"
          HDFS-SITE.XML_dfs.permissions.superusergroup: "admin"
          HDFS-SITE.XML_dfs.namenode.http-bind-host: "0.0.0.0"
          LOG4J.PROPERTIES_log4j.rootLogger: "INFO, stdout"
          LOG4J.PROPERTIES_log4j.appender.stdout: "org.apache.log4j.ConsoleAppender"
          LOG4J.PROPERTIES_log4j.appender.stdout.layout: "org.apache.log4j.PatternLayout"
          LOG4J.PROPERTIES_log4j.appender.stdout.layout.ConversionPattern: "%d{yyyy-MM-dd HH:mm:ss} %-5p %c{1}:%L - %m%n"
          CORE-SITE.XML_fs.default.name: "hdfs://namenode:9000"
          CORE-SITE.XML_fs.defaultFS: "hdfs://namenode:9000"
```

First time you need to format the namenode:

```
docker-compose run namenode hdfs namenode -format
```

After that you can start the cluster:

```
docker-compose up -d
```

You can also scale the cluster:

```
docker-compose scale datanode=3
```
