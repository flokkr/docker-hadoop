FROM flokkr/base:17
RUN apk add --update --no-cache libstdc++
VOLUME /data
ENV CONF_DIR /opt/hadoop/etc/hadoop 
ENV PATH $PATH:/opt/hadoop/bin
ENV BTRACE_OPTS_VAR HADOOP_OPTS
ADD url .
RUN wget `cat url` -O hadoop.tar.gz && tar zxf hadoop.tar.gz && rm hadoop.tar.gz && mv hadoop* hadoop && rm -rf /opt/hadoop/share/doc
RUN mv /opt/hadoop/etc/hadoop /opt/hadoop/etc/hadoop.orig && mkdir -p /opt/hadoop/etc/hadoop
ADD log4j.properties /opt/hadoop/etc/hadoop/log4j.properties
