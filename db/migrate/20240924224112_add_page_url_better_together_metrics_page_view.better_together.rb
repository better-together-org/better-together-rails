# frozen_string_literal: true

# This migration comes from better_together (originally 20240924224024)
class AddPageUrlBetterTogetherMetricsPageView < ActiveRecord::Migration[7.1]
  def change
    add_column :better_together_metrics_page_views, :page_url, :string
  end
end
