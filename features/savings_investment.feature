Feature: Savings and investment page refund

  Background: Navigating to the savings and investment page
    Given probate is enabled
    And I am a single person on the savings and investments page

  Scenario: Selecting £0 to £2,999
    When I submit the form with £0 to £2,999 checked
    Then I should be taken to benefits page

  Scenario: Selecting £3,000 to £15,999 
    When I submit the form with £3,000 to £15,999 checked
    Then I should be taken to savings and investment extra page

  Scenario: Selecting £16,000 or more
    When I submit the form with £16,000 or more checked
    Then I should be taken to benefits page

  Scenario: Error when continuing without selection amount
    When I click continue
    Then I should see 'Select how much you have in savings and investments' error message

  Scenario: Help with savings and investments
    When I click on 'What not to include in savings and investments'
    Then I should see include with savings and investments copy

  Scenario: Savings and investments page timeout (£16,000 or more option)
    When I slowly submit the form with £16,000 or more checked
    Then I should see the home page

  Scenario: Savings and investments page timeout (£3,000 to £15,999 or more option)
    When I slowly submit the form with £3,000 to £15,999 or more checked
    Then I should see the home page

  Scenario: Savings and investments page timeout (£0 to £2,999 or more option)
    When I slowly submit the form with £0 to £2,999 or more checked
    Then I should see the home page
