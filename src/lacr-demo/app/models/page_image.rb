class PageImage < ApplicationRecord
  # Mount the file uploader
  mount_uploader :image, ImageUploader

  def parse_filename_to_volume_page(filename)
    self.volume, self.page = filename.split(/-|_/).map{|x| x.to_i}.delete_if{|i| i==0}
  end
end
