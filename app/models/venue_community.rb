# frozen_string_literal: true

# Join record between a deal type and a venue offer
class VenueCommunity < ::BetterTogether::Community
  has_one :venue, foreign_key: :community_id

  alias members person_members
  alias memberships person_community_memberships

  accepts_nested_attributes_for :person_community_memberships, reject_if: :all_blank, allow_destroy: true

  def card_image
    return super unless venue

    venue.primary_image&.media
  end

  def optimized_card_image
    return super unless venue

    venue.primary_image&.media
  end

  def to_partial_path
    becomes(self.class.base_class).to_partial_path
  end
end
