# frozen_string_literal: true

# Custom platform invitation to add link to Venue
class VenueInvitation < ::BetterTogether::PlatformInvitation
  has_one :venue_invitation_venue
  has_one :venue, through: :venue_invitation_venue

  accepts_nested_attributes_for :venue_invitation_venue

  def self.model_name
    ActiveModel::Name.new(self)
  end

  def self.permitted_attributes(id: false, destroy: false)
    super + [
      venue_invitation_venue_attributes: VenueInvitationVenue.permitted_attributes(id: true, destroy: true)
    ]
  end

  def after_accept!
    return unless venue

    venue.person_community_memberships.create!(
      member_id: invitee_id,
      role_id: venue_invitation_venue.role_id
    )
  end
end
