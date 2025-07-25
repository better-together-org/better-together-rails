# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'creating a platform invitation', type: :feature do
  include DeviseSessionHelpers
  before do
    @host_platform = configure_host_platform
    login_as_platform_manager
  end

  scenario 'with valid inputs' do
    invitee_email = Faker::Internet.unique.email
    visit better_together.platform_path(@host_platform, locale: I18n.locale)
    within '#newInvitationModal' do
      select 'Platform Invitation', from: 'platform_invitation[type]'
      select 'Community Facilitator', from: 'platform_invitation[community_role_id]'
      select 'Platform Manager', from: 'platform_invitation[platform_role_id]'
      fill_in 'platform_invitation[invitee_email]', with: invitee_email
      click_button 'Invite'
      visit better_together.platform_path(@host_platform, locale: I18n.locale)
    end
    expect(page).to have_content(invitee_email)
  end
end
