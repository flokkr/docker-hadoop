## Configuration loading

The containers supports multiple configuration loading mechanism. (All of the configuration loading is defined in the [base-docker](https://github.com/elek/docker-bigdata-base) image. The configuration methods are stored in the `/opt/configurer` and `/opt/configuration` directory and could be selected by setting the environment variable `CONFIG_TYPE`

You can see various example configuration, ansible and docker-compose scripts at the main [umbrella repository](https://github.com/elek/bigdata-docker).

The three main configuration loading mechanis is:

 * ```CONFIG_TYPE=simple```: Using some simple default and configuration defined with environment variables.
 * ```CONFIG_TYPE=consul```: Using configuration files (and not list of ```key: value``` pairs) stored in a consul. Supports dynamic restart if the configuration is changing.
 * ```CONFIG_TYPE=springconfig```: Using configuration from the spring config server.

### Simple configuration

This is the default configuration.

Every configuration file is defined with a list of ```key: value``` pairs, even if they will be converted finally to hadoop xml format. The destination format is defined by the extensions (or by an additional format specifier)

The generated files will be saved to the `$CONF_DIR` directory.

#### Naming convention for set config keys from enviroment variables

To set any configuration variable you shold follow the following pattern:

```
NAME.EXTENSION_configkey=VALUE
```

The extension could be any extension which has a predefined transformation (currently xml, yaml, properties, configuration, yaml, env, sh, conf, cfg)

examples:

```
CORE-SITE_fs.default.name: "hdfs://localhost:9000"
HDFS-SITE_dfs_namenode_rpc-address: "localhost:9000"
HBASE-SITE.XML_hbase_zookeeper_quorum: "localhost"
```

In some rare cases the transformation and the extension should be different. For example the kafka `server.properties` should be in the format `key=value` which is the `cfg` transformation in our system. In that case you can postfix the extension with an additional format specifier:


```
NAME.EXTENSION!FORMAT_configkey=VALUE
```

For example:

```
SERVER.CONF!CFG_zookeeper.address=zookeeper:2181
```

#### Available transformation

 * xml: HADOOP xml file format
 * properties: key value pairs with ```:``` as separator
 * cfg: key value pairs with ```=``` as separator
 * conf: key value pairs with space as spearator (spark-defaults is an example)
 * env: key value paris with ```=``` as separator
 * sh: as the env but also includes the export keyword
 * yaml: yaml file representation (only basic map and list are supported)
 * yml: same

#### Example

The simple directory in the [bigdata-docker](https://github.com/elek/bigdata-docker) project contains a [docker-compose](https://github.com/elek/bigdata-docker/blob/master/simple/docker-compose.yaml) example using simple configuration loading.

### Consul config loading

Could be activated with ```CONFIG_TYPE=consul```

* The starter script list the configuration file names based on a consul key prefix. All the files will be downloaded from the consul key value store and the application process will be started with consul-template (enable an automatic restart in case of configuration file change)

* With a `config.ini` (also uploaded to consul) you can set execute additional processing _after_ the file is downloaded from the consul:

   1. transformation: will transform the files according specific transformation. Currently only one transformation available: _template_, which renders the final file via Jinja2 (environment variables are replace)

   2. post_write_hook: will execute  the downloaded files.

Both the transformation and post_write_hook could be configured by the config.ini with file name based regular expression.

Example config.ini:

```
[transformation]
template=.*\.xml

[post_write_hook]
execute=.*\.init
```

#### Configuration

 * `CONSUL_PATH` defines the root of the subtree where the configuration are downloaded from. The root could also contain a configuration `config.ini`. Default is `conf`

 *  `CONSUL_KEY` is optional. It defines a subdirectory to download the the config files. If both `CONSUL_PATH` and `CONSUL_KEY` are defined, the config files will be downloaded from `$CONSUL_PATH/$CONSUL_KEY` but the config file will be read from `$CONSUL_PATH/config.ini`
