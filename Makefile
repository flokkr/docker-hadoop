

VERSION ?= latest
URL ?= "http://xenia.sote.hu/ftp/mirrors/www.apache.org/hadoop/common/hadoop-2.8.1/hadoop-2.8.1.tar.gz"

build:
	echo $(URL) > hadoop/url
	docker build -t flokkr/hadoop:$(VERSION) hadoop
	docker tag flokkr/hadoop:$(VERSION) flokkr/hadoop:build
	docker build -t flokkr/hadoop-hdfs-namenode:$(VERSION) hdfs-namenode
	docker build -t flokkr/hadoop-hdfs-datanode:$(VERSION) hdfs-datanode
	docker build -t flokkr/hadoop-yarn-resourcemanager:$(VERSION) yarn-resourcemanager
	docker build -t flokkr/hadoop-yarn-nodemanager:$(VERSION) yarn-nodemanager

deploy:
	docker push flokkr/hadoop:$(VERSION)
	docker push flokkr/hadoop-hdfs-namenode:$(VERSION)
	docker push flokkr/hadoop-hdfs-datanode:$(VERSION)
	docker push flokkr/hadoop-resourcemanager:$(VERSION)
	docker push flokkr/hadoop-nodemanager:$(VERSION)
