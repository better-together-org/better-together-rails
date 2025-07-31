# frozen_string_literal: true

FactoryBot.define do
  factory :venue do
    id { Faker::Internet.uuid }
    name { Faker::Company.name }
    slug { Faker::Internet.slug(words: name) }
    description { Faker::Lorem.paragraphs(number: 3) }
    privacy { 'private' }

    trait :public do
      privacy { 'public' }
    end
  end
end
