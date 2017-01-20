# Use minimalistic ruby container
FROM ruby:2.4.0-slim

# Optionally set a maintainer name to let people know who made this image.
MAINTAINER Team Charlie <csd@abdn.ac.uk>

# Set the university proxy inside the container
RUN echo 'Acquire::http::Proxy "http://proxy.abdn.ac.uk:8080";' > /etc/apt/apt.conf


# Install dependencies
# - build-essentials: To ensure certain gems can be compiled
# - nodejs: Compile assets
# - libpq-dev: Communicate with postgresql
# apt-get -qq: No output except for errors
# apt-get -y: Automatic yes to prompts
RUN apt-get update -qq && apt-get -y install build-essential libpq-dev nodejs

# Set environment variables to store the application path
ENV INSTALL_PATH /lacr-demo
ENV APP_PATH lacr-demo

# Create the project directory
RUN mkdir -p $INSTALL_PATH


# Set the current working directory to the application directory
WORKDIR $INSTALL_PATH

# Copy the project directory inside the container
COPY $APP_PATH .

# Install required gems
RUN bundle install

# Expose a volume so that nginx will be able to read in assets in production.
VOLUME ["$INSTALL_PATH/public"]
