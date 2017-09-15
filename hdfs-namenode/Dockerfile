FROM flokkr/hadoop:build
RUN sudo adduser -h /opt/ -s /bin/bash -G flokkr -D hdfs
USER hdfs
RUN sudo chown hdfs -R /opt/hadoop/etc
ADD starter.sh /opt/
CMD ["/opt/starter.sh"]

