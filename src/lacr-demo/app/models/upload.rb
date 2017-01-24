class Upload < ApplicationRecord
  mount_uploader :xml, XmlUploader # Tells rails to use this uploader for this model.
  mount_uploader :image, ImageUploader # Tells rails to use this uploader for this model.
end
