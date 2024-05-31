FROM ruby:3.3.2-alpine

# Adding argument support for ping.json
ARG APPVERSION=unknown
ARG APP_BUILD_DATE=unknown
ARG APP_GIT_COMMIT=unknown
ARG APP_BUILD_TAG=unknown

# Setting up ping.json variables
ENV APPVERSION ${APPVERSION}
ENV APP_BUILD_DATE ${APP_BUILD_DATE}
ENV APP_GIT_COMMIT ${APP_GIT_COMMIT}
ENV APP_BUILD_TAG ${APP_BUILD_TAG}


RUN apk update && apk add --no-cache libc6-compat && \
    apk add --no-cache --virtual .build-tools git build-base curl-dev npm tzdata shared-mime-info


ENV UNICORN_PORT 3000
EXPOSE $UNICORN_PORT

RUN mkdir -p /home/app
WORKDIR /home/app

COPY Gemfile /home/app
COPY Gemfile.lock /home/app
RUN gem install bundler -v 2.5.10

RUN bundle config set --local without 'test development'
RUN bundle config set force_ruby_platform true
RUN bundle install

# running app as a servive
ENV PHUSION true

COPY . /home/app
RUN npm install

CMD ["sh", "-c", "bundle exec rake assets:precompile RAILS_ENV=production SECRET_TOKEN=blah && \
     sh ./run.sh"]
