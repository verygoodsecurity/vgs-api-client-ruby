#!/usr/bin/env bash

set -e

echo "Installing lib from local sources"
# fix version
VERSION=0.0.1.alpha$(date "+%Y%m%d%H%M")
grep -rl XXX.YYY.ZZZ . | xargs sed -i "s/XXX.YYY.ZZZ/$VERSION/g"

bundle install

echo "Running tests"
bundle exec rspec -f documentation ./spec/*.rb
