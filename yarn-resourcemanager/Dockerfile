FROM elek/hadoop
EXPOSE 8080
COPY start.sh .
COPY yarn-site.default /opt/hadoop/etc/hadoop/yarn-site.default
COPY capacity-scheduler.xml.default /opt/hadoop/etc/hadoop/capacity-scheduler.xml.default
ENTRYPOINT /opt/start.sh

