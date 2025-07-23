# frozen_string_literal: true

require 'rails_helper'

RSpec.describe VenueInvitation, type: :model do
  subject(:invitation) { build(:venue_invitation) }

  let(:existing_invitation) { create(:venue_invitation) }

  describe 'Factory' do
    it 'is a valid factory' do
      expect(invitation).to be_valid
    end
  end

  describe 'ActiveRecord associations' do
    # it { is_expected.to belong_to(:invitable).class_name('VenueCommunity') }
    # it { is_expected.to belong_to(:inviter).class_name('BetterTogether::Person') }
    it { is_expected.to have_one(:venue_invitation_venue) }
    it { is_expected.to have_one(:venue).through(:venue_invitation_venue) }

    it { is_expected.to accept_nested_attributes_for(:venue_invitation_venue) }
  end

  # describe '#after_accept!' do
  #   it 'creates a new venue member with the correct role when accepted' do
  #     existing_invitation.status = 'accepted'
  #     existing_invitation.after_accept!

  #     expect(BetterTogether::PersonCommunityMembership.find_by(
  #       member_id: existing_invitation.invitee_id,
  #       joinable_id: existing_invitation.venue.community_id,
  #       role_id: existing_invitation.venue_invitation_venue.role_id
  #       )).to exist
  #   end
  # end
end
