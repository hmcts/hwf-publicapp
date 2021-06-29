Feature: Savings and investment page

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

  Scenario: Help with savings and investments
    When I click on 'Help on what to include as savings and investments'
    Then I should see help with savings and investments copy
    Then the page should be axe clean
