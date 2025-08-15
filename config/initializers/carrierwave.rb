# config/initializers/carrierwave.rb
return unless defined?(CarrierWave)

if Rails.env.production?
  CarrierWave.configure do |config|
    # ⚠️ Do NOT set config.fog_provider on Rails 8 (it triggers a crash).
    # config.fog_provider = 'fog/aws'  # <- remove / comment out

    config.fog_credentials = {
      provider:              'AWS',
      aws_access_key_id:     ENV.fetch('AWS_ACCESS_KEY_ID', nil),
      aws_secret_access_key: ENV.fetch('AWS_SECRET_ACCESS_KEY', nil),
      region:                ENV.fetch('AWS_REGION', nil)
    }
    config.fog_directory  = ENV.fetch('S3_BUCKET', nil)
    config.fog_public     = true
  end
end
