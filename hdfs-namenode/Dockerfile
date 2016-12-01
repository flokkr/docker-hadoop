FROM elek/hadoop
ADD core-site.default /opt/hadoop/etc/hadoop/core-site.default
ADD hdfs-site.default /opt/hadoop/etc/hadoop/hdfs-site.default
ADD start.sh .
RUN /opt/hadoop/bin/hdfs namenode -format 
ENTRYPOINT /opt/start.sh

