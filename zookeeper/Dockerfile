FROM elek/bigdata-base 
RUN wget http://xenia.sote.hu/ftp/mirrors/www.apache.org/zookeeper/zookeeper-3.4.9/zookeeper-3.4.9.tar.gz -O zookeeper.tar.gz && tar zxf zookeeper.tar.gz && mv /opt/zookeeper-3.4.9 /opt/zookeeper && rm zookeeper.tar.gz
ADD zoo.cfg /opt/zookeeper/conf
ENTRYPOINT /opt/zookeeper/bin/zkServer.sh start-foreground
