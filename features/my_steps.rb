require 'capybara-screenshot/cucumber'

Given /^there is an active mission "(.*?)"$/ do |title|
	FactoryGirl.create(:mission, :title => title)
end

Given /^I am on the homepage$/ do
  visit '/?mobile=0'
end

Given /^I am on the homepage as mobile$/ do
  visit '/?mobile=1'
end

When /^I follow "(.*?)"$/ do |link|
	click_link(link)
end

When /^I click "(.*?)"$/ do |text|
  click_button(text)
end

When /^I submit a log message "(.*?)"$/ do |msg|
	fill_in('newMsg', :with => msg)
	click_button('saveLogButton')
end

Then /^the page should show a log message "(.*?)"$/ do |text|
	page.find('#logTable').should have_content(text)
end

Then /^the page should report an invalid log message\.$/ do
  page.should have_content("can't be blank")
end

When /^I take a screenshot$/ do
	screenshot_and_save_page
end

When /^I fill out the new mission form with title "(.*?)"$/ do |title|
  fill_in('createTitle', :with => title)
  if (has_button?('Start')) then
    click_button('Start')
  else
    within('div#createPage') do 
      click_link('Start')
    end
  end
end

Then /^the page should show a mission called "(.*?)"$/ do |title|
  page.should have_content(title)
end
