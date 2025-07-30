# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'deleting a venue', type: :feature do
  include ActionView::RecordIdentifier
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

  scenario 'success', :js do
    venue_path = main_app.venue_path(locale: I18n.locale, id: venue.id)
    visit venue_path

    click_delete_venue_button(venue)

    visit main_app.venues_path(locale: I18n.locale)
    expect(page).not_to have_content(venue.name)
  end

  def click_delete_venue_button(venue)
    within("##{dom_id(venue, :toolbar)}") do
      accept_confirm do
        find('a[data-turbo-method="delete"]').click
      end
    end
  end
end
