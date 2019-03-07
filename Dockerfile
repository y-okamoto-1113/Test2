# FROM ruby:2.5.0-alpine

# ENV BUILD_PACKAGES="curl-dev ruby-dev build-base bash" \
#     DEV_PACKAGES="zlib-dev libxml2-dev libxslt-dev tzdata yaml-dev sqlite-dev postgresql-dev mysql-dev" \
#     RUBY_PACKAGES="ruby-json yaml nodejs" \
#     LANG=ja_JP.UTF-8 \
#     APP_ROOT=/usr/src/app

# RUN apk update && \
#     apk upgrade && \
#     apk add less && \
#     apk add --update\
#     $BUILD_PACKAGES \
#     $DEV_PACKAGES \
#     $RUBY_PACKAGES && \
#     cp /usr/share/zoneinfo/Asia/Tokyo /etc/localtime && \
#     rm -rf /var/cache/apk/* && \
#     mkdir -p $APP_ROOT

# WORKDIR /tmp
# ADD Gemfile Gemfile
# ADD Gemfile.lock Gemfile.lock

# # RUN bundle config build.nokogiri --use-system-libraries \
# # RUN bundle install --jobs 5 && \
# #     bundle clean
# RUN bundle config build.nokogiri --use-system-libraries \
#     && bundle check || bundle install --jobs 5 --retry 5 \
#     && bundle clean

# WORKDIR $APP_ROOT
# COPY . $APP_ROOT

# EXPOSE 3000


FROM ruby:2.5.0
ENV LANG C.UTF-8
RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs
RUN gem install bundler
WORKDIR /tmp
ADD Gemfile Gemfile
ADD Gemfile.lock Gemfile.lock
RUN bundle install
ENV APP_HOME /Test
RUN mkdir -p $APP_HOME
WORKDIR $APP_HOME
ADD . $APP_HOME