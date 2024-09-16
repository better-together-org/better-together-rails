
module NewToNlTopic
  extend ::ActiveSupport::Concern

  included do
    has_one :topic_categorization, ->{ where(category_type: 'Topic') }, class_name: 'BetterTogether::Categorization', as: :categorizable, dependent: :destroy
    has_one :topic, through: :topic_categorization, source: :category, source_type: 'Topic'
  end

  class_methods do
    def extra_permitted_attributes
      super + %i[
        topic_id
      ]
    end

    def with_topic(topic_id)
      # Define Arel tables
      page = self.arel_table
      categorization = BetterTogether::Categorization.arel_table.alias('topic_categorizations')

      # Define the join condition
      join_condition = categorization[:categorizable_id].eq(page[:id])
                        .and(categorization[:categorizable_type].eq(self.name))
                        .and(categorization[:category_type].eq('Topic'))

      # Perform the join using Arel
      joins(
        page.join(categorization)
            .on(join_condition)
            .join_sources
      )
      .where(categorization[:category_id].eq(topic_id))
    end
  end

  def topic_id
    self.topic&.id
  end

  def topic_id= arg
    self.topic = Topic.find arg
  rescue ActiveRecord::RecordNotFound
    self.topic = nil
  end
end