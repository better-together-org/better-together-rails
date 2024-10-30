# frozen_string_literal: true

module Resource
  class DocumentPolicy < ResourcePolicy
    def download?
      true
    end

    class Scope < ResourcePolicy::Scope
    end
  end
end
