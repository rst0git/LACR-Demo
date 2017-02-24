Feature: User registration
	In order to register on the web page
	As a new user
	I need to complete and send registration form

Background:
	Given I am on the home page
	

Scenario: Successful registration

	New user should be able to register easily.

	Given I have chosen to register
	When I enter valid details
	And I click on "Sign up"
	Then I should see greeting message
	

Scenario: Duplicate email

	Where someone tries to create an account for an email address 
	that already exists.

	Given I have chosen to register
	When I enter an email address that has already registered
	And I click on "Sign up" 
	Then I should be told that email is already registered
	And I should be offered the option to recovery my password
	

Scenario: Invalid email address

	Where someone tries to register with an invalid email address.

	Given I have chosen to register
	When I enter an invalid email address
	And I click on "Sign up"
	Then I should be told that email is invalid
	And I should be still on the registration page
	

Scenario: Password confirmation does not match

	Where someone tries to register with different password and password confirmation

	Given I have chosen to register
	When I enter an valid email address
	And valid password
	And password confirmation is not the same as password
	And I click on "Sign up"
	Then I should be told that password and password confirmation does not match
	And I should be still on the registration page
	

Scenario: Password is too short

	Where someone tries to register with short password

	Given I have chosen to register
	When I enter an valid email address
	And short password with less than 6 characters
	And I click on "Sign up"
	Then I should be told that password is too short
	And I should be still on the registration page