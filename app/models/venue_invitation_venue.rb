# frozen_string_literal: true

# Custom join record between VenueInvitation and Venue
class VenueInvitationVenue < ApplicationRecord
  belongs_to :role, class_name: 'BetterTogether::Role'
  belongs_to :venue
  belongs_to :venue_invitation

  def self.permitted_attributes(id: false, destroy: false)
    super + %i[role_id venue_id venue_invitation_id]
  end
end
