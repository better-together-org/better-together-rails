
class JourneyMap < BetterTogether::Content::Template
  include NewToNlJourneyStage

  has_one_journey_stage(required: true)

  AVAILABLE_TEMPLATES = %w[
    better_together/content/blocks/template/journey_map
  ]

  # AVAILABLE_STAGES = %w[
  #   pre-arrival arrival settling
  # ].freeze

  has_many :page_blocks, class_name: 'BetterTogether::Content::PageBlock', foreign_key: :block_id, dependent: :destroy
  has_many :pages, through: :page_blocks

  # validates :stage, inclusion: { in: ->(instance) { instance.class::AVAILABLE_STAGES }}

  def self.extra_permitted_attributes
    %i[ journey_stage_id ]
  end

  def initialize(args = nil)
    super(args)

    self.template_path = 'better_together/content/blocks/template/journey_map'
  end

  def stage_colour
    case journey_stage.identifier
    when 'pre-arrival'
      'green'
    when 'arrival'
      'beige'
    when 'settlement'
      'blue'
    else
      ''
    end
  end

  def stage_identifier
    journey_stage&.identifier
  end
end