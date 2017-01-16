class Document < ApplicationRecord
	searchkick suggest: [:title]
end
