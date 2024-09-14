
module NewToNlNavigationItem
  extend ::ActiveSupport::Concern

  included do
    new_routes = {
      partners: 'partners_path',
      resources: 'resources_path'
    }

    self::ROUTE_NAMES = self::ROUTE_NAMES.merge(new_routes).freeze
  end
end