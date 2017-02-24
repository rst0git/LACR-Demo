Feature: User account cancelation
	In order to cancel my account
	As a registered and logged in user
	I need to click on cancel my account on edit page

Background:
	Given I am logged in as a valid user
	

Scenario: Successful cancelation
  
	Where someone decided to cancel the account
  
	Given I have chosen to cancel my account
	And I click on the "Edit account"
	When I click on "Cancel account"
	Then I should be asked if I am sure that I want to cancel my account
	When I click on "Yes"
	Then my account should be canceled 
	And I am notified that it is canceled
	And I should be on the home page
	

Scenario: Unfinished cancelation
  
	Where someone tries to cancel the account but then rethins it
	
	Given I have chosen to cancel my account
	And I click on the "Edit account"
	When I click on "Cancel account"
	Then I should be asked if I am sure that I want to cancel my account
	When I click on "No"
	Then my account should not be canceled
	And I should be on the edit account page