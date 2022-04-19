FROM ruby:3.1.2-alpine3.15

RUN apk update && \
    apk add bash

WORKDIR /vgs-api-client/

ENTRYPOINT ["bash", "./scripts/publish/run.sh"]
