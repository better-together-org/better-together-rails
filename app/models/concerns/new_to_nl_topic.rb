# frozen_string_literal: true

module NewToNlTopic
  extend ::ActiveSupport::Concern

  included do
    # Initialize an empty array for extra permitted attributes
    class_attribute :_extra_topic_permitted_attributes, default: []
  end

  class_methods do
    def has_many_topics
      has_many :topic_categorizations, lambda {
        where(category_type: 'Topic')
      }, class_name: 'BetterTogether::Categorization', as: :categorizable, dependent: :destroy
      has_many :topics, through: :topic_categorizations, source: :category, source_type: 'Topic'

      # Add the permitted attributes for this method dynamically
      self._extra_topic_permitted_attributes += [{ topic_ids: [] }]

      define_method :topic_ids do
        topics.pluck(:id)
      end

      define_method :topic_ids= do |arg|
        self.topics = Topic.where(id: arg)
      end
    end

    def has_one_topic
      has_one :topic_categorization, lambda {
        where(category_type: 'Topic')
      }, class_name: 'BetterTogether::Categorization', as: :categorizable, dependent: :destroy
      has_one :topic, through: :topic_categorization, source: :category, source_type: 'Topic'

      # Add the permitted attributes for this method dynamically
      self._extra_topic_permitted_attributes += %i[topic_id]

      define_method :topic_id do
        topic&.id
      end

      define_method :topic_id= do |arg|
        self.topic = Topic.find_by(id: arg)
      end
    end

    def extra_permitted_attributes
      super + _extra_topic_permitted_attributes
    end

    def with_topics(topic_ids)
      topic_ids = [topic_ids] if topic_ids.is_a?(String)

      # Define Arel tables
      target = arel_table
      categorization = BetterTogether::Categorization.arel_table.alias('topic_categorizations')

      # Define the join condition
      join_condition = categorization[:categorizable_id].eq(target[:id])
                                                        .and(categorization[:categorizable_type].eq(base_class.name))
                                                        .and(categorization[:category_type].eq('Topic'))

      # Perform the join using Arel
      joins(
        target.join(categorization)
            .on(join_condition)
            .join_sources
      ).where(categorization[:category_id].in(topic_ids))
    end
  end
end
