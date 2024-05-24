# release.sh
#!/bin/bash
set -e

bundle install
bundle exec rails db:migrate
