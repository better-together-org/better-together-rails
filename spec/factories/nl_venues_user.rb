# frozen_string_literal: true

FactoryBot.define do
  factory(:nl_venues_user,
          parent: :better_together_user) do
    after(:build) do |user|
      user.person = create(:better_together_person)
    end

    trait :platform_manager do
      after(:create) do |user|
        host_platform = BetterTogether::Platform.find_by(host: true)
        platform_manager_role = BetterTogether::Role.find_by(identifier: 'platform_manager')
        host_platform.person_platform_memberships.create!(
          member: user.person,
          role: platform_manager_role
        )
      end
    end
  end
end
