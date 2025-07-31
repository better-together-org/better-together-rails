# frozen_string_literal: true

FactoryBot.define do
  factory :venue_invitation_venue do
    id { Faker::Internet.uuid }

    association :venue
    association :venue_invitation
    association :role, factory: :better_together_role
  end
end
