# frozen_string_literal: true

# config/initializers/active_storage.rb
Rails.application.config.after_initialize do
  ActiveStorage::Engine.config.active_storage.content_types_to_serve_as_binary.delete 'image/svg+xml'
  ActiveStorage::Engine.config.active_storage.resolve_model_to_route = :rails_storage_proxy
end
