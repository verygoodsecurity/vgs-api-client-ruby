#!/bin/bash

LIB_VERSION=${LIB_VERSION:-0.0.1.alpha$(date "+%Y%m%d%H%M")}

# fix version
grep -rl XXX.YYY.ZZZ . | xargs sed -i "s/XXX.YYY.ZZZ/${LIB_VERSION}/g"

# build
gem build vgs_api_client.gemspec
