Feature: Date of birth page

  Scenario: Entering a valid date of birth
    Given probate is enabled
    And I am on the date of birth page
    When I enter a valid date of birth
    Then I should be taken to personal details page

  Scenario: Married and entering valid dates of birth
    Given I am married and on the date of birth page
    When I enter a valid dates of birth for myself and partner
    Then I should be taken to personal details page

  Scenario: Married, entering valid dates of birth and omitting partner dob
    Given I am married and on the date of birth page
    When I enter a valid date of birth
    Then I should see 'Enter the date in this format DD/MM/YYYY' error message

  Scenario: Displays you must be over 15 to use this service error message
    Given probate is enabled
    And I am on the date of birth page
    When I enter a date of less than fifteen years
    Then I should see you must be over 15 to use this service error message

  Scenario: Displays check this date of birth is correct error message
    Given probate is enabled
    And I am on the date of birth page
    When I enter an invalid date of birth
    Then I should see check this date of birth is correct error message

  Scenario: Displays error message enter the date in this format
    Given probate is enabled
    And I am on the date of birth page
    When I click continue
    Then I should see enter the date of birth in this format error message

  Scenario: DoB page timeout
    Given probate is enabled
    And I am on the date of birth page
    When I slowly enter a valid date of birth
    Then I should see the home page
