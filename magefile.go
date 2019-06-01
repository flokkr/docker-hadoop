// +build mage

package main

import (
	"github.com/getlantern/errors"
	"io/ioutil"
	"fmt"
	"github.com/magefile/mage/sh"
	"net/http"
)

var name = "hadoop"
var downloadPath = "hadoop/common/hadoop-%s/hadoop-%s.tar.gz"

func versions() map[string][]string {
	versions := make(map[string][]string)
	versions["3.2.0"] = []string{"latest", "3.2.0", "3.2", "3"}
	versions["3.1.2"] = []string{"3.1.2", "3.1"}
	versions["3.1.1"] = []string{"3.1.1"}
	versions["3.1.0"] = []string{"3.1.0"}
	versions["3.0.3"] = []string{"3.0.3", "3.0"}
	return versions
}

func buildImage(tag string, dir string) {
	sh.Run("docker", "build", "-t", tag, dir)
}

func getApacheDownloadUrl(path string) (string, error) {
	url := fmt.Sprintf("https://www-eu.apache.org/dist/" + path)
	resp, err := http.Head(url)
	if err != nil {
		return "", err
	}
	if resp.StatusCode == 200 {
		return url, nil
	}
	url = fmt.Sprintf("https://archive.apache.org/dist/" + path)
	resp, err = http.Head(url)
	if err != nil {
		return "", err
	}
	if resp.StatusCode == 200 {
		return url, nil
	}
	return "", errors.New("Can't find download url for " + path)

}
func deployImage(tag string) {
	sh.Run("docker", "push", tag)
}

func buildContainer(version string, tags []string) error {
	url, err := getApacheDownloadUrl(fmt.Sprintf(downloadPath, version, version))
	if err != nil {
		return err
	}
	err = ioutil.WriteFile("hadoop/url", []byte(url), 0644)
	if err != nil {
		return err
	}
	buildImage("flokkr/hadoop:build", "hadoop")
	for _, tag := range tags {
		sh.Run("docker", "tag", "flokkr/hadoop:build", "flokkr/hadoop:"+tag)
		sh.Run("docker", "tag", "flokkr/hadoop:build", "quay.io/flokkr/hadoop:"+tag)
	}
	return nil
}

func Build() error {
	buildImage("flokkr/hadoop-runner:build", "runner")
	for version, tags := range versions() {
		err := buildContainer(version, tags)
		if err != nil {
			return err
		}
		buildImage("flokkr/hadoop-test:build", "test")
		for _, tag := range tags {
			sh.Run("docker", "tag", "flokkr/hadoop:build", "flokkr/hadoop-test:"+tag)
			sh.Run("docker", "tag", "flokkr/hadoop:build", "quay.io/flokkr/hadoop-test:"+tag)
		}
	}
	return nil
}

func Deploy() error {
	for _, tags := range versions() {
		for _, tag := range tags {
			deployImage("flokkr/hadoop:" + tag)
			deployImage("flokkr/hadoop-test:" + tag)
			deployImage("quay.io/flokkr/hadoop:" + tag)
			deployImage("quay.io/flokkr/hadoop-test:" + tag)
		}
	}
	return nil
}
