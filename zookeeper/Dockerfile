FROM elek/bigdata-base 
RUN wget http://xenia.sote.hu/ftp/mirrors/www.apache.org/zookeeper/zookeeper-3.4.9/zookeeper-3.4.9.tar.gz -O zookeeper.tar.gz && tar zxf zookeeper.tar.gz && mv /usr/hdp/zookeeper-3.4.9 /usr/hdp/zookeeper && rm zookeeper.tar.gz
ADD zoo.cfg /usr/hdp/zookeeper/conf
ENTRYPOINT /usr/hdp/zookeeper/bin/zkServer.sh start-foreground
