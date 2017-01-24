class XmlUploader < CarrierWave::Uploader::Base
  storage :file
  process :xml_to_json

  def content_type_whitelist
    ['text/xml']
  end

  def store_dir
    "documents/transcriptions"
  end

  def extension_white_list
     %w(xml)
  end
  
  private
  def xml_to_json
      doc = Nokogiri::Slop (File.open(current_path))
      # doc_json = Hash.from_xml(file_content).to_json

      doc.xpath('//body//div').each do |record|
          if record.values.include? "court"
            d = record.search('date')[0]
            date = Hash[d.keys.zip(d.values)]

            record.search('div').each do |tr|
              metadata = Hash[tr.keys.zip(tr.values)]
              document = Document.new "title": metadata['xml:id'], 'content': tr.text.to_s
              document.save
            end

          end

        end
      end
end
