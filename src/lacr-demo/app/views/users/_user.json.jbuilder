json.extract! user, :id, :first_name, :last_name, :nick_name, :email_address
json.url user_url(user, format: :json)