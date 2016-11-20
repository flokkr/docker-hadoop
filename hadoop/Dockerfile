FROM frolvlad/alpine-oraclejdk8:cleaned 
RUN apk add --update bash && rm -rf /var/cache/apk/*
WORKDIR /usr/hdp
RUN wget http://xenia.sote.hu/ftp/mirrors/www.apache.org/hadoop/common/hadoop-2.7.3/hadoop-2.7.3.tar.gz && tar zxf hadoop-2.7.3.tar.gz && mv /usr/hdp/hadoop-2.7.3 /usr/hdp/hadoop && rm hadoop-2.7.3.tar.gz
RUN mv /usr/hdp/hadoop/etc/hadoop /usr/hdp/hadoop/etc/hadoop.orig && mkdir -p /usr/hdp/hadoop/etc/hadoop
COPY hadoop-configurator.sh .
COPY conf.awk .
