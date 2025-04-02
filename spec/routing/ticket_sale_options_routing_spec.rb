require "rails_helper"

RSpec.describe TicketSaleOptionsController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(get: "/ticket_sale_options").to route_to("ticket_sale_options#index")
    end

    it "routes to #new" do
      expect(get: "/ticket_sale_options/new").to route_to("ticket_sale_options#new")
    end

    it "routes to #show" do
      expect(get: "/ticket_sale_options/1").to route_to("ticket_sale_options#show", id: "1")
    end

    it "routes to #edit" do
      expect(get: "/ticket_sale_options/1/edit").to route_to("ticket_sale_options#edit", id: "1")
    end


    it "routes to #create" do
      expect(post: "/ticket_sale_options").to route_to("ticket_sale_options#create")
    end

    it "routes to #update via PUT" do
      expect(put: "/ticket_sale_options/1").to route_to("ticket_sale_options#update", id: "1")
    end

    it "routes to #update via PATCH" do
      expect(patch: "/ticket_sale_options/1").to route_to("ticket_sale_options#update", id: "1")
    end

    it "routes to #destroy" do
      expect(delete: "/ticket_sale_options/1").to route_to("ticket_sale_options#destroy", id: "1")
    end
  end
end
