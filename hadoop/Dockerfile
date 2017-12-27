FROM flokkr/hadoop-runner:build
ADD --chown=hadoop:flokkr $hadoop_dir /opt/hadoop
WORKDIR /opt/hadoop
ADD log4j.properties /opt/hadoop/etc/hadoop/log4j.properties
#We nedd logs directory writable from hadoop3
RUN mkdir /opt/hadoop/logs
RUN chmod g+rwx /opt/hadoop/logs
