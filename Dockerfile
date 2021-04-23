FROM ruby:2.6.3
RUN apt-get update -qq
WORKDIR /myapp
COPY Gemfile /myapp/Gemfile
COPY Gemfile.lock /myapp/Gemfile.lock
RUN gem update bundler
RUN bundle install
COPY . /myapp
