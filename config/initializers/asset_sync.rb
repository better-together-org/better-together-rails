# frozen_string_literal: true

if defined?(AssetSync)
  AssetSync.configure do |config|
    skip_asset_sync = ActiveModel::Type::Boolean.new.cast(ENV.fetch('SKIP_ASSET_SYNC', nil))
    config.fog_provider = 'AWS'
    config.run_on_precompile = !skip_asset_sync

    config.aws_access_key_id = ENV.fetch('AWS_ACCESS_KEY_ID', nil)
    config.aws_secret_access_key = ENV.fetch('AWS_SECRET_ACCESS_KEY', nil)

    config.aws_session_token = ENV['AWS_SESSION_TOKEN'] if ENV.key?('AWS_SESSION_TOKEN')

    # Ensure that aws_iam_roles is set to false if not explicitly required
    config.aws_iam_roles = ENV['AWS_IAM_ROLES'] == 'true'

    config.fog_directory = ENV.fetch('FOG_DIRECTORY', nil)
    config.fog_region = ENV.fetch('FOG_REGION', nil)

    # Additional configurations (commented out by default)
    # config.aws_reduced_redundancy = true
    # config.aws_signature_version = 4
    # config.aws_acl = nil
    # ASSET_SYNC_ENDPOINT is only set for non-AWS S3-compatible providers.
    # Do not use FOG_HOST here: in production it is the public CDN hostname,
    # not an S3 API endpoint.
    s3_endpoint = ENV.fetch('ASSET_SYNC_ENDPOINT', nil)

    if !skip_asset_sync && s3_endpoint && s3_endpoint !~ /amazonaws\.com/i
      config.fog_host = s3_endpoint
      # MinIO requires path-style access (not virtual-hosted)
      config.fog_options = { path_style: true }
    end
    # config.fog_port = "9000"
    config.fog_scheme = 'https'
    config.cdn_distribution_id = ENV['CDN_DISTRIBUTION_ID'] if ENV.key?('CDN_DISTRIBUTION_ID')
    # config.invalidate = ['file1.js']
    # config.existing_remote_files = "keep"
    # config.gzip_compression = true
    # config.manifest = true
    # config.include_manifest = false
    # config.remote_file_list_cache_file_path = './.asset_sync_remote_file_list_cache.json'
    # config.remote_file_list_remote_path = '/remote/asset_sync_remote_file.json'
    config.fail_silently = true
    config.log_silently = true
    config.concurrent_uploads = true
  end
end
