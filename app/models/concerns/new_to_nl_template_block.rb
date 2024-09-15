
module NewToNlTemplateBlock
  extend ::ActiveSupport::Concern

  included do
    new_templates = %w[
      better_together/content/blocks/template/journey_map
    ]

    self::AVAILABLE_TEMPLATES = (self::AVAILABLE_TEMPLATES + new_templates).freeze
  end
end