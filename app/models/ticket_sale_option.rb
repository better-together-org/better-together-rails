# frozen_string_literal: true

class TicketSaleOption < ApplicationRecord
  include BetterTogether::Identifier
  include BetterTogether::Translatable

  translates :name
  translates :description, backend: :action_text
end
