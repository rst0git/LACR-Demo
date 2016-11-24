class Articles < ActiveRecord::Base
  searchkick suggest: [:title]
end
