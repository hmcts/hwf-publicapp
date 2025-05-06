Feature: Home page
  Background: Navigate to home page
    Given I open the home page

  Scenario: I want to learn if I can apply for "Help with fees"
    Then I should see the home page
    
  Scenario: Court or tribunal fee link
    Then I should see the court and tribunal fees link

  Scenario: adjournment fees for certain civil and family hearings link
    When I click the 'adjournment fees for certain civil and family hearings' link
    Then I should see 'What to expect coming to a court or tribunal' header

  Scenario: in Welsh (Cymraeg)
    When I click the 'in Welsh (Cymraeg)' link
    Then I should see 'Help i dalu ffioedd llysoedd a thribiwnlysoedd' header

  Scenario: Check if you're eligible link
    When I click the 'Check if you're eligible' link
    Then I should see 'Apply for help with court and tribunal fees: Form EX160' header

  Scenario: Fill in a paper form link
    When I click the 'Fill in a paper form' link
    Then I should see 'Apply for help with court and tribunal fees: Form EX160' header
    
  Scenario: filling in a paper form link
    When I click the 'filling in a paper form' link
    Then I should see 'Apply for help with court and tribunal fees: Form EX160' header

  Scenario: Footer content
    Then I should see a list of seven links