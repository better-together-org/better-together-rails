# frozen_string_literal: true

FactoryBot.define do
  factory :venue_building do
    association :building, factory: :better_together_infrastructure_building
    association :venue
  end
end
