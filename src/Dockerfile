FROM ruby:2.4.0-slim
MAINTAINER Team Charlie <csd@abdn.ac.uk>

ENV http_proxy="http://proxy.abdn.ac.uk:8080"
ENV http_proxy="http://proxy.abdn.ac.uk:8080"

RUN echo 'Acquire::http::Proxy "http://proxy.abdn.ac.uk:8080/";' > /etc/apt/apt.conf

RUN apt-get update -qq && apt-get -y install build-essential libpq-dev nodejs curl imagemagick

RUN mkdir -p /lacr-demo
WORKDIR /lacr-demo

ADD lacr-demo/Gemfile /lacr-demo/Gemfile
ADD lacr-demo/Gemfile.lock /lacr-demo/Gemfile.lock

RUN bundle install

ADD lacr-demo /lacr-demo

RUN echo '' > /etc/apt/apt.conf

ENV http_proxy=''
ENV http_proxy=''
