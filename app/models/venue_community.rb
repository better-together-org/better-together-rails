# frozen_string_literal: true

# Join record between a deal type and a venue offer
class VenueCommunity < ::BetterTogether::Community
  def to_partial_path
    becomes(self.class.base_class).to_partial_path
  end
end
