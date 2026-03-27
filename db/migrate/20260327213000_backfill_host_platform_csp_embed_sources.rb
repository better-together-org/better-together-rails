# frozen_string_literal: true

# Backfills the host platform CSP iframe allowlist for the emergency embed hotfix.
class BackfillHostPlatformCspEmbedSources < ActiveRecord::Migration[8.0]
  FRAME_SOURCES = [
    'https://forms.btsdev.ca',
    'https://www.youtube.com',
    'https://www.youtube-nocookie.com'
  ].freeze

  def up
    return unless table_exists?(:better_together_platforms)

    say_with_time 'Backfilling host platform CSP iframe sources' do
      host_platform = host_platform_relation.first
      next 0 unless host_platform

      settings = host_platform.settings.deep_dup
      settings['csp_frame_src'] = merge_origins(settings['csp_frame_src'], FRAME_SOURCES)

      host_platform.update!(settings:)
      1
    end
  end

  def down
    return unless table_exists?(:better_together_platforms)

    say_with_time 'Removing hotfix CSP iframe sources from host platform' do
      host_platform = host_platform_relation.first
      next 0 unless host_platform

      settings = host_platform.settings.deep_dup
      settings['csp_frame_src'] = Array(settings['csp_frame_src']) - FRAME_SOURCES
      settings.delete('csp_frame_src') if settings['csp_frame_src'].blank?

      host_platform.update!(settings:)
      1
    end
  end

  private

  def host_platform_relation
    BetterTogether::Platform.where(host: true)
  end

  def merge_origins(existing_origins, additions)
    (Array(existing_origins) + additions).map(&:to_s).reject(&:blank?).uniq
  end
end
