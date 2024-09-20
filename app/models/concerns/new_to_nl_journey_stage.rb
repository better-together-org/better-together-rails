
module NewToNlJourneyStage
  extend ::ActiveSupport::Concern

  included do
    
  end

  class_methods do

    def has_many_journey_stages
      has_many :journey_stage_categorizations, ->{ where(category_type: 'JourneyStage') }, class_name: 'BetterTogether::Categorization', as: :categorizable, dependent: :destroy
      has_many :journey_stages, through: :journey_stage_categorizations, source: :category, source_type: 'JourneyStage'
      
      def self.extra_permitted_attributes
        super + [
          journey_stage_ids: []
        ]
      end

      define_method :journey_stage_ids do
        self.journey_stages.pluck(:id)
      end

      define_method :journey_stage_ids= do |arg|
        self.journey_stages = JourneyStage.where(id: arg)
      end
    end

    def has_one_journey_stage(required: false)
      has_one :journey_stage_categorization, ->{ where(category_type: 'JourneyStage') }, class_name: 'BetterTogether::Categorization', as: :categorizable, dependent: :destroy
      has_one :journey_stage, through: :journey_stage_categorization, source: :category, source_type: 'JourneyStage'
    
      validates :journey_stage, presence: true if required

      def self.extra_permitted_attributes
        super + %i[
          journey_stage_id
        ]
      end

      define_method :journey_stage_id do
        self.journey_stage&.id
      end

      define_method :journey_stage_id= do |arg|
        self.journey_stage = JourneyStage.find_by(id: arg)
      end
    end

    def with_journey_stages(journey_stage_ids)
      journey_stage_ids = [ journey_stage_ids ] if journey_stage_ids.is_a?(String)

      # Define Arel tables
      target = self.arel_table
      categorization = BetterTogether::Categorization.arel_table.alias('journey_stage_categorizations')

      # Define the join condition
      join_condition = categorization[:categorizable_id].eq(target[:id])
                        .and(categorization[:categorizable_type].eq(self.name))
                        .and(categorization[:category_type].eq('JourneyStage'))

      # Perform the join using Arel
      joins(
        target.join(categorization)
            .on(join_condition)
            .join_sources
      )
      .where(categorization[:category_id].in(journey_stage_ids))
    end
  end
end