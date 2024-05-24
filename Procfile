web: mkdir -p tmp/pids && bundle exec puma -C config/puma.rb
worker: bundle exec sidekiq -C config/sidekiq.yml
release: bundle install && bundle exec rails db:migrate
