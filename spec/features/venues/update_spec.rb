# frozen_string_literal: true

require 'rails_helper'

RSpec.feature 'Venues', type: :feature do
  include DeviseSessionHelpers
  before do
    configure_host_platform
    login_as_platform_manager
  end

  describe 'updating a venue' do
    scenario 'with valid inputs' do
      venue = create(:venue)
      new_name = Faker::Company.name
      visit main_app.edit_venue_path(locale: I18n.locale, id: venue.id)
      fill_in 'venue[name_en]', with: new_name
      first(:button, 'Save Venue').click
      visit main_app.venues_path(locale: I18n.locale)
      expect(page).to have_content(new_name)
    end
  end
end
