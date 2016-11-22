FROM elek/bigdata-base 
RUN wget http://xenia.sote.hu/ftp/mirrors/www.apache.org/hadoop/common/hadoop-2.7.3/hadoop-2.7.3.tar.gz && tar zxf hadoop-2.7.3.tar.gz && mv /usr/hdp/hadoop-2.7.3 /usr/hdp/hadoop && rm hadoop-2.7.3.tar.gz
RUN mv /usr/hdp/hadoop/etc/hadoop /usr/hdp/hadoop/etc/hadoop.orig && mkdir -p /usr/hdp/hadoop/etc/hadoop
