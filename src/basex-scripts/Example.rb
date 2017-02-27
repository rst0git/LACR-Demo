# This example shows how database commands can be executed.
# Documentation: http://docs.basex.org/wiki/Clients
#
# (C) BaseX Team 2005-12, BSD License

require './BaseXClient.rb'

begin
  # initialize timer
  start_time = Time.now

  # create session
  session = BaseXClient::Session.new("localhost", 1984, "admin", "admin")

  # perform command and print returned string

#   print session.create('test', '')
#   puts session.open_db('test123')
#   puts session.open_db('test1')
	print session.execute('help')


  # close session
  session.close

  # print time needed
  time = (Time.now - start_time) * 1000
  puts " #{time} ms."

rescue Exception => e
  # print exception
  puts e
end
