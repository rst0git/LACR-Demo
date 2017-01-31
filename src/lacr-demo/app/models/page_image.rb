class PageImage < ApplicationRecord
	# Document has one image
	has_one :transcription_xml

  # Mount the file uploader
  mount_uploader :image, ImageUploader

	# Allows you to create and update the records in one go
	accepts_nested_attributes_for :transcription_xml, allow_destroy: true

end
