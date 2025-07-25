# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'accepting a platform invitation', type: :feature do
  include DeviseSessionHelpers
  before do
    @host_platform = configure_host_platform
    @invitation = create(:better_together_platform_invitation,
                         invitable: @host_platform)
  end

  scenario 'by signing up a new user' do
    invitee_email = @invitation.invitee_email
    password = Faker::Internet.password(min_length: 12, max_length: 20)
    person = build(:better_together_person)
    visit better_together.new_user_registration_path(invitation_code: @invitation.token,
                                                     locale: I18n.locale)
    fill_in 'user[password]', with: password
    fill_in 'user[password_confirmation]', with: password
    fill_in 'user[person_attributes][name]', with: person.name
    fill_in 'user[person_attributes][identifier]', with: person.identifier
    fill_in 'user[person_attributes][description]', with: person.description
    click_button 'Sign Up'
    created_user = BetterTogether::User.find_by(email: invitee_email)
    created_user.confirm
    fill_in 'user[email]', with: created_user.email
    fill_in 'user[password]', with: password
    click_button 'Sign In'
    save_and_open_page
  end
end
