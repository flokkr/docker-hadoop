FROM elek/bigdata-base 
RUN wget http://xenia.sote.hu/ftp/mirrors/www.apache.org/hbase/1.2.4/hbase-1.2.4-bin.tar.gz -O hbase.tar.gz && tar zxf hbase.tar.gz && mv /opt/hbase-1.2.4 /opt/hbase && rm hbase.tar.gz
RUN mv /opt/hbase/conf /opt/hbase/conf.orig
