FROM elek/bigdata-base:2 
ADD url .
RUN wget `cat url` && tar zxf hadoop-2.7.3.tar.gz && mv /opt/hadoop-2.7.3 /opt/hadoop && rm hadoop-2.7.3.tar.gz
RUN mv /opt/hadoop/etc/hadoop /opt/hadoop/etc/hadoop.orig && mkdir -p /opt/hadoop/etc/hadoop
