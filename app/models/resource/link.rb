# frozen_string_literal: true

module Resource
  class Link < Resource
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
end
