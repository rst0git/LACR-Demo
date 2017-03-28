class PageImage < ApplicationRecord
  # Mount the file uploader
  mount_uploader :image, ImageUploader

  def parse_filename_to_volume_page(filename)
    # Split the file name into array of valid integers
    arr = filename.split(/-|_/).map{|x| x.to_i}.delete_if{|i| i<=0}

    # Set the volume number to be the first valid integer
    # and the page number to be the last valid integer
    self.volume, self.page = arr[0], arr[-1]
  end
end
