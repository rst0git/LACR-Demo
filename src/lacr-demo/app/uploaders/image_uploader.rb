class ImageUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick
  # permissions = 0700
  storage :file

  # Generate Web version
  version :web do
    process :efficient_conversion => [800,800]
  end

  # Generate thumbnail version
  version :thumb do
    process :efficient_conversion => [200,200]
  end

  def store_dir
    "uploads/image/"
  end

  def efficient_conversion(width, height)
    manipulate! do |img|
      img.format("png") do |c|
        c.fuzz        "3%"
        c.trim
        c.resize      "#{width}x#{height}>"
        c.resize      "#{width}x#{height}<"
      end
      img
    end
  end

  def extension_whitelist
    %w(tiff tif)
  end

  def content_type_whitelist
      ['image/tiff', 'image/tiff-fx']
  end
end
