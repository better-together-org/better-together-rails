
module Journeyable
  extend ::ActiveSupport::Concern

  included do
    has_many :journey_items, as: :journeyable, class_name: 'JourneyItem'
    has_many :journeys, through: :journey_items, class_name: 'Journey'

    def journeyable?
      case self.class.name
      when 'BetterTogether::Content::Hero',
           'BetterTogether::Content::Css', 'BetterTogether::Content::Html',
           'JourneyMap'
        false
      else
        true
      end
    end
  end
end