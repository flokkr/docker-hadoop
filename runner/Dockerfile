FROM flokkr/base:25
RUN apk add --update --no-cache libstdc++
RUN adduser -h /opt/ -s /bin/bash -G flokkr -D hadoop && chown hadoop /opt
USER hadoop
VOLUME /data
RUN sudo chown hadoop /data
ADD 012_namenodeformat /opt/launcher/plugins/012_namenodeformat
RUN sudo chmod o+x /opt/launcher/plugins/012_namenodeformat/namenodeformat.sh
ADD 013_scminit /opt/launcher/plugins/013_scminit
RUN sudo chmod o+x /opt/launcher/plugins/013_scminit/scminit.sh
ENV CONF_DIR /opt/hadoop/etc/hadoop
ENV PATH $PATH:/opt/hadoop/bin
ENV JAVA_OPTS_VAR HADOOP_OPTS
