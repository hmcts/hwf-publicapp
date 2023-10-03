Feature: Marital status page

  Background: Navigating to the marital status page
    Given probate is enabled
    And I am on the marital status page

  Scenario: Selecting single
    When I submit the form as single
    Then I should be taken to savings and investments page

  Scenario: Selecting married
    When I submit the form as married
    Then I should be taken to savings and investments page

  Scenario: Help with status
    When I click on 'Help with status'
    Then I should see help with status copy

  Scenario: Error message when trying to move on without selecting option
    When I click continue
    Then I should see 'Select whether you're single, married or living with someone and sharing an income' error message

  Scenario: Marital status page timeout (Single option)
    When I slowly submit the form as single
    Then I should see the home page

  Scenario: Marital status page timeout (Partner option)
    When I slowly submit the form as married or living with someone and sharing an income
    Then I should see the home page
