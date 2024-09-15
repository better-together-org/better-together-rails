
module NewToNlContentBlock
  extend ::ActiveSupport::Concern

  included do
    new_subclasses = [
      JourneyMap
    ]

    self::SUBCLASSES = (self::SUBCLASSES + new_subclasses).freeze
  end
end