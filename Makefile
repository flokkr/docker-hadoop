VERSION ?= latest
URL ?= "https://www-eu.apache.org/dist/hadoop/common/hadoop-3.1.0/hadoop-3.1.0.tar.gz"

build:
	echo $(URL) > hadoop/url
	docker build -t flokkr/hadoop-runner:$(VERSION) runner
	docker tag flokkr/hadoop-runner:$(VERSION) flokkr/hadoop-runner:build
	docker build -t flokkr/hadoop:$(VERSION) hadoop
deploy:
	docker push flokkr/hadoop-runner:$(VERSION)
	docker push flokkr/hadoop:$(VERSION)

.PHONY: deploy build
