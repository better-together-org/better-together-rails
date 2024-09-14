
class Resource::Link < Resource
  validates :url, presence: true

  def self.model_name
    ActiveModel::Name.new(self)
  end
end
