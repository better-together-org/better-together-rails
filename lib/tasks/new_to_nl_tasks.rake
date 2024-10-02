# frozen_string_literal: true

namespace :new_to_nl do
  desc 'seed Journey Stages'
  task seed_journey_stages: :environment do
    stages = %w[ pre-arrival arrival settlement ]

    stages.each do |stage|
      JourneyStage.find_or_create_by(identifier: stage) do |js|
        js.name = stage.capitalize
        js.slug = stage
      end
    end
  end

  desc 'seed Topics'
  task seed_topics: :environment do
    # TODO: Add Arrival topic - Modify categories identifer unique index
    topics = %w[
      banking
      community
      education
      employment
      entrepreneurship
      family
      health
      housing
      immigration
      insurance
      language
      legal
      training
      transportation
    ]

    topics.each do |topic|
      Topic.find_or_create_by(identifier: topic) do |topik|
        topik.name = topic.capitalize
        topik.slug = topic
      end
    end
  end
end