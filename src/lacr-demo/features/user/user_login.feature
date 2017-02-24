Feature: User Log in
	In order to log in
	As a valid user
	I need to fill in log in form and submit.

Background:
	Given I am on the home page
	

Scenario: Successful login
  
	Where someone tries to login with valid credentials
  
	Given I have chosen to log in
	When I enter my email And password
	And I click on "Sign in"
	Then I should be told that I have successfully logged in
	And I should be on the home page again
	
	
Scenario: Wrong password
  
	Where someone tries to login with incorrect password
  
	Given I have chosen to log in
	When I enter my email But wrong password
	And I click on "Sign in"
	Then I should be told that the email or password are incorrect
	And I should be still on the login page
	

Scenario: Registration does not exist
  
	Where someone tries to login with email which is not registered
  
	Given I have chosen to log in
	When I enter an email which is not registered yet And password
	And I click on "Sign in"
	Then I should be told that the account does not exist
	And I should be on the sign in page