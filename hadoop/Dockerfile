FROM frolvlad/alpine-oraclejdk8:cleaned 
RUN apk add --update bash ca-certificates openssl && rm -rf /var/cache/apk/* && update-ca-certificates
WORKDIR /usr/hdp
RUN wget http://xenia.sote.hu/ftp/mirrors/www.apache.org/hadoop/common/hadoop-2.7.3/hadoop-2.7.3.tar.gz && tar zxf hadoop-2.7.3.tar.gz && mv /usr/hdp/hadoop-2.7.3 /usr/hdp/hadoop && rm hadoop-2.7.3.tar.gz
RUN mv /usr/hdp/hadoop/etc/hadoop /usr/hdp/hadoop/etc/hadoop.orig && mkdir -p /usr/hdp/hadoop/etc/hadoop
RUN wget https://releases.hashicorp.com/consul-template/0.16.0/consul-template_0.16.0_linux_amd64.zip -O consul-template.zip && unzip consul-template.zip && rm consul-template.zip && mv consul-template /usr/bin
COPY hadoop-configurator.sh .
COPY conf.awk .
