# frozen_string_literal: true

FactoryBot.define do
  factory :venue_invitation do
    id { Faker::Internet.uuid }
    lock_version { 0 }
    invitee_email { Faker::Internet.email }
    status { 'pending' }
    valid_from { Time.zone.now }
    valid_until { valid_from + 7.days }

    association :invitable, factory: :better_together_platform
    association :inviter, factory: :person
    association :platform_role, factory: :better_together_role
    association :community_role, factory: :better_together_role

    after :create do |invitation|
      venue = create(:venue)
      invitation.venue_invitation_venue ||= create(
        :venue_invitation_venue,
        venue_invitation: invitation,
        venue: venue,
        role: invitation.community_role
      )
    end
  end
end
