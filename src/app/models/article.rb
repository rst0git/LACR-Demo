class Article < ActiveRecord::Base
  searchkick suggest: [:title]
end
