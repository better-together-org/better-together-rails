web: bundle exec puma -p $PORT
worker: bundle exec sidekiq -C config/sidekiq.yml
release: bundle exec rails db:migrate
