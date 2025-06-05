# frozen_string_literal: true

# CRUD for Tours
class ToursController < BetterTogether::FriendlyResourceController
  def index
    @draft_tours = @tours.draft
    @upcoming_tours = @tours.upcoming
    @past_tours = @tours.past
  end

  protected

  def resource_class
    Tour
  end
end
