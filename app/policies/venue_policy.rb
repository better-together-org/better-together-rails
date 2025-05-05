# frozen_string_literal: true

# Controls RBAC for Venues
class VenuePolicy < ApplicationPolicy
  def index?
    true
  end

  def show?
    record.privacy_public? or permitted_to?('manage_platform')
  end

  def create?
    permitted_to?('manage_platform')
  end

  def update?
    (record.creator_id.present? and record.creator_id == agent.id) or permitted_to?('manage_platform')
  end

  def destroy?
    permitted_to?('manage_platform')
  end

  # Sorts the Venues by their name asc and only show public records unless platform manager
  class Scope < ApplicationPolicy::Scope
    def resolve
      result = scope.i18n.order(name: :asc)

      result = result.privacy_public unless permitted_to?('manage_platform')

      result
    end
  end
end
