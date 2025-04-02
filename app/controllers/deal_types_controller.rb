# frozen_string_literal: true

# Manages Deal Types
class DealTypesController < BetterTogether::FriendlyResourceController
  protected

  def resource_class
    DealType
  end
end
