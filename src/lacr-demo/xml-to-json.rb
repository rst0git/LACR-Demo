#!/usr/bin/env ruby

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
