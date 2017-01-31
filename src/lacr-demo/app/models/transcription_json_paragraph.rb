class TranscriptionJsonParagraph < ApplicationRecord
  # belongs to documents model
  belongs_to :transcription_xml
  belongs_to :page_image
end
