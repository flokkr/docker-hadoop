

VERSION ?= ozone  
URL ?= "https://ci.anzix.net/job/hadoop-ozone/lastSuccessfulBuild/artifact/hadoop-dist/target/hadoop-3.1.0-SNAPSHOT.tar.gz"
WORKDIR ?= hadoop/workdir
PRODUCT_DIR ?= $(WORKDIR)/hadoop
DOWNLOADED_FILE ?= $(WORKDIR)/hadoop.tar.gz
REPO ?= $(REPO)

build: $(HADOOP_PRODUCT_DIR)
	docker build -t $(REPO)/hadoop-runner:$(VERSION) runner
	#Tag the current runnier independent from the version
	docker tag $(REPO)/hadoop-runner:$(VERSION) flokkr/hadoop-runner:build
	docker build --build-arg hadoop_dir=$(PRODUCT_DIR) -t $(REPO)/hadoop:$(VERSION) hadoop
	#Tag the base image with hadoop, too
	docker tag $(REPO)/hadoop:$(VERSION) flokkr/hadoop:build
	docker build -t $(REPO)/hadoop-hdfs-namenode:$(VERSION) hdfs-namenode
	docker build -t $(REPO)/hadoop-hdfs-datanode:$(VERSION) hdfs-datanode
	docker build -t $(REPO)/hadoop-yarn-resourcemanager:$(VERSION) yarn-resourcemanager
	docker build -t $(REPO)/hadoop-yarn-nodemanager:$(VERSION) yarn-nodemanager

deploy:
	docker push $(REPO)/hadoop-runner:$(VERSION)
	docker push $(REPO)/hadoop:$(VERSION)
	docker push $(REPO)/hadoop-hdfs-namenode:$(VERSION)
	docker push $(REPO)/hadoop-hdfs-datanode:$(VERSION)
	docker push $(REPO)/hadoop-yarn-resourcemanager:$(VERSION)
	docker push $(REPO)/hadoop-yarn-nodemanager:$(VERSION)


$(DOWNLOADED_FILE):
	mkdir -p $(CURDIR)/$(WORKDIR_DIR)
	wget $(URL) -O $(CURDIR)/$(DOWNLOADED_FILE)


$(PRODUCT_DIR): $(DOWNLOADED_FILE)
	mkdir -p $(PRODUCT_DIR)
	tar zxf $(DOWNLOADED_FILE) -C $(PRODUCT_DIR) --strip-components=1


clean:
		  rm -rf $(CURDIR)/$(WORKDIR)

.PHONY: deploy build clean
