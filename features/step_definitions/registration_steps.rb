# coding: utf-8
Given(/^there are no (.+) in the database$/) do |model_name|
  model_name.classify.constantize.destroy_all
end

Given(/^I am on the sign up page$/) do
  visit signup_path
end

When(/^I fill in valid user information$/) do
  fill_in "Username",     with: "Example User"
  fill_in "Email",        with: "user@example.com"
  fill_in "Password",     with: "foobar"
  fill_in "Confirmation", with: "foobar"
end

When(/^I submit the form$/) do
  click_button "submit"
end

Then(/^I should have an account$/) do
  User.count.should == 1
end

Then(/^I should be signed in$/) do
  page.should have_link('Odhlásit se', href: signout_path)
end

