class Resource < ApplicationRecord
  include ::BetterTogether::Categorizable
  include ::BetterTogether::Identifier
  include ::BetterTogether::Privacy
  include ::BetterTogether::Translatable
  include NewToNlJourneyStage
  include NewToNlTopic

  translates :name, type: :string
  translates :description, type: :text

  slugged :name

  # Common validations
  validates :name, presence: true
  validates :type, presence: true
  validates :locale, presence: true

  def self.load_all_subclasses
    # rubocop:todo Layout/LineLength
    [Document, Link].each(&:connection) # Add all known subclasses here
    # rubocop:enable Layout/LineLength
  end
end
