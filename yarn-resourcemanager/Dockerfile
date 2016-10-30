FROM elek/hadoop
EXPOSE 8080
COPY start.sh .
COPY yarn-site.default /usr/hdp/hadoop/etc/hadoop/yarn-site.default
COPY capacity-scheduler.xml.default /usr/hdp/hadoop/etc/hadoop/capacity-scheduler.xml.default
ENTRYPOINT /usr/hdp/start.sh

