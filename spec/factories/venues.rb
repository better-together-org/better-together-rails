# frozen_string_literal: true

FactoryBot.define do
  factory :venue do
    id {Faker::Internet.uuid}
     name {Faker::Company.name}
    description {Faker::Lorem.paragraphs(number: 3)}

    after :create do |venue|
      create_list :stage, 2, venue: venue
    end
  end
end
