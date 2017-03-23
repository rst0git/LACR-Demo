# Initialise user management for BaseX
# => Change admin default passoword
# => Create readOnly
# => Create createOnly

require "#{Rails.root}/lib/BaseXClient"

# Change default admin password
begin
  session = BaseXClient::Session.new("xmldb", 1984, "admin", "admin")
  session.execute("create db xmldb")
  q = session.query("user:password('admin', '0a2ddd15e49ee40470fe5765cf831e19ea03ff7a')")
  q.execute()
  session.close
rescue
end

queryList =[
  "user:create('readOnly', 'cde452a35ef0323cc30fbdfd47538ecb3003f772', 'read', '*')",
  "user:create('createOnly', '1a85637cd2ba8c936306c0fa2438b9fcf23dcfa1', 'create', '*')"
]

for qStr in queryList
  # create session
  session = BaseXClient::Session.new("xmldb", 1984, "admin", "0a2ddd15e49ee40470fe5765cf831e19ea03ff7a")
  begin
    # Create new user
    q = session.query(qStr)
    q.execute()
    q.close()
    # close session
    session.close
  rescue Exception => e
    # log exception
    logger.error(e)
  end
end
