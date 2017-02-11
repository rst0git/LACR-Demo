class Search < ApplicationRecord
  # Input validators
  validates :page, numericality: { only_integer: true, greater_than: 0  }
  validates :volume, numericality: { only_integer: true, greater_than: 0  }
  validates :paragraph, numericality: { only_integer: true, greater_than: 0  }

  has_one :tr_paragraph
  searchkick  searchable: [:content], # Searchable Fields: Speed up indexing and reduce index size by only making some fields searchable
              filterable: [:entry, :date, :lang, :page, :volume, :paragraph, :entry_type], # Filterable Fields: Speed up indexing and reduce index size by only making some fields filterable.
              highlight: [:content],
              suggest: [:entry, :content],
              word_start: [:entry]

  # Control what data is indexed
  def search_data
  {
     entry: entry,
     date: date,
     lang: lang,
     page: page,
     content: content,
     volume: volume,
     paragraph: paragraph,
     entry_type: entry_type
   }
  end

  # Extract the volume, page and paragraph from the Entry ID
 def parse_entry_to_vol_page_paragraph
   self.volume, self.page, self.paragraph = self.entry.split(/-|_/).map{|x| x.to_i}.delete_if{|i| i==0}
 end

end
