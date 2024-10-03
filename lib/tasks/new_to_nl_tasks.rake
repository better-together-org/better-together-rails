# frozen_string_literal: true

namespace :new_to_nl do
  desc 'seed Journey Stages'
  task seed_journey_stages: :environment do
    Mobility.with_locale(:en) do
      stages = %w[ pre-arrival arrival settlement ]

      stages.each do |stage|
        JourneyStage.find_or_create_by(identifier: stage) do |js|
          js.name = stage.titleize
          js.slug = stage.parameterize
        end
      end
    end
  end

  desc 'seed Topics'
  task seed_topics: :environment do
    Mobility.with_locale(:en) do
      topics_data.each do |identifier, attributes|
        Topic.find_or_create_by(identifier: identifier) do |topic|
          topic.name = identifier.to_s.titleize
          topic.slug = identifier.to_s.parameterize
          attributes.each do |key, value|
            topic.public_send "#{key}=", value
          end
        end
      end
    end
  end

  desc 'seed JourneyStageTopics'
  task seed_journey_stage_topics: :environment do
    Mobility.with_locale(:en) do
      created_journey_stage_topics = []
      journey_stages = JourneyStage.where(identifier: journey_stage_topics_data.keys)

      journey_stage_topics_data.each do |journey_stage_identifier, topic_identifiers|
        journey_stage = journey_stages.to_a.find { |js| js.identifier == journey_stage_identifier.to_s }
        byebug unless journey_stage
        next unless journey_stage

        journey_stage_topics = Topic.where(identifier: topic_identifiers)

        topic_identifiers.each_with_index do |topic_identifier, index|
          topic = journey_stage_topics.to_a.find { |t| t.identifier == topic_identifier.to_s }

          next unless topic

          created_journey_stage_topics << JourneyStageTopic.find_or_create_by(
            journey_stage_id: journey_stage.id,
            topic_id: topic.id
          ) do |jst|
            jst.position = index
          end
        end
      end
    end
  end

  def journey_stage_topics_data
    {
      'pre-arrival': %w[
        newfoundland-and-labrador immigration housing insurance employment language
        community-and-connections family education travel
      ],
      'arrival': %w[ =
        transportation arrival housing bank-and-finance insurance health-and-wellness
        employment community-and-connections language education family
      ],
      'settlement': %w[
        transportation immigrations housing bank-and-finance insurance employment
        health-and-wellness family language laws-and-rights community-and-connections
        training education entrepreneur
      ]
    }.freeze
  end

  def topics_data
    # TODO: Add Arrival topic - Modify categories identifer unique index
    {
      'arrival': {
        icon: 'fas fa-plane-arrival'
      },
      'bank-and-finance': {
        icon: 'fas fa-credit-card'
      },
      'community-and-connections': {
        icon: 'fas fa-people-group'
      },
      'education': {
        icon: 'fas fa-graduation-cap'
      },
      'employment': {
        icon: 'fas fa-handshake'
      },
      'entrepreneurship': {
        icon: 'fas fa-lightbulb'
      },
      'family': {
        icon: 'fas fa-people-roof'
      },
      'health-and-wellness': {
        icon: 'fas fa-staff-snake'
      },
      'housing': {
        icon: 'fas fa-house'
      },
      'immigration': {
        icon: 'fas fa-passport'
      },
      'insurance': {
        icon: 'fas fa-umbrella'
      },
      'language': {
        icon: 'fas fa-language'
      },
      'laws-and-rights': {
        icon: 'fas fa-scale-balanced'
      },
      'newfoundland-and-labrador': {
        icon: 'fas fa-map-location-dot'
      },
      'training': {
        icon: 'fas fa-book'
      },
      'transportation': {
        icon: 'fas fa-bus'
      },
      'travel': {
        icon: 'fas fa-truck-plane'
      }
    }
  end
end