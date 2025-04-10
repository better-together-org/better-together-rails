# frozen_string_literal: true

module NlVenues
  # Extends BetterTogether::Geography::Map
  module Map
    extend ActiveSupport::Concern

    included do
      require_dependency 'venue_map'
      require_dependency 'venue_collection_map'
    end
  end
end
