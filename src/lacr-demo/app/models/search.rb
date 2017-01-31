class Search < ApplicationRecord
  searchkick suggest: [:title, :content], callbacks: :async
  has_one :transcription_json_paragraph
end
