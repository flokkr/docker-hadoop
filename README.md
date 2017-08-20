# Apache Hadoop docker images

These images are part of the bigdata [docker image series](https://github.com/flokkr). All of the images use the same [base docker image](https://github.com/flokkr/docker-baseimage) which contains advanced configuration loading. 

It supports configuration based on environment variables (using specific naming convention), downloaded from consul and other plugins (for example to generate kerberos keystabs).

For more detailed instruction to configure the images see the [README](https://github.com/flokkr/docker-base/blob/master/README.md) in the flokkr/docker-base repository.

## Getting started

### Run

The easiest way to run a storm cluster is just use the included ```docker-compose.yaml``` file. 

Checkout the repository and do a ```docker-compose up -d``` The storm UI will be available at http://localhost:8080

You can adjust the settings in the compose-config file.

To scale up datanode/namenode:

```
docker-compose scale datanode=3
```

To check namenode/resourcemanager use the published ports:

* Resourcemanager: http://localhost:8080
* Namenode: http://localhost:50070 (in case of hadoop 2.x)

### Smoketest

```
docker-compose exec resourcemanager /opt/hadoop/bin/yarn jar /opt/hadoop/share/hadoop/mapreduce/hadoop-mapreduce-examples-2.8.1.jar pi 16 1000

### Cluster

For more detailed examples check the other repositories under the flokkr organization with [runtime-](https://github.com/search?q=org%3Aflokkr+runtime) prefix.

There are more detailed examples with using:

* [docker-compose](https://github.com/flokkr/runtime-compose) (single-host)
* [docker-swarm](https://github.com/flokkr/runtime-swarm)
* [consul and docker-compose](https://github.com/flokkr/runtime-consul)  (multi-host)
* [consul and nomad](https://github.com/flokkr/runtime-nomad) (multi-host)
* [kubernetes](https://github.com/flokkr/runtime-kubernetes)



