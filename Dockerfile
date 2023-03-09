FROM ruby:3.2.1
RUN apt-get update -qq && apt-get install -y
WORKDIR /myapp
COPY Gemfile /myapp/Gemfile
COPY Gemfile.lock /myapp/Gemfile.lock
RUN bundle install

COPY . .

RUN rails db:migrate
RUN rails db:migrate RAILS_ENV=test

EXPOSE 3000

CMD ["rails", "server", "-b", "0.0.0.0"]