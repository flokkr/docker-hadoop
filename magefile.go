// +build mage

package main

import (
	"github.com/getlantern/errors"
	"fmt"
	"github.com/magefile/mage/sh"
	"net/http"
)

var name = "hadoop"
var downloadPath = "hadoop/common/hadoop-%s/hadoop-%s.tar.gz"

func versions() map[string][]string {
	versions := make(map[string][]string)
	versions["3.2.1"] = []string{"latest", "3.2.1", "3.2", "3"}
//	versions["3.1.2"] = []string{"3.1.2", "3.1"}
//	versions["3.1.1"] = []string{"3.1.1"}
//	versions["3.1.0"] = []string{"3.1.0"}
//	versions["3.0.3"] = []string{"3.0.3", "3.0"}
	return versions
}

func buildImage(tag string, dir string, url string) {
    sh.Run("docker", "build", "-t", tag, "--build-arg", "URL="+url, dir)
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
	if err != nil {
		return err
	}
	buildImage("flokkr/hadoop:build", ".", url)
	for _, tag := range tags {
		sh.Run("docker", "tag", "flokkr/hadoop:build", "flokkr/hadoop:"+tag)
	}
	return nil
}

func Build() error {
	for version, tags := range versions() {
		err := buildContainer(version, tags)
		if err != nil {
			return err
		}
	}
	return nil
}

func Deploy() error {
	for _, tags := range versions() {
		for _, tag := range tags {
			deployImage("flokkr/hadoop:" + tag)
		}
	}
	return nil
}
