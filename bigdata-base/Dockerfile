FROM frolvlad/alpine-oraclejdk8:cleaned 
RUN apk add --update bash ca-certificates openssl jq && rm -rf /var/cache/apk/* && update-ca-certificates
WORKDIR /opt
RUN wget https://releases.hashicorp.com/consul-template/0.16.0/consul-template_0.16.0_linux_amd64.zip -O consul-template.zip && unzip consul-template.zip && rm consul-template.zip && mv consul-template /usr/bin
COPY hadoop-configurator.sh .
