class Search < ApplicationRecord
  searchkick  highlight: [:content], suggest: [:title, :content], word_start: [:title], callbacks: :async
  has_one :transcription_json_paragraph
end
