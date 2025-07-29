# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'deleting a venue', type: :feature do
  include DeviseSessionHelpers

  let!(:venue) { create(:venue, :public) }

  before do
    configure_host_platform
    login_as_platform_manager
  end

  it 'shows on the venues index' do
    visit main_app.venues_path(locale: I18n.locale)
    expect(page).to have_content(venue.name)
  end

  scenario 'success' do
    visit main_app.venue_path(locale: I18n.locale, id: venue.id)
    click_link 'Delete'
    visit main_app.venues_path(locale: I18n.locale)
    expect(page).not_to have_content(venue.name)
  end
end
