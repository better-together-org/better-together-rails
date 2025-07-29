# frozen_string_literal: true

module VenueFormHelpers
  def fill_in_venue_form(venue)
    visit main_app.new_venue_path(locale: I18n.locale)
    fill_in 'venue[name_en]', with: venue.name
    fill_in 'venue[slug_en]', with: venue.slug
    select 'Public', from: 'Privacy'
    find_by_id('new_venue-description_en').click.set(venue.description)
    first(:button, 'Save Venue').click
  end
end
