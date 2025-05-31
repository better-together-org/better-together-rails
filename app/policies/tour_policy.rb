# frozen_string_literal: true

# Controls RBAC for Tours
class TourPolicy < ApplicationPolicy
  def index?
    user.present?
  end

  def show?
    (record.creator_id.present? and record.creator_id == agent.id) or
      record.privacy_public? or
      permitted_to?('manage_platform')
  end

  def create?
    permitted_to?('manage_platform')
  end

  def update?
    (record.creator_id.present? and record.creator_id == agent.id) or
      permitted_to?('manage_platform')
  end

  def destroy?
    permitted_to?('manage_platform')
  end

  # Sorts the Tours by their name asc and only show public records unless platform manager
  class Scope < ApplicationPolicy::Scope
    def resolve
      result = super

      result = result.privacy_public unless permitted_to?('manage_platform')

      result
    end
  end
end
