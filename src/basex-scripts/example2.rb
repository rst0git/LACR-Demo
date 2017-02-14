# This example shows how database commands can be executed.
# Documentation: http://docs.basex.org/wiki/Clients
#
# (C) BaseX Team 2005-12, BSD License

require './BaseXClient.rb'

begin
  # create session
  session = BaseXClient::Session.new("localhost", 1984, "admin", "admin")
while true do
  #Take user query
  puts "Enter Query"
  userquery = gets.chomp

  # perform command and print returned string
  print session.execute(userquery)

  # close session
#  session.close
end

rescue Exception => e
  # print exception
  puts e
end