class Journey < ApplicationRecord
  belongs_to :person, class_name: 'BetterTogether::Person'
  has_many :journey_items, -> { positioned }
end
