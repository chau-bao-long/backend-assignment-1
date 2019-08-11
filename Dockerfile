FROM ruby:2.6.3-alpine3.10

RUN apt-get update -qq

RUN mkdir /opt/webapp
WORKDIR /opt/webapp

COPY Gemfile /opt/webapp/Gemfile
COPY Gemfile.lock /opt/webapp/Gemfile.lock

RUN bundle install 

EXPOSE 3000

CMD ["rails", "s"]
