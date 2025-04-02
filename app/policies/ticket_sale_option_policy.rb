# frozen_string_literal: true

# Controls RBAC for TicketSaleOptions
class TicketSaleOptionPolicy < ApplicationPolicy
  def index?
    permitted_to?('manage_platform')
  end

  def show?
    permitted_to?('manage_platform')
  end

  def create?
    permitted_to?('manage_platform')
  end

  def update?
    create?
  end

  def destroy?
    create?
  end

  class Scope < ApplicationPolicy::Scope
  end
end
