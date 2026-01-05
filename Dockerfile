FROM ruby:3.4.8-alpine3.21

# Adding argument support for ping.json
ARG APPVERSION=unknown
ARG APP_BUILD_DATE=unknown
ARG APP_GIT_COMMIT=unknown
ARG APP_BUILD_TAG=unknown

# Setting up ping.json variables
ENV APPVERSION=${APPVERSION}
ENV APP_BUILD_DATE=${APP_BUILD_DATE}
ENV APP_GIT_COMMIT=${APP_GIT_COMMIT}
ENV APP_BUILD_TAG=${APP_BUILD_TAG}


RUN apk update && apk add --no-cache libc6-compat && \
    apk add --no-cache --virtual .build-tools git build-base curl-dev yarn tzdata shared-mime-info \
    yaml-dev

ENV UNICORN_PORT=3000
EXPOSE $UNICORN_PORT

RUN mkdir -p /home/app
WORKDIR /home/app

COPY Gemfile /home/app
COPY Gemfile.lock /home/app
RUN gem install bundler -v 4.0.3

RUN bundle config set --local without 'test development'
RUN bundle config set force_ruby_platform true
RUN bundle install

# running app as a servive
ENV PHUSION=true

COPY . /home/app
RUN yarn install --check-files

CMD ["sh", "-c", "bundle exec rake assets:precompile RAILS_ENV=production SECRET_TOKEN=blah && \
     sh ./run.sh"]
