FROM ruby:2.4.0-slim
MAINTAINER Team Charlie <csd@abdn.ac.uk>

RUN apt-get update -qq && apt-get -y install build-essential libpq-dev nodejs curl imagemagick

RUN mkdir -p /lacr-demo
WORKDIR /lacr-demo

ADD lacr-demo/Gemfile /lacr-demo/Gemfile
ADD lacr-demo/Gemfile.lock /lacr-demo/Gemfile.lock

RUN bundle install

ADD lacr-demo /lacr-demo