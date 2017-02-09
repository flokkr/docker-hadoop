FROM elek/bigdata-base:10
ENV CONF_DIR /opt/hadoop/etc/hadoop
ENV PATH $PATH:/opt/hadoop/bin
ADD url .
RUN wget `cat url` -O hadoop.tar.gz && tar zxf hadoop.tar.gz && rm hadoop.tar.gz && mv hadoop* hadoop
RUN mv /opt/hadoop/etc/hadoop /opt/hadoop/etc/hadoop.orig && mkdir -p /opt/hadoop/etc/hadoop
