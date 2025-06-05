# frozen_string_literal: true

# CRUD for artists
class ArtistsController < BetterTogether::FriendlyResourceController
  protected

  def resource_class
    Artist
  end
end
