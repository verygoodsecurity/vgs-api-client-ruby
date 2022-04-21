FROM ruby:3.1.2-alpine3.15

RUN apk update && \
    apk add bash && \
    apk add build-base && \
    apk add libcurl && \
    gem install bundler && \
    gem install rspec-support

RUN mkdir -p /vgs-api-client/ && \
    mkdir -p /vgs-api-client/tmp

ADD ./scripts/test-e2e /vgs-api-client/scripts
ADD ./spec /vgs-api-client/spec

# Temporarily copying gem files to tmp/ dir
ADD ./vgs_api_client.gemspec /vgs-api-client/tmp/vgs_api_client.gemspec
ADD ./Gemfile /vgs-api-client/tmp/Gemfile

WORKDIR /vgs-api-client/

ENTRYPOINT ["bash", "./scripts/run.sh"]