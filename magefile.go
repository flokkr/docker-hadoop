// +build mage

package main

import (
    "io/ioutil"
    "fmt"
	"github.com/magefile/mage/sh" 
)

func versions() map[string][]string {
   versions := make(map[string][]string)
   versions["3.2.0"] = []string{"latest", "3.2.0", "3.2", "3"}
   versions["3.1.2"] = []string{"3.1.2", "3.1" }
   return versions
}

func buildImage(tag string, dir string) {
   sh.Run("docker","build","-t",tag , dir)
}

func deployImage(tag string) {
  sh.Run("docker","push", tag)
}

func buildContainer(version string, tags []string) error {
    url := fmt.Sprintf("https://www-eu.apache.org/dist/hadoop/common/hadoop-%s/hadoop-%s.tar.gz", version, version)
    err := ioutil.WriteFile("hadoop/url", []byte(url), 0644)
    if err != nil {
        return err
   }
   buildImage("flokkr/hadoop:build", "hadoop")
   for _, tag := range tags {
       sh.Run("docker", "tag", "flokkr/hadoop:build", "flokkr/hadoop:" + tag)
   }
   return nil
}

func Build() error {
    buildImage("flokkr/hadoop-runner:build","runner")
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
