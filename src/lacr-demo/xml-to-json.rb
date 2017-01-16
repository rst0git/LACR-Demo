#!/usr/bin/env ruby
# Name: xml_to_json.rb:
# Description: Simple ruby script which:
#     * goes through each '.xml' document in the directory 'app/assests/transcriptions'
#     * reads the content of the file into the variable 'doc'
#     * for each 'div' tag with key: 'type'='court'
#         * extract the xml keys ( e.g "when"=>"1457-01-29", "cert"=>"high") of the 'date' xml tag into variable 'date'
#         * for each 'div' tag which is a child of the above 'div' tag with 'type'='court'
#             * extract the keys (e.g "type"=>"entry", "xml:id"=>"ARO-5-0294-11", "xml:lang"=>"la") into variable 'metadata'
#             * extract the text content into variable 'data'
#             * prints variables metadata, date, data


require "nokogiri"

files = Dir[ 'app/assets/transcriptions/*.xml' ]


files.each do |file|
	doc = Nokogiri::Slop (File.open(file))

	doc.xpath('//body//div').each do |record|
			if record.values.include? "court"
				d = record.search('date')[0]
				date = Hash[d.keys.zip(d.values)]

				record.search('div').each do |tr|
					metadata = Hash[tr.keys.zip(tr.values)]
					data = tr.text.to_s.strip

					p "--------Document------------"
					p metadata, date
					p data

				end
			end
		end
end
