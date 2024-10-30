# frozen_string_literal: true

module NewToNlJourneyStage
  extend ::ActiveSupport::Concern

  included do
    # Initialize an empty array for extra permitted attributes
    class_attribute :_extra_journey_stage_permitted_attributes, default: []
  end

  class_methods do
    def has_many_journey_stages
      has_many :journey_stage_categorizations, lambda {
        where(category_type: 'JourneyStage')
      }, class_name: 'BetterTogether::Categorization', as: :categorizable, dependent: :destroy
      has_many :journey_stages, through: :journey_stage_categorizations, source: :category, source_type: 'JourneyStage'

      # Add the permitted attributes for this method dynamically
      self._extra_journey_stage_permitted_attributes += [{ journey_stage_ids: [] }]

      define_method :journey_stage_ids do
        journey_stages.pluck(:id)
      end

      define_method :journey_stage_ids= do |arg|
        self.journey_stages = JourneyStage.where(id: arg)
      end
    end

    def has_one_journey_stage(required: false)
      has_one :journey_stage_categorization, lambda {
        where(category_type: 'JourneyStage')
      }, class_name: 'BetterTogether::Categorization', as: :categorizable, dependent: :destroy
      has_one :journey_stage, through: :journey_stage_categorization, source: :category, source_type: 'JourneyStage'

      validates :journey_stage, presence: true if required

      # Add the permitted attributes for this method dynamically
      self._extra_journey_stage_permitted_attributes += %i[journey_stage_id]

      define_method :journey_stage_id do
        journey_stage&.id
      end

      define_method :journey_stage_id= do |arg|
        self.journey_stage = JourneyStage.find_by(id: arg)
      end
    end

    def extra_permitted_attributes
      super + _extra_journey_stage_permitted_attributes
    end

    def with_journey_stages(journey_stage_ids)
      journey_stage_ids = [journey_stage_ids] if journey_stage_ids.is_a?(String)

      # Define Arel tables
      target = arel_table
      categorization = BetterTogether::Categorization.arel_table.alias('journey_stage_categorizations')

      # Define the join condition
      join_condition = categorization[:categorizable_id].eq(target[:id])
                                                        .and(categorization[:categorizable_type].eq(base_class.name))
                                                        .and(categorization[:category_type].eq('JourneyStage'))

      # Perform the join using Arel
      joins(
        target.join(categorization)
            .on(join_condition)
            .join_sources
      ).where(categorization[:category_id].in(journey_stage_ids))
    end
  end
end
