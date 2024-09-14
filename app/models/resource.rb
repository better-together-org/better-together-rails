class Resource < ApplicationRecord
  include ::BetterTogether::Identifier
  include ::BetterTogether::Privacy
  include ::BetterTogether::Translatable

  translates :name, :description, :slug, type: :string

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
