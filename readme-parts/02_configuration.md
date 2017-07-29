
## Configuration and extensions

The flokkr containers support multiple configuration loading mechanism and various extensions. All of the these are defined in the [flokkr baseimage](https://github.com/flokkr/docker-baseimage) and could be activated by environment variables.

The available plugins:

| Name      | Description                              |
| --------- | ---------------------------------------- |
| envtoconf | **Simple onfiguration loading**, suggested for stand-alone docker files. Converts environment variables to xml/property configuration based on naming convention |
| consul    | **Complex configuration loading from consul**, downloads configuration from consul server and restart when the configuration is changed. Suggested for multi-host setups. |
| btrace    | Instruments the java option with custom Btrace script (with modifying the JAVA_OPTS) |

### Plugin details

#### ENVTOCONF: Simple configuration loading

Could be activated by ```CONFIG_TYPE=simple``` settings, but it's the default.

Every configuration could be defined with environment variables, and they will be converted finally to *hadoop xml, properties, conf* or other format. The destination format (and the destination file name) is defined with the name of the environment variable according to a naming convention.

The generated files will be saved to the `$CONF_DIR` directory.

The source code of the converter utility can be found in a [separated repository](https://github.com/elek/envtoconf).

##### Naming convention for set config keys from enviroment variables

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

##### Available transformation

*  xml: HADOOP xml file format

*  properties: key value pairs with ```:``` as separator

*  cfg: key value pairs with ```=``` as separator

*  conf: key value pairs with space as spearator (spark-defaults is an example)

*  env: key value paris with ```=``` as separator

*  sh: as the env but also includes the export keyword

     ##### Configuration reference

     The plugin itself could be configured with the following environment variables.

   | Name        | Default                                  | Description                              |
   | ----------- | ---------------------------------------- | ---------------------------------------- |
   | CONF_DIR    | *Set in the docker container definitions* | The location where the configuration files will be saved. |
   | CONFIG_TYPE | simple                                   | For compatibility reason. If the value is simple, the conversion is active. |

#### CONSUL: Consul config loading

Could be activated with ```CONFIG_TYPE=consul```

* The starter script list the configuration file names based on a consul key prefix. All the files will be downloaded from the consul key value store and the application process will be started with consul-template (enable an automatic restart in case of configuration file change)

The source code of the consul based configuration loading and launcher is available at the [elek/consul-launcher](https://github.com/elek/consul-launcher) repository.

| Name        | Default                                  | Description                              |
| ----------- | ---------------------------------------- | ---------------------------------------- |
| CONF_DIR    | *Set in the docker container definitions* | The location where the configuration files will be saved. |
| CONFIG_TYPE | consul                                   | For compatibility reason. If the value is consul, the consul based configuration handling is active. |
| CONSUL_PATH | conf                                     | The path of the subtree in the consul where the configurations are. |
| CONSUL_KEY  |                                          | The  path where the configuration for this container should be downloaded from. The effective path will be ```$CONSUL_PATH/$CONSUL_KEY``` |

#### BTRACE: btrace instrumentation

Could be enabled with setting ```BTRACE_ENABLED=true``` or just setting ```BTRACE_SCRIPT```.

It adds btrace javaagent configuration to the JAVA_OPTS (or any other opts defined by BTRACE_OPTS_VAR). The standard output is redirected to ```/tmp/output.log```, and the btrace output will be displayed on the standard output (over a ```/tmp/btrace.out``` file)

| Name            | Default                                  | Description                              |
| --------------- | ---------------------------------------- | ---------------------------------------- |
| CONF_DIR        | *Set in the docker container definitions* | The location where the configuration files will be saved. |
| BTRACE_SCRIPT   | <notset>                                 | The location of the compiled btrace script. Coule be absolute or relative to the ```/opt/plugins/020_btrace/btrace``` |
| BTRACE_OPTS_VAR | JAVA_OPTS                                | The name of the shell variable where the agent parameters should be injected. |


#### Configuration

* `CONSUL_PATH` defines the root of the subtree where the configuration are downloaded from. The root could also contain a configuration `config.ini`. Default is `conf`

* `CONSUL_KEY` is optional. It defines a subdirectory to download the the config files. If both `CONSUL_PATH` and `CONSUL_KEY` are defined, the config files will be downloaded from `$CONSUL_PATH/$CONSUL_KEY` but the config file will be read from `$CONSUL_PATH/config.ini`
