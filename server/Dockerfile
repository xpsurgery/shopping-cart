FROM ruby:2.4.0

RUN apt-get update -yqq && \
    apt-get -yqq install -y build-essential && \
    rm -rf /var/lib/apt/lists/*

WORKDIR /tmp
ADD Gemfile Gemfile
ADD Gemfile.lock Gemfile.lock
RUN bundle install

ADD . /opt/app
WORKDIR /opt/app

EXPOSE 17171
CMD ["bundle", "exec", "rackup", "--host", "0.0.0.0", "-p", "17171"]

