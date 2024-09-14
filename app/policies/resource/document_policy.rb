
class Resource::DocumentPolicy < ResourcePolicy

  def download?
    true
  end

  class Scope < ResourcePolicy::Scope

  end
end
