FROM ruby:3.1.2-alpine3.15

RUN apk update && \
    apk add bash && \
    gem install rubocop

WORKDIR /vgs-api-client/

ENTRYPOINT ["bash", "./scripts/lint/run.sh"]
