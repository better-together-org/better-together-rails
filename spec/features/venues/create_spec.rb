# frozen_string_literal: true

require 'rails_helper'

RSpec.feature 'Venues', type: :feature do
  include DeviseSessionHelpers
  before do
    configure_host_platform
    login_as_platform_manager
  end

  describe 'creating a new venue' do
    scenario 'with valid inputs' do
      venue = build(:venue)
      visit main_app.new_venue_path(locale: I18n.locale)
      fill_in 'venue[name_en]', with: venue.name
      fill_in 'venue[slug_en]', with: venue.slug
      select 'Public', from: 'Privacy'
      find_by_id('new_venue-description_en').click.set(venue.description)
      first(:button, 'Save Venue').click
      visit main_app.venues_path(locale: I18n.locale)
      expect(page).to have_content(venue.name)
    end

    scenario 'with invalid inputs' do
      venue = build(:venue, name: 'AB')
      visit main_app.new_venue_path(locale: I18n.locale)
      fill_in 'venue[name_en]', with: venue.name
      fill_in 'venue[slug_en]', with: venue.slug
      select 'Public', from: 'Privacy'
      find_by_id('new_venue-description_en').click.set(venue.description)
      first(:button, 'Save Venue').click
      expect(page).to have_content('Community slug is too short')
    end
  end
end
