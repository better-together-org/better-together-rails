# frozen_string_literal: true

class TopicsController < BetterTogether::CategoriesController
  protected

  def resource_class
    Topic
  end

  def resource_collection
    super.positioned
  end
end
