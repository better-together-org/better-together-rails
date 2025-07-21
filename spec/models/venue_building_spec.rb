# frozen_string_literal: true

require 'rails_helper'

RSpec.describe VenueBuilding, type: :model do
  subject(:venue_building) { build(:venue_building) }

  let(:existing_venue_building) { create(:venue_building) }

  # Test the factory and its validations
  describe 'Factory' do
    it 'is valid' do
      expect(venue_building).to be_valid
    end
  end

  describe 'ActiveRecord associations' do
    it { is_expected.to belong_to(:venue) }

    it { is_expected.to accept_nested_attributes_for(:building) }
  end

  describe 'callbacks' do
    # Test the #set_new_building_details callback
    describe '#set_new_building_details' do
      # when venue_building is a new record, attributes should be copied from parent venue
      context 'when creating a new venue_building' do
        let(:venue) do
          create(:venue,
                 name: 'Test Venue',
                 description: 'A new test venue',
                 privacy: 'public')
        end
        let(:venue_building) { build(:venue_building, venue: venue) }

        it 'copies parent attributes from venue for name, description, and privacy' do
          venue_building.valid?
          expect(venue_building.building.name).to eq('Test Venue')
          expect(venue_building.building.description.body).to eq(venue.description.body)
          expect(venue_building.building.privacy).to eq('public')
        end
      end

      # when venue_building already exists, its own attributes should persist on update
      context 'when updating an existing venue_building' do
        let(:venue) do
          create(:venue,
                 name: 'Test Venue',
                 description: 'A new test venue',
                 privacy: 'public')
        end
        let(:venue_building) { create(:venue_building, venue: venue) }

        it 'does not run the #set_new_building_details callback' do
          expect { venue_building.valid? }.not_to(change { venue_building.building.name })
        end
      end
    end
  end
end
