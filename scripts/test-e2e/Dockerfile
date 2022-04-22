FROM ruby:3.1.2-alpine3.15

RUN apk update && \
    apk add bash && \
    apk add build-base && \
    apk add libcurl && \
    gem install rspec

ADD ./scripts/test-e2e /vgs-api-client/scripts
ADD ./spec /vgs-api-client/spec

WORKDIR /vgs-api-client/

ENTRYPOINT ["bash", "./scripts/run.sh"]