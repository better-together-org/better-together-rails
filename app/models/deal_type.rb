# frozen_string_literal: true

class DealType < ApplicationRecord
  include BetterTogether::Identifier
  include BetterTogether::Translatable

  slugged :name

  translates :name
  translates :description, backend: :action_text
end
