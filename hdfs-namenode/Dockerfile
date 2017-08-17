FROM flokkr/hadoop:build
RUN sudo adduser -h /opt/ -s /bin/bash -G flokkr -D hdfs
USER hdfs
ADD starter.sh /opt/
CMD ["/opt/starter.sh"]

