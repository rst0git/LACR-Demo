Feature: User account editing
	In order to edit my password or email
	As a valid user
	I need to click on edit account and change email 
	or password or both at the same time

Background:
	Given I am logged in
	

Scenario: Successful email edit
  
	Where someone tries to edit email address
  
	Given I have chosen to edit my email
	When I enter valid email which is not already registered
	And my current password
	And I click on "Edit"
	Then I should see successful edit message
	And I should be on the home page
	
	
Scenario: Duplicate email
  
	Where someone tries to edit email which is already registered
  
	Given I have chosen to edit my email
	When I enter valid email which is already registered
	And my current password
	And I click on "Edit"
	Then I should see error message that the email was already registered
	And I should be on the edit page
	
	
Scenario: Invalid email
  
	Where someone tries to edit email which is not valid
  
	Given I have chosen to edit my email
	When I enter invalid email
	And my current password
	And I click on "Edit"
	Then I should see error message that the email has invalid format
	And I should be on the edit page
	
	
Scenario: Successful password edit
  
	Where someone tries to edit the password
  
	Given I have chosen to edit my password
	When I enter valid password
	And I enter the same password confirmation
	And I enter my current password
	And I click on "Edit"
	Then I should see successful edit message
	And I should be on the home page
	
	
Scenario: Edit email but invalid current password
  
	Where someone tries to edit email but enters invalid current password
  
	Given I have chosen to edit my email
	When I enter valid email which is not already registered
	And my invalid current password
	And I click on "Edit"
	Then I should see error message that the password was incorrect
	And I should be on the edit page
	
	
Scenario: Edit password but invalid current password
  
	Where someone tries to edit the password but enters invalid current password
	
	Given I have chosen to edit my current password
	When I enter valid password
	And I enter the same password confirmation
	And I enter incorrect current password
	And I click on "Edit"
	Then I should see error message that my current password was incorrect
	And I should be on the edit page
	
	
Scenario: Pasword confirmation is different
  
	Where someone tries to edit the password but password confirmation is not the same
  
	Given I have chosen to edit my current password
	When I enter valid password
	And I enter the same password confirmation
	And I enter incorrect current password
	And I click on "Edit"
	Then I should see error message that the password confirmation and password were different
	And I should be on the edit page
	

Scenario: New password is too short
  
	Where someone tries to edit the password but it is too short
  
	Given I have chosen to edit my current password
	When I enter password with less than 6 characters
	And I enter the same password confirmation
	And I enter correct current password
	And I click on "Edit"
	Then I should see error message that the password is too short
	And I should be on the edit page