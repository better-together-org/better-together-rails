# Stage 1: Build environment
FROM ruby:3.2.2 AS builder

# Install dependencies
RUN apt-get update -qq \
  && apt-get install -y --no-install-recommends \
    build-essential \
    postgresql-client \
    libpq-dev \
    nodejs \
    libssl-dev \
    apt-transport-https \
    ca-certificates \
    libvips42 \
    curl \
  && curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - \
  && echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list \
  && apt-get update -qq \
  && apt-get install -y --no-install-recommends yarn \
  && rm -rf /var/lib/apt/lists/*

# Set working directory
WORKDIR /bt

# Copy Gemfile and Gemfile.lock
COPY Gemfile Gemfile.lock ./

# Install bundler and gems
RUN gem uninstall bundler \
  && gem install bundler:2.4.13 \
  && bundle install --jobs 4 --retry 3

# Copy the rest of the application code
COPY . .

# Precompile assets
RUN bundle exec rake assets:precompile

# Stage 2: Runtime environment
FROM ruby:3.2.2

# Install runtime dependencies
RUN apt-get update -qq \
  && apt-get install -y --no-install-recommends \
    libpq-dev \
    nodejs \
    libssl-dev \
    libvips42 \
    yarn \
  && rm -rf /var/lib/apt/lists/*

# Set working directory
WORKDIR /bt

# Copy the application code from the build stage
COPY --from=builder /bt /bt

# Create and set permissions for tmp/pids directory
RUN mkdir -p tmp/pids
RUN chmod -R 755 tmp

# Set environment variables
ENV RAILS_ENV=production
ENV RACK_ENV=production

# Run the application
CMD ["bundle", "exec", "puma", "-C", "config/puma.rb"]
