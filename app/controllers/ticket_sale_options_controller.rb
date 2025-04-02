# frozen_string_literal: true

# Manages Ticket Sale Options
class TicketSaleOptionsController < BetterTogether::FriendlyResourceController
  protected

  def resource_class
    TicketSaleOption
  end
end
