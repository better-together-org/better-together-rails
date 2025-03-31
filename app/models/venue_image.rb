# frozen_string_literal: true

require_dependency 'better_together/content/block'

# Join model between Venue and BetterTogether::Content::Image
class VenueImage < ApplicationRecord
  include BetterTogether::Positioned
  include BetterTogether::PrimaryFlag

  primary_flag_scope(:venue_id)
  belongs_to :venue
  belongs_to :image, class_name: 'BetterTogether::Content::Image'

  accepts_nested_attributes_for :image, reject_if: :all_blank

  def self.permitted_attributes(id: false, destroy: false)
    [
      :venue_id,
      {
        image_attributes: ::BetterTogether::Content::Image.permitted_attributes(id: true)
      }
    ] + super
  end

  def image
    super || build_image
  end
end
