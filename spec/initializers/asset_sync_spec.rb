# frozen_string_literal: true

require 'rails_helper'

class AssetSyncInitializerHarness
  Config = Struct.new(
    :fog_provider,
    :run_on_precompile,
    :aws_access_key_id,
    :aws_secret_access_key,
    :aws_session_token,
    :aws_iam_roles,
    :fog_directory,
    :fog_region,
    :fog_host,
    :fog_options,
    :fog_scheme,
    :cdn_distribution_id,
    :fail_silently,
    :log_silently,
    :concurrent_uploads
  )
end

# rubocop:disable RSpec/SpecFilePathFormat
RSpec.describe AssetSyncInitializerHarness do
  around do |example|
    original_env = ENV.to_h.slice('ASSET_SYNC_ENABLED', 'SKIP_ASSET_SYNC')

    ENV.delete('ASSET_SYNC_ENABLED')
    ENV.delete('SKIP_ASSET_SYNC')

    example.run

    ENV.delete('ASSET_SYNC_ENABLED')
    ENV.delete('SKIP_ASSET_SYNC')
    original_env.each { |key, value| ENV[key] = value }
  end

  def load_initializer # rubocop:disable Metrics/MethodLength
    config = described_class::Config.new
    hide_const('AssetSync') if defined?(AssetSync)

    stub_const(
      'AssetSync',
      Class.new do
        class << self
          attr_accessor :captured_config

          def configure
            yield(captured_config)
          end
        end
      end
    )
    AssetSync.captured_config = config

    load Rails.root.join('config/initializers/asset_sync.rb')

    config
  end

  it 'enables sync when ASSET_SYNC_ENABLED is true and SKIP_ASSET_SYNC is unset' do
    ENV['ASSET_SYNC_ENABLED'] = 'true'

    config = load_initializer

    expect(config.run_on_precompile).to be(true)
  end

  it 'lets SKIP_ASSET_SYNC override ASSET_SYNC_ENABLED' do
    ENV['ASSET_SYNC_ENABLED'] = 'true'
    ENV['SKIP_ASSET_SYNC'] = 'true'

    config = load_initializer

    expect(config.run_on_precompile).to be(false)
  end
end
# rubocop:enable RSpec/SpecFilePathFormat
