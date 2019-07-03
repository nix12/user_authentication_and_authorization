FROM ruby:2.6.3

RUN mkdir /user_authentication_and_authorization

WORKDIR /user_authentication_and_authorization

COPY ./ /user_authentication_and_authorization

RUN apt-get update -qq && apt-get install -y build-essential

RUN gem install bundler && bundle install

COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]

CMD ["rails", "server", "-p", "3001", "-b", "0.0.0.0"]
