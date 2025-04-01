# frozen_string_literal: true

class DealType < ApplicationRecord
  include BetterTogether::Identifier
  include BetterTogether::Translatable

  translates :name
  translates :description, backend: :action_text
end
