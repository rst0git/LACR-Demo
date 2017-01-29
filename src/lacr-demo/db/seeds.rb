# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

@user = User.new(:first_name => "test", 
					:last_name => "test", 
					:nick_name => "test_nick", 
					:password => "testtest", 
					:email_address => "test@test.com")
@user.save

@admin = User.new(:first_name  => "admin", 
					:last_name => "root", 
					:nick_name => "admin_nick", 
					:password => "adminadmin", 
					:email_address => "admin@test.com", 
					:rights => 100)
@admin.save