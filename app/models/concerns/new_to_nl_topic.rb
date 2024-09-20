
module NewToNlTopic
  extend ::ActiveSupport::Concern

  included do
    
  end

  class_methods do

    def has_many_topics
      has_many :topic_categorizations, ->{ where(category_type: 'Topic') }, class_name: 'BetterTogether::Categorization', as: :categorizable, dependent: :destroy
      has_many :topics, through: :topic_categorizations, source: :category, source_type: 'Topic'

      def self.extra_permitted_attributes
        super + [
          topic_ids: []
        ]
      end

      define_method :topic_ids do
        self.topics.pluck(:id)
      end
    
      define_method :topic_ids= do |arg|
        self.topics = Topic.where(id: arg)
      end
    end

    def has_one_topic
      has_one :topic_categorization, ->{ where(category_type: 'Topic') }, class_name: 'BetterTogether::Categorization', as: :categorizable, dependent: :destroy
      has_one :topic, through: :topic_categorization, source: :category, source_type: 'Topic'

      def self.extra_permitted_attributes
        super + %i[
          topic_id
        ]
      end

      define_method :topic_id do
        self.topic&.id
      end
    
      define_method :topic_ids= do |arg|
        self.topic = Topic.find_by(id: arg)
      end
    end

    def with_topics(topic_ids)
      topic_ids = [ topic_ids ] if topic_ids.is_a?(String)
      # Define Arel tables
      target = self.arel_table
      categorization = BetterTogether::Categorization.arel_table.alias('topic_categorizations')

      # Define the join condition
      join_condition = categorization[:categorizable_id].eq(target[:id])
                        .and(categorization[:categorizable_type].eq(self.name))
                        .and(categorization[:category_type].eq('Topic'))

      # Perform the join using Arel
      joins(
        target.join(categorization)
            .on(join_condition)
            .join_sources
      )
      .where(categorization[:category_id].in(topic_ids))
    end
  end
end