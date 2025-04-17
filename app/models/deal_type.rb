# frozen_string_literal: true

# Represents a type of deals offered by Venues.
class DealType < ApplicationRecord
  include BetterTogether::Identifier
  include BetterTogether::Translatable

  slugged :name

  translates :name
  translates :description, backend: :action_text
end
