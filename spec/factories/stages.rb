# frozen_string_literal: true

FactoryBot.define do
  factory :stage do
    id { Faker::Internet.uuid }
    sequence(:name) { 'Stage #{_1}' }
    description { Faker::Lorem.paragraphs(number: 2) }
    capacity { Faker::Number.between(from: 50, to: 1000) }
    association :venue
  end
end
