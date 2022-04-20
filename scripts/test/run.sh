#!/usr/bin/env bash

set -e

rm vgs_api_client-*.gem || true

if [[ -n "${LIB_VERSION}" ]]; then
  echo "Installing lib from rubygems.org ${LIB_VERSION} ..."

  set +e
  ATTEMPT=1
  while [  $ATTEMPT -lt 60 ]; do
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
else
  echo "Installing lib from local sources"
  bundle install
fi

bundle exec rspec ./spec/*.rb
