class XqueryController < ApplicationController
 require 'BaseXClient.rb'

  def index
  end


  def show
    #
    # # create session
    # session = BaseXClient::Session.new("localhost", 1984, "admin", "admin")
    #
    #
    # # perform command and print returned string
    # print session.execute("help")
    #  @query_result = ''
    #  @query_result += session.execute("open db") + '\n'
    # @query_result += session.execute(params[:search])
    #
    #
    #
    # # close session
    # session.close
end


def create
    # require 'BaseXClient.rb'
    #  session = BaseXClient::Session.new("localhost", 1984, "admin", "admin")
    #  session.execute("drop db db")
    #  @test = session.execute("create database db")
    #  session.execute("open db")
    #  session.execute("add /home/ubuntu/workspace/ARO-4-0001-01_ARO-4-0010-06_WH_AH_EF.xml")
    #  session.close
end

end
