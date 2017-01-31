class ImageUploader < CarrierWave::Uploader::Base
  # permissions = 0700
  storage :file

  def store_dir
    "uploads/image/"
  end

  def extension_whitelist
    %w(tiff tif)
  end

  def content_type_whitelist
      ['image/tiff', 'image/tiff-fx']
  end
end
