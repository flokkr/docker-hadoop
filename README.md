# Apache Hadoop docker images

These images are part of the Bigdata [docker image series](https://github.com/flokkr). All of the images use the same [base docker image](https://github.com/flokkr/docker-baseimage) which contains [plugin scripts](https://github.com/flokkr/launcher/) to launch different project in containerized environments.

For more detailed instruction about the available environment variables see the [README](https://github.com/flokkr/docker-baseimage/blob/master/README.md) in the `flokkr/docker-baseimage` repository.

Docker images are tested with Kubernetes

## Getting started with Kubernetes

The easiest way to start is to do a `kubectl apply -f .` from the `./exmaples` directories (Using ephemeral storage!)

For more specific use case it's recommended to use [flekszible](https://github.com/elek/flekszible). The resource definitions can be found in this repository (`./hadoop`,`./hdfs`,`./yarn`...)

### Getting started with Flekszible

Install Flekszible ([download  binary](https://github.com/elek/flekszible/releases) and put it to the path)

1. Create a working dir

```
cd /tmp
mkdir cluster
cd cluster
```

2. Add this repository as a source

```
flekszible source add github.com/flokkr/docker-hadoop
```

3. Choose and add required services:

```
flekszible app add hdfs
```

4. Generate Kubernetes resource files

```
flekszible generate 
```

5. Lunch the rockets:

```
kubectl apply -f .
```

### Additional Flekszible options

You can list available apps (after source import):

```
flekszible app search
+---------+-------------------------------+
| path    | description                   |
+---------+-------------------------------+
| hdfs    | Apache Hadoop HDFS base setup |
| hdfs-ha | Apache Hadoop HDFS, HA setup  |
...
```

 The base setup can be modified with additional transformatios:

```
flekszible definitions search | grep hdfs
...
| hdfs/persistence    | Add real PVC based persistence                                                             |
| hdfs/onenode        | remove scheduling rules to make it possible to run multiple datanode on the same k8s node. |
...
```

 You can apply transformations with modifing the `Flekszible` descriptor file: 

Original version:

```yaml
source:
- url: github.com/flokkr/docker-hadoop
import:
- path: hdfs
```


Modified:

```yaml
source:
- url: github.com/flokkr/docker-hadoop
import:
- path: hdfs
  transformations:
  - type: hdfs/onenode
  - type: image
    image: flokkr/hadoop:3.2.0
```
