#!/bin/bash

set -e

usage() { echo "Required env var '$1' is missing"; exit 1; }

[ -z "${ARTIFACT_REPOSITORY_TOKEN}" ] && usage "ARTIFACT_REPOSITORY_TOKEN" ;
[ -z "${LIB_VERSION}" ] && usage "LIB_VERSION" ;

mkdir ~/.gem
echo ":rubygems_api_key: ${ARTIFACT_REPOSITORY_TOKEN}" > ~/.gem/credentials
chmod 0600 ~/.gem/credentials

gem push vgs_api_client-${LIB_VERSION}.gem