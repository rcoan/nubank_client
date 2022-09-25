FROM ruby:2.6.8

# throw errors if Gemfile has been modified since Gemfile.lock
RUN bundle config --global frozen 1

WORKDIR .

COPY . .

RUN gem build nubank-client.gemspec && gem install ./nubank-client-0.0.1.gem

RUN bundle install
