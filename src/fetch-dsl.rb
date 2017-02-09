#!/usr/bin/env ruby
require 'rubygems'
require 'nokogiri'
require "addressable/uri" # Needs 'gem install addressable'
require 'open-uri'

print "Enter search token: "
search_token = gets.chomp

not_alphabetic_characters = /[^[:alpha:]]/

# Use the search only if the search_token is alphabetic 
if not not_alphabetic_characters.match(search_token)

	url = 'http://www.dsl.ac.uk/results/' + search_token
	# Validate URL
	url = Addressable::URI.parse(url)
	
	# Catch OpenURI::HTTPError
	begin
		http_page = open(url.normalize.to_s) 
		http_base_url = url.origin
		html_doc = Nokogiri::HTML(http_page)
		
		snd_results = html_doc.css('div#sndResultsNew ol a')
		dost_results = html_doc.css('div#dostResultsNew ol a')
		
		
		snd_results.each do |a_tag|
			p http_base_url + a_tag['href']
		end
		
		
		dost_results.each do |a_tag|
			p http_base_url + a_tag['href']
		end
	
	rescue
		puts "->Error searching for \"#{search_token}\""
	end
end