
class Topic < BetterTogether::Category
  has_many :journey_stage_topics, -> { positioned }, dependent: :destroy
  has_many :journey_stages, through: :journey_stage_topics
end
