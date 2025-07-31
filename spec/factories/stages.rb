# frozen_string_literal: true

FactoryBot.define do
  factory :stage do
    id { Faker::Internet.uuid }
    sequence(:name) { "Stage #{it}" }
    description { Faker::Lorem.paragraphs(number: 2) }
    capacity { Faker::Number.between(from: 50, to: 1000) }
    association :venue

    trait :accessible do
      accessible { true }
    end

    trait :lighting_tech do
      lighting_tech { true }
    end

    trait :sound_tech do
      sound_tech { true }
    end

    trait :with_all_uploads do
      tech_specs { create(:better_together_upload) }
      stage_plot { create(:better_together_upload) }
      seating_chart { create(:better_together_upload) }
    end
  end
end
