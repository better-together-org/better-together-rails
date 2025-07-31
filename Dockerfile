# This Dockerfile is only used for the production deployment using dokku.
# When pushed to dokku via git, it detects this Dockerfile and automatically chooses Docker build

# Stage 1: Build libxml2
FROM ruby:3.4.4-slim AS libxml2-bin

RUN apt-get update -qq \
  && apt-get install -y --no-install-recommends build-essential wget tar gcc pkg-config python3-dev xz-utils \
  && wget https://download.gnome.org/sources/libxml2/2.14/libxml2-2.14.2.tar.xz -O /tmp/libxml2.tar.xz \
  && mkdir -p /tmp/libxml2 \
  && tar -xf /tmp/libxml2.tar.xz -C /tmp/libxml2 --strip-components=1

WORKDIR /tmp/libxml2

RUN ./configure --prefix=/opt/libxml2 PYTHON=/usr/bin/python3 \
  && make \
  && make install \
  && ldconfig \
  && rm -rf /tmp/libxml2 /tmp/libxml2.tar.xz

# Stage 2: Build environment
FROM ruby:3.4.4-slim AS builder

# Define build-time variables
ARG AWS_ACCESS_KEY_ID
ARG AWS_SECRET_ACCESS_KEY
ARG FOG_DIRECTORY
ARG FOG_HOST
ARG FOG_REGION
ARG ASSET_HOST
ARG CDN_DISTRIBUTION_ID

# Set environment variables for asset precompilation
ENV AWS_ACCESS_KEY_ID=${AWS_ACCESS_KEY_ID}
ENV AWS_SECRET_ACCESS_KEY=${AWS_SECRET_ACCESS_KEY}
ENV FOG_DIRECTORY=${FOG_DIRECTORY}
ENV FOG_HOST=${FOG_HOST}
ENV FOG_REGION=${FOG_REGION}
ENV ASSET_HOST=${ASSET_HOST}
ENV CDN_DISTRIBUTION_ID=${CDN_DISTRIBUTION_ID}

# Install dependencies
RUN apt-get update -qq \
  && apt-get install -y --no-install-recommends \
    build-essential \
    git \
    postgresql-client \
    libpq-dev \
    libssl-dev \
    libyaml-dev \
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
RUN bundle config set without 'development test' \
  && bundle config set deployment true \
  && bundle config set path 'vendor/bundle' \
  && bundle install --jobs 4 --retry 3

# Copy the rest of the application code
COPY . .

# Precompile assets
RUN bundle exec rake assets:precompile

# Stage 3: Runtime environment
FROM ruby:3.4.4 AS app-host

# Install runtime dependencies
RUN apt-get update -qq \
  && apt-get install -y --no-install-recommends \
    git \
    gcc \
    libpq-dev \
    libssl-dev \
    libvips42 \
    libyaml-dev \
    curl \
    nano \
  && curl -sL https://sentry.io/get-cli/ | bash \
  && rm -rf /var/lib/apt/lists/* \
  && mkdir -p tmp/pids && chmod -R 755 tmp

# Copy built libxml2 binaries
COPY --from=libxml2-bin /opt/libxml2 /opt/libxml2

# Set environment variables for libxml2
ENV LD_LIBRARY_PATH=/opt/libxml2/lib:$LD_LIBRARY_PATH
ENV PKG_CONFIG_PATH=/opt/libxml2/lib/pkgconfig:$PKG_CONFIG_PATH

# Set bundler environment variables to use vendor/bundle
ENV BUNDLE_PATH=/bt/vendor/bundle
ENV BUNDLE_APP_CONFIG=/bt/vendor/bundle
ENV BUNDLE_BIN=/bt/vendor/bundle/bin
ENV PATH=$BUNDLE_BIN:$PATH

# Set working directory
WORKDIR /bt

# Set environment variables
ENV RAILS_ENV=production
ENV RACK_ENV=production

# Set the BUNDLE_WITHOUT environment variable
ENV BUNDLE_WITHOUT=development:test


# Copy the application code from the builder stage
COPY --from=builder /bt /bt

# Clean up unnecessary files
RUN rm -rf /bt/tmp/cache /bt/log /bt/spec /bt/test

# Run the application
CMD ["bundle", "exec", "puma", "-C", "config/puma.rb"]
