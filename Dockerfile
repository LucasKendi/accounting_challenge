FROM ruby:2.6.3

ENV NODE_VERSION 12
RUN apt-get update && apt-get install -y build-essential nodejs

RUN mkdir /accounting_challenge
WORKDIR /accounting_challenge

COPY Gemfile Gemfile.lock ./
RUN gem install bundler && bundle install --jobs 20 --retry 5

COPY . .

COPY docker-entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/docker-entrypoint.sh
ENTRYPOINT ["docker-entrypoint.sh"]

EXPOSE 3000

# Start the main process.
CMD ["rails", "server", "-b", "0.0.0.0"]