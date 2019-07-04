FROM ruby:2.6.3

RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs

RUN mkdir /user_authentication_and_authorization

WORKDIR /user_authentication_and_authorization

COPY Gemfile /user_authentication_and_authorization/Gemfile

COPY Gemfile.lock /user_authentication_and_authorization/Gemfile.lock

RUN gem install bundler && bundle install

COPY . /user_authentication_and_authorization

ENV RAILS_MASTER_KEY $RAILS_MASTER_KEY

COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]

EXPOSE 3001

CMD ["rails", "server", "-p", "3001", "-b", "0.0.0.0"]
