# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Stage, type: :model do
  subject(:stage) {build(:stage)}
  let(:existing_stage) {create(:stage)}

  # Test the factory and its validations
  describe 'Factory' do
    it 'is valid' do
      expect(stage).to be_valid
    end
  end
end
