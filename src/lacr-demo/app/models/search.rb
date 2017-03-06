class Search < ApplicationRecord

  has_one :tr_paragraph
  belongs_to :transcription_xml
  searchkick  searchable: [:content, :entry], suggest: [:content], word_start: [:content, :entry]

  # Extract the volume, page and paragraph from the Entry ID
 def parse_entry_to_vol_page_paragraph
   self.volume, self.page, self.paragraph = self.entry.split(/-|_/).map{|x| x.to_i}.delete_if{|i| i==0}
 end

end
