
module NewToNlContentTemplate
  extend ::ActiveSupport::Concern

  included do
    new_templates = [
      'better_together/content/blocks/template/funders',
      'better_together/content/blocks/template/journey_stages',
    ]

    self::AVAILABLE_TEMPLATES = (self::AVAILABLE_TEMPLATES + new_templates).freeze
  end
end