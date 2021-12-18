FROM ruby:3.0-buster

RUN apt-get update -qq && apt-get install -y nodejs postgresql-client

RUN mkdir -p /api-app

WORKDIR /api-app

COPY Gemfile ./api-app/Gemfile

COPY Gemfile.lock ./api-app/Gemfile.lock

COPY . .

RUN gem install bundler && bundle install

EXPOSE 4000
