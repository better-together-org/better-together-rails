
module NewToNlJourneyStage
  extend ::ActiveSupport::Concern

  included do
    has_one :journey_stage_categorization, ->{ where(category_type: 'JourneyStage') }, class_name: 'BetterTogether::Categorization', as: :categorizable, dependent: :destroy
    has_one :journey_stage, through: :journey_stage_categorization, source: :category, source_type: 'JourneyStage'
  end

  class_methods do
    def extra_permitted_attributes
      super + %i[
        journey_stage_id
      ]
    end

    def with_journey_stage(journey_stage_id)
      # Define Arel tables
      page = self.arel_table
      categorization = BetterTogether::Categorization.arel_table.alias('journey_stage_categorizations')

      # Define the join condition
      join_condition = categorization[:categorizable_id].eq(page[:id])
                        .and(categorization[:categorizable_type].eq(self.name))
                        .and(categorization[:category_type].eq('JourneyStage'))

      # Perform the join using Arel
      joins(
        page.join(categorization)
            .on(join_condition)
            .join_sources
      )
      .where(categorization[:category_id].eq(journey_stage_id))
    end
  end

  def journey_stage_id
    self.journey_stage&.id
  end

  def journey_stage_id= arg
    self.journey_stage = JourneyStage.find arg
  rescue ActiveRecord::RecordNotFound
    self.journey_stage = nil
  end
end