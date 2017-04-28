#!/usr/bin/env bash
set -ex
git reset --hard
git clean -f
git checkout $1
git reset --hard master
git reset HEAD@{1}
BASE_IMAGE=$(basename $(dirname $(find -name baseimage)))
./branch.sh $1 $2
git add --all
git commit -m "sync to the master" || true
git checkout master
