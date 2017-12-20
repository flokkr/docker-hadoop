

VERSION ?= latest
URL ?= "https://www-eu.apache.org/dist/hadoop/common/hadoop-3.0.0/hadoop-3.0.0.tar.gz"

build:
	echo $(URL) > hadoop/url
	docker build -t flokkr/hadoop-runner:$(VERSION) runner
	docker tag flokkr/hadoop-runner:$(VERSION) flokkr/hadoop-runner:build
	docker build -t flokkr/hadoop:$(VERSION) hadoop
	docker tag flokkr/hadoop:$(VERSION) flokkr/hadoop:build
	docker build -t flokkr/hadoop-hdfs-namenode:$(VERSION) hdfs-namenode
	docker build -t flokkr/hadoop-hdfs-datanode:$(VERSION) hdfs-datanode
	docker build -t flokkr/hadoop-yarn-resourcemanager:$(VERSION) yarn-resourcemanager
	docker build -t flokkr/hadoop-yarn-nodemanager:$(VERSION) yarn-nodemanager

deploy:
	docker push flokkr/hadoop-runner:$(VERSION)
	docker push flokkr/hadoop:$(VERSION)
	docker push flokkr/hadoop-hdfs-namenode:$(VERSION)
	docker push flokkr/hadoop-hdfs-datanode:$(VERSION)
	docker push flokkr/hadoop-yarn-resourcemanager:$(VERSION)
	docker push flokkr/hadoop-yarn-nodemanager:$(VERSION)

.PHONY: deploy build
