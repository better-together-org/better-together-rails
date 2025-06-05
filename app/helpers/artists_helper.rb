# frozen_string_literal: true

module ArtistsHelper # rubocop:todo Style/Documentation
  def bookable_artists
    policy_scope(Artist)
  end
end
