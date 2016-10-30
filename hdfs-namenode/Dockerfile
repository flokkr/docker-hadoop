FROM hadoop
ADD core-site.xml /usr/hdp/hadoop/etc/hadoop/core-site.xml
RUN /usr/hdp/hadoop/bin/hdfs namenode -format 
ENTRYPOINT /usr/hdp/hadoop/bin/hdfs namenode

