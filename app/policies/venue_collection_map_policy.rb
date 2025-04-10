# frozen_string_literal: true

# Controls RBAC for VenueColleMapctions
class VenueCollectionMapPolicy < VenueMapPolicy
  # This is a policy for the VenueMap model, which inherits from the MapPolicy of the BetterTogether module.
  # It defines the permissions for various actions that can be performed on the VenueMap resource.

  # Define the permissions for each action

  class Scope < VenueMapPolicy::Scope
  end
end
