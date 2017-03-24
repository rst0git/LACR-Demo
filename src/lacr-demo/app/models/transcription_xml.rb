class TranscriptionXml < ApplicationRecord
  # Use unique filenames and overwrite on upload
  validates_uniqueness_of :filename

  HISTEI_NS = 'http://www.tei-c.org/ns/1.0'
  # Mount the file uploader
  mount_uploader :xml, XmlUploader

  # Extract the volume, page and paragraph from the Entry ID
  def splitEntryID(id)
    return id.to_s.split(/-|_/).map{|x| x.to_i}.delete_if{|i| i==0}
  end

  # Recursive function to convert the XML format to valid HTML5
  def xml_to_html(tag)
    tag.children().each do |c|
      # Rename the attributes
      c.keys.each do |k|
        c["data-#{k}"] = c.delete(k)
      end
      # Rename the tag and replace lb with br
      c['class'] = "xml-tag #{c.name.gsub(':', '-')}"
      # To avoid invalid void tags: Use "br" if "lb", otherwise "span"
      c.name = c.name == 'lb' ?  "br" : "span"
      # Use recursion
      xml_to_html(c)
    end
  end

  def histei_split_to_paragraphs
    doc = Nokogiri::XML (File.open(xml.current_path))

    # Remove Processing Instructions. Tags of type <? .. ?>
    doc.xpath('//processing-instruction()').remove

    # # Create empty pages
    # page_breaks = doc.xpath("//xmlns:pb[@n]", 'xmlns' => HISTEI_NS)
    # # The volume number is extracted from the xml:id of div
    # volume = splitEntryID(doc.xpath('//xmlns:div[@xml:id]/@xml:id', 'xmlns' => HISTEI_NS)[0])[0]
    # page_breaks.each do |pb|
    #   begin
    #     # The attribute @n is assumed to be the page number
    #     page = pb.xpath('@n').to_s.to_i
    #
    #     # The note contains information about the page
    #     # it content is usually "Page is empty."
    #     if not Search.exists?(page: page, volume: volume, paragraph: 1)
    #       s = Search.new
    #       s.volume = volume
    #       s.page = page
    #       s.paragraph = 1
    #       pr = TrParagraph.new
    #       pr.content_xml = note.to_xml
    #       pr.content_html = "Page is empty."
    #       pr.save
    #       s.tr_paragraph = pr
    #       s.transcription_xml = self
    #       s.save
    #     end
    #   rescue Exception => e
    #     logger.error(e)
    #   end
    # end

    # Extract all "div" tags with atribute "xml:id"
    entries = doc.xpath("//xmlns:div[@xml:id]", 'xmlns' => HISTEI_NS)
    # Parse each entry as follows
    entries.each do |entry|

      # Go to the closest parent "div" of the entry and find a child "date"
      # and extract the 'when' argument
      date_str = entry.xpath("ancestor::xmlns:div[1]//xmlns:date/@when", 'xmlns' => HISTEI_NS).to_s
      if date_str.split('-').length == 3
        entry_date_incorrect = nil
        entry_date = date_str.to_date
      elsif date_str.split('-').length == 2
        entry_date_incorrect = date_str
        entry_date = "#{date_str}-1".to_date # If the day is missing set ot 1-st
      elsif date_str.split('-').length == 1
        entry_date_incorrect = date_str
        entry_date = "#{date_str}-1-1".to_date # If the day and month are missing set ot 1-st Jan.
      else
        entry_date_incorrect = 'N/A'
        entry_date = nil # The date is missing
      end

      # Convert the 'entry' and 'date' Nokogiri objects to Ruby Hashes
      entry_id = entry.xpath("@xml:id").to_s
      entry_lang = entry.xpath("@xml:lang").to_s
      case entry_lang # Fix language standad
      when 'sc'
        entry_lang = 'sco'
      when 'la'
        entry_lang = 'lat'
      when 'nl'
        entry_lang = 'nld'
      end
      entry_xml = entry.to_xml.gsub('xml:lang="sc"', 'xml:lang="sco"').gsub('xml:lang="la"', 'xml:lang="lat"').gsub('xml:lang="nl"', 'xml:lang="nld"')
      entry_text =(Nokogiri::XML(entry_xml.gsub('<lb break="yes"/>', "\n"))).xpath('normalize-space()')
      xml_to_html(entry)
      entry_html = entry.to_xml

      # Split entryID
      volum, page, paragraph = splitEntryID(entry)
      # Overwrite if exists
      if Search.exists?(page: page, volume: volume, paragraph: paragraph)
        s = Search.find_by(entry: entry_id)
        # Get existing paragraph
        pr = s.tr_paragraph
      else
        # Create new search record
        s = Search.new
        s.entry = entry_id
        s.volume = volume
        s.page = page
        s.paragraph = paragraph
        # Create TrParagraph record
        pr = TrParagraph.new
      end

      # Save the new content
      pr.content_xml = entry_xml
      pr.content_html = entry_html
      pr.save

      # Create Search record
      s.tr_paragraph = pr
      s.transcription_xml = self
      s.lang = entry_lang
      s.date = entry_date
      s.date_incorrect = entry_date_incorrect
      # Replace line-break tag with \n and normalize whitespace
      s.content = entry_text
      s.save
    end

  end
end
