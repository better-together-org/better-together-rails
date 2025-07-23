# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Venue, type: :model do
  subject(:venue) { build(:venue) }

  let(:existing_venue) { create(:venue) }

  # Test the factory and its validations
  describe 'Factory' do
    it 'is valid' do
      expect(venue).to be_valid
    end

    it 'must have a name of at least 3 characters' do
      venue = build(:venue, name: 'NL')
      expect(venue).not_to be_valid
    end
  end

  describe 'ActiveRecord associations' do
    # Test the Active Record associations present on the model
    it { is_expected.to have_many(:venue_buildings).dependent(:destroy) }
    it { is_expected.to have_many(:buildings).through(:venue_buildings) }
    it { is_expected.to have_many(:venue_images).dependent(:destroy) }
    it { is_expected.to have_many(:images).through(:venue_images) }
    it { is_expected.to have_many(:stages).dependent(:destroy) }
    it { is_expected.to have_many(:venue_offers).dependent(:destroy) }
    it { is_expected.to have_many(:deal_types).through(:venue_offers) }
    it { is_expected.to have_many(:ticket_sale_options).through(:venue_offers) }
    it { is_expected.to have_one(:map).dependent(:destroy) }

    # Test the nested attributes for its child associations
    it { is_expected.to accept_nested_attributes_for(:venue_buildings).allow_destroy(true) }
    it { is_expected.to accept_nested_attributes_for(:venue_images).allow_destroy(true) }
    it { is_expected.to accept_nested_attributes_for(:venue_offers).allow_destroy(true) }
    it { is_expected.to accept_nested_attributes_for(:stages).allow_destroy(true) }
  end

  # Test any validations present on the ActiveModel
  describe 'ActiveModel validations' do
    it { is_expected.to validate_presence_of(:name) }
  end

  # Test that the model properly delegates attributes to its child associatioins where necessary
  describe 'delegations' do
    context 'when a venue has a primary stage' do
      before do
        create(:stage,
               capacity: 1001,
               lighting_tech: true,
               primary_flag: true,
               venue: existing_venue)
      end

      it 'delegates capacity to the primary stage' do
        expect(existing_venue.capacity).to eq(1001)
      end

      it 'delegates lighting tech to the primary stage' do
        expect(existing_venue.lighting_tech).to be(true)
      end
    end
  end

  # Test that after creating a venue it also creates a map that is of the correct model and title
  describe 'callbacks' do
    context 'when a venue has been created' do
      it 'creates a map record' do
        expect(existing_venue.map).to be_present
      end

      it 'associates the map to the correct model' do
        expect(existing_venue.map).to be_a(BetterTogether::Geography::Map)
      end

      it 'assigns the map name to the name of the venue' do
        expect(existing_venue.map.title).to eq(existing_venue.name)
      end
    end
  end

  # Test that a venue properly delegates its primary address to that of its primary building address if set
  describe '#formatted_address' do
    context 'when a primary building with an address is set' do
      before do
        address = create(:better_together_address,
                         line1: '123 Main Street',
                         city_name: 'Corner Brook',
                         state_province_name: 'NL',
                         primary_flag: true)

        building = create(:better_together_infrastructure_building,
                          address: address)

        create(:venue_building,
               venue: existing_venue,
               building: building,
               primary_flag: true)
      end

      it 'returns a formatted string of the primary building address' do
        expect(existing_venue.formatted_address).to eq('123 Main Street, Corner Brook, NL')
      end
    end

    it 'returns nil when venue does not have a primary stage' do
      expect(existing_venue.formatted_address).to be_nil
    end
  end
end
