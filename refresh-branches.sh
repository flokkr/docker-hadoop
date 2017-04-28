#!/usr/bin/env bash
cat versions  |  xargs -n2 echo ./merger.sh | bash
