FROM ruby:3.1.1-alpine3.15

ADD . /src

# set version valid version
RUN grep -lr XXX.YYY.ZZZ ./src | xargs sed -i "s/XXX.YYY.ZZZ/0.0.1/g"

WORKDIR /src

RUN apk update && \
    gem install bundler

#RUN bundle install

#ENTRYPOINT ["bundle", "exec", "rspec", "./spec/api/test_api_spec.rb"]
ENTRYPOINT ["echo", "TODO: run ruby tests"]