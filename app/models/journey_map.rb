
class JourneyMap < BetterTogether::Content::Template
  AVAILABLE_TEMPLATES = %w[
    better_together/content/blocks/template/journey_map
  ]

  AVAILABLE_STAGES = %w[
    pre-arrival arrival settling
  ].freeze

  has_many :page_blocks, foreign_key: :block_id, dependent: :destroy

  store_attributes :content_data do
    stage String, default: 'pre-arrival'
  end

  validates :stage, inclusion: { in: ->(instance) { instance.class::AVAILABLE_STAGES }}

  def initialize(args = nil)
    super(args)

    self.template_path = 'better_together/content/blocks/template/journey_map'
  end

  def stage_colour
    case stage
    when 'pre-arrival'
      'green'
    when 'arrival'
      'beige'
    when 'settling'
      'blue'
    end
  end
end