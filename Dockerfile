ARG BASE=latest
FROM flokkr/base:${BASE}
ARG ARTIFACTDIR
RUN useradd --uid 1000 hadoop --gid 1000 -G flokkr --home /opt/hadoop && chown hadoop /opt
USER hadoop
VOLUME /data
RUN sudo chown hadoop /data
ADD 012_hdfsinit /opt/launcher/plugins/012_hdfsinit
RUN sudo chmod o+x /opt/launcher/plugins/012_hdfsinit/hdfsinit.sh
ADD --chown=hadoop:flokkr ${ARTIFACTDIR} /opt/hadoop
ENV CONF_DIR /opt/hadoop/etc/hadoop
ENV PATH $PATH:/opt/hadoop/bin
ENV JAVA_OPTS_VAR HADOOP_OPTS
RUN chmod 775 /opt/hadoop/etc/hadoop
WORKDIR /opt/hadoop
ADD log4j.properties /opt/hadoop/etc/hadoop/log4j.properties
#We nedd logs directory writable from hadoop3
RUN mkdir /opt/hadoop/logs && sudo chown -R hadoop /opt/hadoop/etc && chmod g+rwx /opt/hadoop/logs
