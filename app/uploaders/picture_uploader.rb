class PictureUploader < CarrierWave::Uploader::Base
  # Store files locally in development/test
  if Rails.env.development? || Rails.env.test?
    storage :file
  else
    # Use AWS S3 in production
    storage :fog
  end

  # Use MiniMagick for processing
  include CarrierWave::MiniMagick

  # Basic processing example (optional)
  process resize_to_limit: [1200, 1200]

  # Whitelist image types
  def content_type_allowlist
    %w[image/png image/jpeg image/jpg image/gif image/webp]
  end

  # Where to store
  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end
end
