Feature: Date of birth page

  Background: Navigating to the date of birth page
    Given probate is enabled
    And I am on the date of birth page

  Scenario: Entering a valid date of birth
    When I enter a valid date of birth
    Then I should be taken to personal details page

  Scenario: Displays you must be over 15 to use this service error message
    When I enter a date of less than fifteen years
    Then I should see you must be over 15 to use this service error message

  Scenario: Displays check this date of birth is correct error message
    When I enter a invalid date of birth
    Then I should see check this date of birth is correct error message

  Scenario: Displays error message enter the date in this format
    When I click continue
    Then I should see enter the date of birth in this format error message
    Then the page should be axe clean
