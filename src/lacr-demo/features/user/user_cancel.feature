Feature: User account cancelation
	In order to cancel my account
	As a registered and logged in user
	I need to click on cancel my account on edit page

Background:
	Given I am logged in as a valid user
	And I have chosen to cancel my account
	

Scenario: Successful cancelation

	Where someone decided to cancel the account

	When I am asked Are you sure?
	And I click on "OK"
	Then my account should be canceled
	And I am notified that it is canceled
	And I should be on the home page
	

Scenario: Unfinished cancelation

	Where someone tries to cancel the account but rethinks it
	
	When I am asked Are you sure?
	And I click on "Cancel"
	Then my account should not be canceled
	And I should be on the edit account page
