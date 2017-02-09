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

#   print session.execute('open test')
#	print session.execute('xquery  //text()')
#   print session.execute('info db')
#   print session.execute('info storage')
   print session.execute('list test /')


  # close session
  session.close

  # print time needed
  time = (Time.now - start_time) * 1000
  puts " #{time} ms."

rescue Exception => e
  # print exception
  puts e
end
