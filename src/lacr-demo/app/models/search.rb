class Search < ApplicationRecord
  searchkick suggest: [:title, :content], callbacks: :async
end
