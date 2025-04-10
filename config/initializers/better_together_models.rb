# frozen_string_literal: true

ActiveSupport::Reloader.to_prepare do
  require_dependency 'better_together/infrastructure/building'
  require_dependency 'better_together/geography/map'

  BetterTogether::Geography::Map.include(NlVenues::Map)
  BetterTogether::Infrastructure::Building.include(NlVenues::Building)
end
