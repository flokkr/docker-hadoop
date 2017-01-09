
## Running with docker compose

For running the example compose files you need an external network with the name hadoop:

```
docker network create --driver=bridge hadoop
````

With the haddop network you can start the instances.

```
cd examples/compose/yarn
docker-compose up -d
cd ../../compose/hdfs
docker-compose up -d
```

If you need you can scale up the datanode and nodemanagers:

```
sudo docker-compose scale datanode=2
```
