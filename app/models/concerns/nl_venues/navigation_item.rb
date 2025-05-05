# frozen_string_literal: true

module NlVenues
  module NavigationItem # rubocop:todo Style/Documentation
    extend ::ActiveSupport::Concern

    included do
      self.route_names = self.route_names.merge({
                          deal_types: 'deal_types_path',
                          ticket_sale_options: 'ticket_sale_options_path',
                          venues: 'venues_path'
                        })
    end
  end
end
