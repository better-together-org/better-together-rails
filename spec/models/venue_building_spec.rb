# frozen_string_literal: true

require 'rails_helper'

RSpec.describe VenueBuilding, type: :model do
  subject(:venue_building) {build(:venue_building)}
  let(:existing_venue_building) {create(:venue_building)}

  # Test the factory and its validations
  describe 'Factory' do
    it 'is valid' do
      expect(venue_building).to be_valid
    end
  end
end
