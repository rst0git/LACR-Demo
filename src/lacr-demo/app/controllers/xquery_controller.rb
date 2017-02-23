class XqueryController < ApplicationController
 require 'BaseXClient.rb'

  def index
  end

  def show
    # create session
    session = BaseXClient::Session.new("xmldb", 1984, "admin", "admin")
    # Open DB or create if does not exist
    session.open_or_create_db("xmldb")
    # Execute the query entered by the user
    @query_result = session.execute("#{params[:search]}")
    # close session
    session.close
  end

  def upload(files)
     session = BaseXClient::Session.new("xmldb", 1984, "admin", "admin")
     session.open_or_create_db("xmldb")
     files.each do |file_name, file_content|
       session.add(file_name, file_content)
     end
     session.close
  end

end
