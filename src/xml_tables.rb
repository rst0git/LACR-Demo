#!/usr/bin/env ruby
require 'pg'
conn = PGconn.open(:dbname => 'text_xml')