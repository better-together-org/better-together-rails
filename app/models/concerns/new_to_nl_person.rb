
module NewToNlPerson
  extend ::ActiveSupport::Concern

  included do
    has_one :journey, class_name: 'Journey', dependent: :destroy
    has_many :journey_items, through: :journey

    after_create :create_journey
  end
end