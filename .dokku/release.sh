#!/bin/bash

# Exit immediately if a command exits with a non-zero status.
set -e

if [[ -n "${SENTRY_DSN:-}" ]]; then
    # Set the release version
    RELEASE_VERSION=$(git rev-parse --short HEAD)

    # Export the release version as an environment variable
    export SENTRY_RELEASE=$RELEASE_VERSION

    if command -v sentry-cli &> /dev/null
    then
        # Notify Sentry of the new release
        sentry-cli releases new "$SENTRY_RELEASE"
        sentry-cli releases finalize "$SENTRY_RELEASE"

        echo "Sentry release $SENTRY_RELEASE has been set."
    else
        echo "SENTRY_DSN is set but sentry-cli is unavailable; skipping Sentry release notification."
    fi
else
    echo "SENTRY_DSN is not set; skipping Sentry release notification."
fi

# Run any pending migrations (if needed)
bundle exec rails db:migrate

echo "Release step completed."
