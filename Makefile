

VERSION ?= ozone  
URL ?= "https://ci.anzix.net/job/hadoop-ozone/lastSuccessfulBuild/artifact/hadoop-dist/target/hadoop-3.1.0-SNAPSHOT.tar.gz"
WORKDIR = hadoop/workdir
PRODUCT_DIR = $(WORKDIR)/hadoop
DOWNLOADED_FILE ?= $(WORKDIR)/hadoop.tar.gz


build: $(HADOOP_PRODUCT_DIR)
	docker build -t flokkr/hadoop-runner:$(VERSION) runner
	docker tag flokkr/hadoop-runner:$(VERSION) flokkr/hadoop-runner:build
	docker build --build-arg hadoop_dir=$(HADOOP_PRODUCT_DIR) -t flokkr/hadoop:$(VERSION) hadoop
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


$(DOWNLOADED_FILE):
	mkdir -p $(CURDIR)/$(WORKDIR_DIR)
	wget $(URL) -O $(CURDIR)/$(DOWNLOADED_FILE)


$(PRODUCT_DIR): $(DOWNLOADED_FILE)
	mkdir -p $(PRODUCT_DIR)
	tar zxf $(DOWNLOADED_FILE) -C $(PRODUCT_DIR) --strip-components=1


clean:
		  rm -rf $(CURDIR)/$(WORKDIR)

.PHONY: deploy build clean
