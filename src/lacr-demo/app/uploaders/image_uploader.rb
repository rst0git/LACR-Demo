class ImageUploader < CarrierWave::Uploader::Base
  storage :file

  def content_type_whitelist
    ['image/tif']
  end

  def store_dir
    "documents/images/"
  end

  def extension_white_list
     %w(tif)
  end
end
