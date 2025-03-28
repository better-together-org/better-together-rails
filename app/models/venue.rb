# frozen_string_literal: true

# A place where entertainment performances are held
class Venue < ApplicationRecord
  include BetterTogether::Contactable
  include BetterTogether::Creatable
  include BetterTogether::Identifier
  include BetterTogether::PrimaryCommunity
  include BetterTogether::Privacy
  include BetterTogether::Searchable

  belongs_to :building, optional: true

  has_many :floors, through: :building
  has_many :rooms, through: :floors

  translates :name
  translates :description, backend: :action_text

  settings index: { number_of_shards: 1 } do
    mappings dynamic: 'false' do
      indexes :name, as: 'name'
      indexes :description, as: 'description'
      indexes :rich_text_content, type: 'nested' do
        indexes :body, type: 'text'
      end
      indexes :rich_text_translations, type: 'nested' do
        indexes :body, type: 'text'
      end
    end
  end

  def to_s
    name
  end
end
