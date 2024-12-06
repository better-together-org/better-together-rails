# frozen_string_literal: true

# config/importmap.rb

# Pin all controllers from the host's app/javascript/controllers directory
pin_all_from File.expand_path('../app/javascript/controllers', __dir__), under: 'controllers'

# Pin the gem's application.js
# pin 'better_together/application', to: 'better_together/application.js'

# Pin all Stimulus controllers from the gem's app/javascript/better_together/controllers directory
# pin_all_from 'better_together/controllers', under: 'controllers/better_together'

# Application entry point
pin 'application', preload: true
