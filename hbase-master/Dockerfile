FROM elek/hbase 
EXPOSE 16010
COPY start.sh .
COPY hbase-site.default /usr/hdp/hbase/conf/hbase-site.default
COPY log4j.properties /usr/hdp/hbase/conf/
ENTRYPOINT /usr/hdp/start.sh

