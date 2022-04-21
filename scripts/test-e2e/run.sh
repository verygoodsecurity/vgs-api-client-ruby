#!/usr/bin/env bash

set -e

echo "Installing lib from rubygems.org ${LIB_VERSION} ..."

set +e
ATTEMPT=1
while [  $ATTEMPT -lt 10 ]; do
  echo "Attempt ${ATTEMPT} ..."

  bundle install --without production --binstubs
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
mv /vgs-api-client/tmp/Gemfile /vgs-api-client/
mv /vgs-api-client/tmp/vgs_api_client.gemspec /vgs-api-client/
bundle install --without production --binstubs
bundle exec rspec ./spec/*.rb
