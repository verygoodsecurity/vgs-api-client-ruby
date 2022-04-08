#!/bin/sh

# Build
gem build vgs_api_client.gemspec

# Publish
mkdir ~/.gem
echo ":rubygems_api_key: ${GEM_VGS_PUBLISH_TOKEN}" > ~/.gem/credentials
chmod 0600 ~/.gem/credentials

gem push vgs_api_client-${LIB_VERSION}.gem