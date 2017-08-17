FROM flokkr/hadoop:build
RUN sudo adduser -h /opt/ -s /bin/bash -G flokkr -D yarn
USER yarn
CMD ["/opt/hadoop/bin/yarn resourcemanager"]

