# frozen_string_literal: true

# Registers the origin that serves Active Storage files directly (presigned URLs and direct uploads)
# with CE's Content-Security-Policy, so a deployment needs no CSP_* variables for its bucket.
module HostStorageContentSecurityPolicy
  module_function

  # S3_ENDPOINT for S3-compatible storage (Garage), otherwise the AWS bucket host.
  def storage_origin(env = ENV)
    sources = BetterTogether::ContentSecurityPolicySources
    return sources.origin_for_url(env['S3_ENDPOINT']) if env['S3_ENDPOINT'].present?
    return if env['S3_BUCKET_NAME'].blank? || env['S3_REGION'].blank?

    sources.origin_for_url("https://#{env['S3_BUCKET_NAME']}.s3.#{env['S3_REGION']}.amazonaws.com")
  end

  def register(env = ENV)
    origin = storage_origin(env)
    return if origin.blank?

    BetterTogether.register_content_security_policy_sources(:img_src, origin)
    BetterTogether.register_content_security_policy_sources(:connect_src, origin)
  end
end

HostStorageContentSecurityPolicy.register
