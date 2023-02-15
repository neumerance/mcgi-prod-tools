FROM ruby:2.7.2-alpine

RUN apk add --update --virtual \
  runtime-deps \
  postgresql-client \
  build-base \
  libxml2-dev \
  libxslt-dev \
  libffi-dev \
  readline \
  postgresql-dev \
  libc-dev \
  linux-headers \
  readline-dev \
  file \
  imagemagick \
  git \
  tzdata \
  && rm -rf /var/cache/apk/*

WORKDIR /app
ADD Gemfile /app/Gemfile
ADD Gemfile.lock /app/Gemfile.lock


ENV BUNDLE_PATH /gems
RUN bundle install

COPY . ./

EXPOSE $PORT
COPY entrypoint.sh ./entrypoint.sh
CMD ./entrypoint.sh
