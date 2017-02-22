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
    @query_result = session.query(params[:search])
    # close session
    session.close
  end

  def upload
    #  session = BaseXClient::Session.new("localhost", 1984, "admin", "admin")
    # session.open_or_create_db("xmldb")
    #  session.execute("add /home/ubuntu/workspace/ARO-4-0001-01_ARO-4-0010-06_WH_AH_EF.xml")
    #  session.close
  end

end
