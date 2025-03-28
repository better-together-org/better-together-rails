# frozen_string_literal: true

# Manages Venues
class VenuesController < BetterTogether::FriendlyResourceController
  protected

  def resource_class
    Venue
  end
end
