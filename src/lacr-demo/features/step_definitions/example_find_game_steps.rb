Given(/^I am on the Google homepage$/) do
  visit 'http://www.google.co.uk'
end

Then(/^I will search for "([^"]*)"$/) do |searchText|
  fill_in 'lst-ib', :with => searchText
  click_button('_fZl')
end

Then(/^I should see "([^"]*)"$/) do |expectedText|
  page.has_content?(expectedText)
end

Then(/^I will click the news link$/) do
  click_link('News')
end
