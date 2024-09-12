class PartnersController < BetterTogether::CommunitiesController

  def index
    authorize resource_class
    @partners = policy_scope(resource_collection)
  end

  protected

  def set_model_instance
    @partner = set_resource_instance
  end

  def resource_class
    Partner
  end
end
