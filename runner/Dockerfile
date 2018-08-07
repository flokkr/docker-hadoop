ARG BASE=32
FROM flokkr/base:${BASE}
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
