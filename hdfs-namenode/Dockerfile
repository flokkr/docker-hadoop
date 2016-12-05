FROM elek/hadoop
ADD core-site.default /opt/hadoop/etc/hadoop/core-site.default
ADD hdfs-site.default /opt/hadoop/etc/hadoop/hdfs-site.default
ADD yarn-site.default /opt/hadoop/etc/hadoop/yarn-site.default
ADD start.sh .
RUN /opt/hadoop/bin/hdfs namenode -format 
CMD ["/opt/start.sh"]

