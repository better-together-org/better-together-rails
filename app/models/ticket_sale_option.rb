# frozen_string_literal: true

class TicketSaleOption < ApplicationRecord
  include BetterTogether::Identifier
  include BetterTogether::Translatable

  slugged :name

  translates :name
  translates :description, backend: :action_text
end
