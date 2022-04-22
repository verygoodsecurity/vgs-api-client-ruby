#!/usr/bin/env bash

set -e

echo "Installing lib from rubygems.org ${LIB_VERSION} ..."

set +e
ATTEMPT=1
while [  $ATTEMPT -lt 10 ]; do
  echo "Attempt ${ATTEMPT} ..."

  gem install vgs_api_client -v ${LIB_VERSION}

  if [[ $? == 0 ]]; then
    echo "Installed ${LIB_VERSION}"
    break
  fi

  ATTEMPT=$((ATTEMPT+1))

  sleep 5
done
set -e

echo "Running tests"
gem install rspec
rspec -f documentation ./spec/*.rb

