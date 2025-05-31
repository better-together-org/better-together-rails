# frozen_string_literal: true

module ArtistsHelper
  def bookable_artists
    policy_scope(Artist)
  end
end
