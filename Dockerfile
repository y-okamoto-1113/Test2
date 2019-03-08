FROM ruby:2.5.0-alpine

ENV BUILD_PACKAGES="curl-dev ruby-dev build-base bash" \
    DEV_PACKAGES="zlib-dev libxml2-dev libxslt-dev tzdata yaml-dev sqlite-dev postgresql-dev mysql-dev" \
    RUBY_PACKAGES="ruby-json yaml nodejs" \
    LANG=ja_JP.UTF-8 \
    APP_ROOT=/usr/src/app

RUN apk update && \
    apk upgrade && \
    apk add less && \
    apk add --update\
    $BUILD_PACKAGES \
    $DEV_PACKAGES \
    $RUBY_PACKAGES && \
    cp /usr/share/zoneinfo/Asia/Tokyo /etc/localtime && \
    rm -rf /var/cache/apk/* && \
    mkdir -p $APP_ROOT

RUN gem install bundler -v 2.0.1

WORKDIR /tmp
ADD Gemfile Gemfile
# ADD Gemfile.lock Gemfile.lock

# RUN bundle config build.nokogiri --use-system-libraries \
# RUN bundle install --jobs 5 && \
#     bundle clean
RUN bundle config build.nokogiri --use-system-libraries \
    && bundle check || bundle install --jobs 5 --retry 5 \
    && bundle clean

WORKDIR $APP_ROOT
COPY . $APP_ROOT

EXPOSE 3000
# 