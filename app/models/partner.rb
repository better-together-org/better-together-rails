# frozen_string_literal: true

class Partner < BetterTogether::Community
  include NewToNlJourneyStage
  include NewToNlTopic

  has_many_journey_stages
  has_many_topics
end
