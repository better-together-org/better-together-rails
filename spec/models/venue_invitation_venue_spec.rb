# frozen_string_literal: true

require 'rails_helper'

RSpec.describe VenueInvitationVenue, type: :model do
  subject(:invitation_venue) { build(:venue_invitation_venue) }

  describe 'Factory' do
    it 'is a valid factory' do
      expect(invitation_venue).to be_valid
    end
  end

  describe 'ActiveRecord associations' do
    it { is_expected.to belong_to(:venue) }
    it { is_expected.to belong_to(:venue_invitation) }
    it { is_expected.to belong_to(:role) }
  end
end
