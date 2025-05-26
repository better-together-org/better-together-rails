# frozen_string_literal: true

# Controls RBAC for VenueCommunities
class VenueCommunityPolicy < BetterTogether::CommunityPolicy
  # def index?
  #   permitted_to?('manage_platform')
  # end

  # def show?
  #   permitted_to?('manage_platform')
  # end

  # def create?
  #   permitted_to?('manage_platform')
  # end

  # def update?
  #   create?
  # end

  # def destroy?
  #   create?
  # end

  class Scope < BetterTogether::CommunityPolicy::Scope
  end
end
