# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Stage, type: :model do
  subject(:stage) { build(:stage) }

  let(:existing_stage) { create(:stage) }

  # Test the factory and its validations
  describe 'Factory' do
    it 'is valid' do
      expect(stage).to be_valid
    end
  end

  # Test the active record associations on the stage model
  describe 'ActiveRecord associations' do
    it { is_expected.to belong_to(:venue) }
    it { is_expected.to belong_to(:tech_specs).dependent(:destroy).optional }
    it { is_expected.to belong_to(:stage_plot).dependent(:destroy).optional }
    it { is_expected.to belong_to(:seating_chart).dependent(:destroy).optional }

    it { is_expected.to accept_nested_attributes_for(:tech_specs).allow_destroy(true) }
    it { is_expected.to accept_nested_attributes_for(:stage_plot).allow_destroy(true) }
    it { is_expected.to accept_nested_attributes_for(:seating_chart).allow_destroy(true) }
  end

  # Test the upload association methods on stage model
  describe 'upload association accessor methods' do
    # If stage has a given upload, the method should return the instance of that upload
    context 'when an upload is associated' do
      let(:tech_specs) { create(:better_together_upload) }
      let(:stage_plot) { create(:better_together_upload) }
      let(:seating_chart) { create(:better_together_upload) }
      let(:stage_with_uploads) do
        create(:stage,
               tech_specs: tech_specs,
               stage_plot: stage_plot,
               seating_chart: seating_chart)
      end

      it 'returns the associated upload' do
        expect(stage_with_uploads.tech_specs).to eq(tech_specs)
        expect(stage_with_uploads.stage_plot).to eq(stage_plot)
        expect(stage_with_uploads.seating_chart).to eq(seating_chart)
      end
    end

    # If the stage does not have an upload, the method should build a new one
    context 'when a stage has no uploads associated' do
      let(:stage_without_uploads) do
        create(:stage,
               tech_specs: nil,
               stage_plot: nil,
               seating_chart: nil)
      end

      it 'builds a new, unsaved upload association' do
        expect(stage_without_uploads.tech_specs).to be_an_instance_of(BetterTogether::Upload)
        expect(stage_without_uploads.stage_plot).to be_an_instance_of(BetterTogether::Upload)
        expect(stage_without_uploads.seating_chart).to be_an_instance_of(BetterTogether::Upload)
      end
    end
  end
end
