FROM elek/bigdata-base 
RUN wget http://xenia.sote.hu/ftp/mirrors/www.apache.org/hbase/1.2.4/hbase-1.2.4-bin.tar.gz -O hbase.tar.gz && tar zxf hbase.tar.gz && mv /usr/hdp/hbase-1.2.4 /usr/hdp/hbase && rm hbase.tar.gz
RUN mv /usr/hdp/hbase/conf /usr/hdp/hbase/conf.orig
