FROM ruby:2.5
RUN apt-get update -qq && apt-get install -y build-essential nodejs postgresql-client libssl-dev
RUN mkdir /better_together
WORKDIR /better_together
COPY Gemfile /better_together/Gemfile
COPY Gemfile.lock /better_together/Gemfile.lock

# Use a persistent volume for the gems installed by the bundler
ENV BUNDLE_GEMFILE=/better_together/Gemfile \
  BUNDLE_JOBS=2 \
  BUNDLE_PATH=/bundler \
  GEM_PATH=/bundler \
  GEM_HOME=/bundler

RUN bundle install
COPY . /better_together

# Add a script to be executed every time the container starts.
#COPY entrypoint.sh /usr/bin/
#RUN chmod +x /usr/bin/entrypoint.sh
#NTRYPOINT ["entrypoint.sh"]
#EXPOSE 3000

# Start the main process.
#CMD ["rails", "server", "-b", "0.0.0.0"]