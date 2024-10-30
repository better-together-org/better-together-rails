# frozen_string_literal: true

class Resource::Link < Resource
  validates :url, presence: true

  def self.model_name
    ActiveModel::Name.new(self)
  end

  def self.extra_permitted_attributes
    super + %i[
      url
    ]
  end
end
