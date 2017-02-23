Given(/^I have chosen to register$/) do
  visit '/'
  click_on 'Register'
end

When(/^I enter valid details$/) do
  fill_in 'Email', with: 'testuser2@test.com'
  fill_in 'Password', with: 'password'
  fill_in 'Password confirmation', with: 'password'
end

When(/^I enter an email address that has already registered$/) do
  User.create!(email: 'testuser@test.com', password: 'password', password_confirmation: 'password')
  fill_in 'Email', with: 'testuser@test.com'
  fill_in 'Password', with: 'fortesting'
  fill_in 'Password confirmation', with: 'fortesting'
end

Then(/^I should see the option to recovery my password$/) do
  page.has_content? 'Forgot your password?'
end

Then(/^I should be on the registration page$/) do
  assert_equal "/sign_up", path
end

When(/^I enter an invalid email address$/) do
  fill_in 'Email', with: 'testuser@test'
end

When(/^I enter valid email address$/) do
  fill_in 'Email', with: 'testuser@test.com'
end

When(/^I enter different password confirmation$/) do
  fill_in 'Password confirmation', with: 'fortesting2'
end

When(/^I enter short password with less than (\d+) characters$/) do |arg1|
  fill_in 'Password', with: 'forte'
end

When(/^I enter short password confirmation with less than (\d+) characters$/) do |arg1|
  fill_in 'Password', with: 'forte'
end

When(/^I click on "([^"]*)"$/) do |arg1|
  click_on arg1
end