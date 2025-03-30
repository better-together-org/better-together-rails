# frozen_string_literal: true

# Manages Venues
class VenuesController < BetterTogether::FriendlyResourceController
  def edit
    @buildings = policy_scope(BetterTogether::Infrastructure::Building)
    super
  end

  protected

  def resource_class
    Venue
  end
end
