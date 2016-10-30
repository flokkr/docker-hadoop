FROM elek/hadoop
ADD core-site.default /usr/hdp/hadoop/etc/hadoop/core-site.default
ADD hdfs-site.default /usr/hdp/hadoop/etc/hadoop/hdfs-site.default
ADD start.sh .
RUN /usr/hdp/hadoop/bin/hdfs namenode -format 
ENTRYPOINT /usr/hdp/start.sh

