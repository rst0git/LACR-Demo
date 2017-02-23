Feature: User registration
	In order to register on the web page
	As a new user
	I need to complete and send registration form

Background:
	Given I am on the home page

Scenario: Register new user
	Given I click on the register link on themain menu
	And enter "user2@test.co.uk" in the "Email" field
	And enter "password" in the "Password" field
	And enter "password" in the "Password Confirmation" field
	When I click on "Sign up"
	Then I should see homepage

