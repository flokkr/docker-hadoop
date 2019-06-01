FROM flokkr/hadoop-runner:build
ADD url .
RUN wget `cat url` -O hadoop.tar.gz && tar zxf hadoop.tar.gz && rm hadoop.tar.gz && mv hadoop* hadoop && rm -rf /opt/hadoop/share/doc
RUN chmod 775 /opt/hadoop/etc/hadoop
WORKDIR /opt/hadoop
ADD log4j.properties /opt/hadoop/etc/hadoop/log4j.properties
#We nedd logs directory writable from hadoop3
RUN mkdir /opt/hadoop/logs
RUN sudo chown -R hadoop /opt/hadoop/etc
RUN chmod g+rwx /opt/hadoop/logs
