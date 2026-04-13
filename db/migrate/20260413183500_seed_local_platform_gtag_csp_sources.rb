# frozen_string_literal: true

# Backfills local platform CSP settings so the host-app GTM snippet can load under
# the engine's existing dynamic per-platform CSP source model.
class SeedLocalPlatformGtagCspSources < ActiveRecord::Migration[7.1]
  # Migration-local model to avoid coupling this data backfill to app runtime code.
  class MigrationPlatform < ActiveRecord::Base
    self.table_name = 'better_together_platforms'
  end

  GTAG_SCRIPT_SOURCES = [
    'https://www.googletagmanager.com'
  ].freeze

  GTAG_CONNECT_SOURCES = [
    'https://www.google-analytics.com',
    'https://region1.google-analytics.com'
  ].freeze

  def up
    return unless platforms_table_ready?

    migrate_local_platforms do |settings|
      settings['csp_script_src'] = merge_sources(settings['csp_script_src'], GTAG_SCRIPT_SOURCES)
      settings['csp_connect_src'] = merge_sources(settings['csp_connect_src'], GTAG_CONNECT_SOURCES)
      settings
    end
  end

  def down
    return unless platforms_table_ready?

    migrate_local_platforms do |settings|
      remove_sources!(settings, 'csp_script_src', GTAG_SCRIPT_SOURCES)
      remove_sources!(settings, 'csp_connect_src', GTAG_CONNECT_SOURCES)
      settings
    end
  end

  private

  def platforms_table_ready?
    table_exists?(:better_together_platforms) &&
      column_exists?(:better_together_platforms, :settings) &&
      column_exists?(:better_together_platforms, :external)
  end

  def migrate_local_platforms
    MigrationPlatform.reset_column_information

    MigrationPlatform.where(external: false).find_each do |platform|
      settings = normalized_settings(platform.settings)
      updated_settings = yield(settings.deep_dup)
      next if updated_settings == settings

      platform.update_columns(settings: updated_settings, updated_at: Time.current)
    end
  end

  def normalized_settings(raw_settings)
    raw_settings.is_a?(Hash) ? raw_settings.deep_dup : {}
  end

  def merge_sources(existing_sources, additional_sources)
    (normalize_sources(existing_sources) + normalize_sources(additional_sources)).uniq
  end

  def remove_sources!(settings, key, sources_to_remove)
    updated_sources = normalize_sources(settings[key]) - normalize_sources(sources_to_remove)

    if updated_sources.empty?
      settings.delete(key)
    else
      settings[key] = updated_sources
    end
  end

  def normalize_sources(values)
    Array(values).map(&:to_s).map(&:strip).reject(&:empty?).uniq
  end
end
