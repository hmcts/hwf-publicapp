Feature: Home page
  Background: Navigate to home page
    Given I open the home page

  Scenario: I want to learn if I can apply for "Help with fees"
    Then I should see the home page
    
  Scenario: Court or tribunal fee link
    Then I should see the court and tribunal fees link

  Scenario: adjournment fees for certain civil and family hearings link
    Then I should see the adjournment fees for certain civil and family hearings link

  Scenario: in Welsh (Cymraeg)
    Then I should see the welsh guide link

  Scenario: Check if you're eligible link
    Then I should see the eligible link

  Scenario: Fill in a paper form link
    Then I should see the paper form link
    
  Scenario: filling in a paper form link
    Then I should see the paper form link 2

  Scenario: Footer content
    Then I should see a list of seven links