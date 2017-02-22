class TranscriptionXml < ApplicationRecord
  HISTEI_NS = 'http://www.tei-c.org/ns/1.0'
  # Mount the file uploader
  mount_uploader :xml, XmlUploader

  def xml_to_html(tag)
    tag.children().each do |c|
      # Rename the attributes
      c.keys.each do |k|
        c["data-#{k}"] = c.delete(k)
      end
      # Rename the tag
      c['class'] = "xml-tag #{c.name.gsub(':', '-')}"
      c.name = "span"
      # Use recursion
      xml_to_html(c)
    end
  end

  def histei_split_to_paragraphs
    doc = Nokogiri::XML (File.open(xml.current_path))

    # Remove Processing Instructions. Tags of type <? .. ?>
    doc.xpath('//processing-instruction()').remove

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
        date = nil # The date is missing
      end

      # Convert the 'entry' and 'date' Nokogiri objects to Ruby Hashes
      entry_id = entry.xpath("@xml:id").to_s
      entry_lang = entry.xpath("@xml:lang").to_s
      entry_xml = entry.to_xml
      entry_text =(Nokogiri::XML(entry_xml.gsub('<lb break="yes"/>', "\n"))).xpath('normalize-space()')
      xml_to_html(entry)
      entry_html = entry.to_xml

      # Create TrParagraph record
      pr = TrParagraph.new
      pr.content_xml = entry_xml
      pr.content_html = entry_html
      pr.save

      # Create Search record
      s = Search.new
      s.tr_paragraph = pr
      s.transcription_xml = self
      s.entry = entry_id
      s.lang = entry_lang
      s.date = entry_date
      s.date_incorrect = entry_date_incorrect
      s.parse_entry_to_vol_page_paragraph
      # Replace line-break tag with \n and normalize whitespace
      s.content = entry_text
      s.save
    end

  end
end
