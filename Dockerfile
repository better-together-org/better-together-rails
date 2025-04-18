# This Dockerfile is only used for the production deployment using dokku.
# When pushed to dokku via git, it detects this Dockerfile and automatically chooses Docker build

# Stage 1: Build environment
FROM ruby:3.2.4 AS builder

# Define build-time variables
ARG ASSET_HOST
ARG CDN_DISTRIBUTION_ID
ARG S3_BUCKET
ARG S3_REGION

# Set environment variables for asset precompilation
ENV ASSET_HOST=${ASSET_HOST}
ENV CDN_DISTRIBUTION_ID=${CDN_DISTRIBUTION_ID}
ENV S3_BUCKET=${S3_BUCKET}
ENV S3_REGION=${S3_REGION}

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
  && curl -sL https://sentry.io/get-cli/ | bash \
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

# Precompile assets and sync to S3
RUN bundle exec rake assets:precompile

# Stage 2: Runtime environment
FROM ruby:3.2.4

# Install runtime dependencies
RUN apt-get update -qq \
  && apt-get install -y --no-install-recommends \
    libpq-dev \
    nodejs \
    libssl-dev \
    libvips42 \
    yarn \
    curl \
    nano \
  && curl -sL https://sentry.io/get-cli/ | bash \
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
