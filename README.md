

This repository contains docker images for basic hadoop cluster.

## Configuration

Configuration files are copied at the first time if not exists. So you can map a volume to /usr/hdp/hadoop/etc/hadoop and a minimal configuration (just eough to start the cluster with docker-compose) will be created. 

*All* the hadoop configurations could be overridden with environment variables, with the form: ```CONFIG_FILE_NAME_CONFIG_NAME``` For example CORE_SITE_FS_DEFAULT_NAME=hdfs://xxx will generate a ```fs.default.name=hdfs://xxx``` entry to the core-site.xml, but *only at the first time, if config file doesn't exists```

## Running with docker compose

```
cd compose/yarn
docker-compose up -d
cd ../../compose/hdfs
docker-compose up -d

```

If you need you can scale up the datanode and nodemanagers:

```
sudo docker-compose scale datanode=2
```
