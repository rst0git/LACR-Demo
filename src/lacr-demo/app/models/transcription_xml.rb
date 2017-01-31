class TranscriptionXml < ApplicationRecord
  HisTEI_NS = 'http://www.tei-c.org/ns/1.0'

  # belongs to documents model
  belongs_to :page_image

	# Document has many transcriptions
	has_many :transcription_json_paragraphs

  # Mount the file uploader
  mount_uploader :xml, XmlUploader

	accepts_nested_attributes_for :transcription_json_paragraphs, allow_destroy: true

  def xml_to_json

    # Check if namespace includes HisTEI
    if  Nokogiri::XML(File.open(xml.current_path)).collect_namespaces.values.include? HisTEI_NS
      # Read the content into Nokogiri object
      doc = Nokogiri::Slop (File.open(xml.current_path))
      # doc_json = Hash.from_xml(File.open(xml.current_path)).to_json

      p 'doc.xpath'
      p doc.xpath('//body//div').length

      doc.xpath('//body//div').each do |record|
        if record.values.include? "court"
          d = record.search('date')[0]
          date = Hash[d.keys.zip(d.values)]

          record.search('div').each do |tr|
            metadata = Hash[tr.keys.zip(tr.values)]

            transcription_json_paragraph = TranscriptionJsonParagraph.new
            transcription_json_paragraph.title = metadata['xml:id']
            transcription_json_paragraph.content = Hash.from_xml(tr.to_xml)
            transcription_json_paragraph.language = metadata['xml:lang']
            transcription_json_paragraph.date = date['when']
            transcription_json_paragraph.save

            searchable = Search.new
            searchable.title = metadata['xml:id']
            searchable.content = tr.text.to_s.gsub(/\s+/, " ").strip
            searchable.id = transcription_json_paragraph.id
            searchable.transcription_json_paragraph = transcription_json_paragraph
            searchable.save
          end # record.search('div').each do |tr|
        end # if record.values.include? "court"
      end # doc.xpath('//body//div').each do |record|
    end # if doc.collect_namespaces.values.include? HisTEI_NS
  end # def xml_to_json

end
