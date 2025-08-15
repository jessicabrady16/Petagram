# config/initializers/carrierwave.rb
return unless defined?(CarrierWave)

if Rails.env.production?
  CarrierWave.configure do |config|
    # ⚠️ Do NOT set config.fog_provider on Rails 8 (it triggers a crash).
    # config.fog_provider = 'fog/aws'  # <- remove / comment out

    config.fog_credentials = {
      provider:              'AWS',
      aws_access_key_id:     ENV['AWS_ACCESS_KEY_ID'] || ENV['AWS_ACCESS_KEY'],
      aws_secret_access_key: ENV['AWS_SECRET_ACCESS_KEY'] || ENV['AWS_SECRET_KEY'],
      region:                ENV.fetch('AWS_REGION', nil)
    }
    config.fog_directory  = ENV['S3_BUCKET'] || ENV['AWS_BUCKET']
    config.fog_public     = true
  end
end

if Rails.env.development? || Rails.env.test?
  CarrierWave.configure do |config|
    config.storage = :file
  end 
end 
