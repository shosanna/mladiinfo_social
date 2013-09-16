Feature: signup

Scenario: User wants to sign up
  Given there are no users in the database
  And I am on the sign up page
  When I fill in valid user information
  And I submit the form
  Then I should have an account
  And I should be signed in