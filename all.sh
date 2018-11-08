#!/usr/bin/env bash
./build.sh -t 3.1.1,3.1,3 -v 3.1.1 build
./build.sh -t 3.1.1,3.1,3 -v 3.1.1 deploy

./build.sh -t 3.1.0 -v 3.1.0 build
./build.sh -t 3.1.0 -v 3.1.0 deploy

./build.sh -t 3.0.3,3.0 -v 3.0.3 build
./build.sh -t 3.0.3,3.0 -v 3.0.3 deploy

./build.sh -t 3.0.2 -v 3.0.2 build
./build.sh -t 3.0.2 -v 3.0.2 deploy

./build.sh -t 3.0.1 -v 3.0.1 build
./build.sh -t 3.0.1 -v 3.0.1 deploy

./build.sh -t 3.0.0 -v 3.0.0 build
./build.sh -t 3.0.0 -v 3.0.0 deploy
