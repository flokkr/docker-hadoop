
## Examples

For getting started use the incloded docker-compose file and start both hdfs and yarn clusters:

```
docker-compose up -d
```

You can adjust the settings in the compose-config file.

To scale up datanode/namenode:

```
docker-compose scale datanode=3
```

To check namenode/resourcemanager use the published ports:

* Resourcemanager: http://localhost:8080
* Namenode: http://localhost:50070 (in case of hadoop 2.x)

## Smoketest

```
docker-compose exec resourcemanager /opt/hadoop/bin/yarn jar /opt/hadoop/share/hadoop/mapreduce/hadoop-mapreduce-examples-2.8.1.jar pi 16 1000
```