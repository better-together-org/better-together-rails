# frozen_string_literal: true

class VenueInvitationPolicy < BetterTogether::PlatformInvitationPolicy
  class Scope < ::BetterTogether::PlatformInvitationPolicy::Scope # rubocop:todo Style/Documentation
    def resolve
      scope.all
    end
  end
end
