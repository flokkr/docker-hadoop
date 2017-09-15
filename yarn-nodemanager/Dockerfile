FROM flokkr/hadoop:build
RUN sudo adduser -h /opt/ -s /bin/bash -G flokkr -D yarn
USER yarn
RUN sudo chown yarn -R /opt/hadoop/etc
CMD ["/opt/hadoop/bin/yarn nodemanager"]

