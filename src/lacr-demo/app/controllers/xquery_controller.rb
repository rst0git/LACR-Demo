class XqueryController < ApplicationController
 require 'BaseXClient.rb'

  def index
  end

 def show
    # create session
    session = BaseXClient::Session.new("xmldb", 1984, "admin", "admin")
    # session.create_readOnly()
    # Open DB or create if does not exist
    session.open_or_create_db("xmldb")
    # Get user query
    input = params[:search]
   # XQuery declaration of the namespace
    declarate_ns = 'declare namespace ns = "http://www.tei-c.org/ns/1.0";'
    # Create instance the BaseX Client in Query Mode
    query = session.query(declarate_ns + input)
    # Store the result
     @query_result = query.execute
    # Count the number of results
    @number_of_results = session.query("#{declarate_ns}count(#{input})").execute.to_i
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
