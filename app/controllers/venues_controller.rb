# frozen_string_literal: true

# Manages Venues
class VenuesController < BetterTogether::FriendlyResourceController
  before_action if: -> { Rails.env.development? } do
    # Make sure that all BLock subclasses are loaded in dev to generate new block buttons
    BetterTogether::Content::Block.load_all_subclasses
  end

  def edit
    @buildings = policy_scope(BetterTogether::Infrastructure::Building)
    super
  end

  protected

  def resource_class
    Venue
  end
end
