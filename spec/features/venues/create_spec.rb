# frozen_string_literal: true

require 'rails_helper'

RSpec.feature 'create a venue', type: :feature do
  include DeviseSessionHelpers
  include VenueFormHelpers

  before do
    configure_host_platform
    login_as_platform_manager
  end

  describe 'submit with' do
    scenario 'valid inputs' do
      venue = build(:venue)
      fill_in_venue_form(venue)
      visit main_app.venues_path(locale: I18n.locale)
      expect(page).to have_content(venue.name)
    end

    scenario 'invalid inputs' do
      venue = build(:venue, name: 'AB')
      fill_in_venue_form(venue)
      expect(page).to have_content('Community slug is too short')
    end
  end
end
