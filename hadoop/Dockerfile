FROM flokkr/hadoop-runner:build

#This is supported only from 17.09 (but kubernetes supports 17.03)
#ADD --chown=hadoop:flokkr $hadoop_dir /opt/hadoop

#This is a workaround but it double the size of the container
ADD $hadoop_dir /opt/hadoop
RUN sudo chown hadoop.flokkr -R /opt/hadoop 

WORKDIR /opt/hadoop
ADD log4j.properties /opt/hadoop/etc/hadoop/log4j.properties
#We nedd logs directory writable from hadoop3
RUN mkdir /opt/hadoop/logs
RUN chmod g+rwx /opt/hadoop/logs
