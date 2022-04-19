FROM ruby:3.1.2-alpine3.15

RUN apk update && \
    apk add bash && \
    apk add build-base && \
    apk add libcurl && \
    gem install bundler && \
    gem install rspec-support

WORKDIR /vgs-api-client/

ENTRYPOINT ["bash", "./scripts/test/run.sh"]