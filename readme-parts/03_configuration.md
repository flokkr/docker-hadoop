## Configuration loading

The containers supports multiple configuration loading mechanism. (All of the configuration loading is defined in the [base-docker](https://github.com/elek/docker-bigdata-base) image. The configuration methods are stored in the ```/opt/configuration``` directory and could be selected by setting the environment variable `CONFIG_TYPE`

You can see various example configuration, ansible and docker-compose scripts at the main [umbrella repository](https://github.com/elek/bigdata-docker).

The three main configuration loading mechanis is:

 * ```CONFIG_TYPE=simple```: Using some simple default and configuration defined with environment variables.
 * ```CONFIG_TYPE=consul```: Using configuration files (and not list of ```key: value``` pairs) stored in a consul. Supports dynamic restart if the configuration is changing.
 * ```CONFIG_TYPE=springconfig```: Using configuration from the spring config server.

### Simple configuration

This is the default configuration.

Main behaviours:

 * Every configuration file is defined with a list of ```key: value``` pairs, even if they will be converted finally to hadoop xml format
 * The configfile creation process follows the steps:
    * Copy the defaults file (from ```/opt/defaults```) to the destination dir (defined by the environment variable ```CONF_DIR```). These files contain key value pairs.
    * Append the configuration parameter from the environment variable according to a naming convention. For example ```CORE-SITE_fs.default.name=hdfs://localhost:9000``` will be copied to the ```core-site.xml```
    * Transform the result file (defaults + value from env) to the final configuration based on the extension. For example if the extension is xml then the key value pairs will be converted to HADOOP xml file format.
 
#### Naming convention for set config keys from enviroment variables

To set any configuration variable you shold follow the following pattern:

```
NAME.EXTENSION.configkey=VALUE
```
  
The extension could be any extension which has a predefined transformation (currently xml, yaml, properties, configuration, yaml, env, sh)

In case there is a default configuration file in the ```/opt/defaults``` the ```EXTENSION``` part is optional as the extenasion (which is the base of the transformation selection) could be determined by name:

```
NAME.configkey=VALUE
```
  
You can also you dot instead of underscores:

```
NAME.EXTENSION_configkey=VALUE
NAME_configkey=VALUE
```

examples:

```
CORE-SITE_fs.default.name: "hdfs://localhost:9000"
HDFS-SITE_dfs_namenode_rpc-address: "localhost:9000"
HBASE-SITE.XML_hbase_zookeeper_quorum: "localhost"
```

#### Example

The simple directory in the [bigdata-docker](https://github.com/elek/bigdata-docker) project contains a [docker-compose](https://github.com/elek/bigdata-docker/blob/master/simple/docker-compose.yaml) example using simple configuration loading

### Consul config loading

Could be activated with ```CONFIG_TYPE=consul```

* The starter script list the configuration file names based on a consul key prefix. All the files will be downloaded from the consul key value store and the application process will be started with consul-template (enable an automatic restart in case of configuration file change)
* ```CONSUL_PATH``` contains the prefix of the subtree in the consul key value store (default is ```conf```)
* if ``CONSUL_PATH`` is not set you can use ``CONSUL_PREFIX`` and ``CONSUL_KEY`` values. As the default ``CONSUL_PREFIX`` is ``config``, it's enough to set the ``CONSUL_KEY`` if the configuration is under the key  ``config/something``
* Consul server location could set with ```CONSUL_SERVER``` environment variable (default is ```localhost:8500```)

### Spring conig server configuration loading

In this case the configuration files will be downloaded from spring config server with the following convention:

Spring application is used as the config file name (eg. core-site.xml and as the ```-``` is prohibiited, ```core_site```)
Spring profile is used as the configuration/component name (eg. hdfs or namenode)

The config server first download the list of the actual configuration files for the current CONFIG_TYPE. (spring application name is bigdata, profile is the $CONFIG_TYPE)

For example:

```
configfiles:
     hdfs:
        core_site: xml
        hdfs_site: xml
        log4j: properties
     hbase:
        core_site: xml
        hdfs_site: xml
        log4j: properties
        hbase: xml
```

At the next step we download the required files one by one and convert to the desired file format (properties, xml, ...)

#### Configuration

* ``CONFIG_SERVER_URL``: the url of the config server eg. http://localhost:8888
* ``CONFIG_GROUP``: the profile part of the config server query (eg. hdfs, namenode, etc.)
* ``CONF_DIR``: the destination directory