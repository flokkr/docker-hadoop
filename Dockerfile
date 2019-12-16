ARG BASE=33
FROM flokkr/base:${BASE}
ARG URL
RUN apk add --update --no-cache libstdc++ findutils ncurses && rm -rf /var/cache/apk/*
RUN adduser -h /opt/ -s /bin/bash -G flokkr -D hadoop && chown hadoop /opt
USER hadoop
VOLUME /data
RUN sudo chown hadoop /data
ADD 012_hdfsinit /opt/launcher/plugins/012_hdfsinit
RUN sudo chmod o+x /opt/launcher/plugins/012_hdfsinit/hdfsinit.sh
ENV CONF_DIR /opt/hadoop/etc/hadoop
ENV PATH $PATH:/opt/hadoop/bin
ENV JAVA_OPTS_VAR HADOOP_OPTS
RUN wget $URL -O hadoop.tar.gz && tar zxf hadoop.tar.gz && rm hadoop.tar.gz && mv hadoop* hadoop && rm -rf /opt/hadoop/share/doc
RUN chmod 775 /opt/hadoop/etc/hadoop
WORKDIR /opt/hadoop
ADD log4j.properties /opt/hadoop/etc/hadoop/log4j.properties
#We nedd logs directory writable from hadoop3
RUN mkdir /opt/hadoop/logs && sudo chown -R hadoop /opt/hadoop/etc && chmod g+rwx /opt/hadoop/logs
