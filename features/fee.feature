Feature: Fee page

  Background: Navigating to the fee page
    Given probate is enabled
    And I am on the fee page

  Scenario: Neither selecting yes or no
    When I click continue
    Then I should see select whether you've already paid the fee error message

  Scenario: No I have not already paid the fee
    When I submit no to have you already paid the fee
    Then I should be taken to form number page

  Scenario: Selecting yes but not providing a date
    When I select yes to have you already paid the fee
    And I click continue
    Then I should see enter the fee date in this format error message

  Scenario: Date within the last 3 months
    When I select yes to have you already paid the fee
    And I submit the form with a date that is within the last three months
    Then I should be taken to form number page

  Scenario: Date exceeding 3 months
    When I select yes to have you already paid the fee
    And I submit the form with a date that exceeds three months
    Then I should see the date the fee was paid must have been within the last three months error message

  Scenario: Date is in the future
    When I select yes to have you already paid the fee
    And I submit the form with a future date
    Then I should see this date can't be in the future error message

  Scenario: Invalid date form
    When I select yes to have you already paid the fee
    And I submit the form with an invalid date
    Then I should be taken to fee page

  Scenario: Fee page timeout (Yes option)
    When I select yes to have you already paid the fee
    And I slowly submit the form with a date that is within the last three months
    Then I should see the home page

  Scenario: Fee page timeout (No option)
    When I slowly submit no to have you already paid the fee
    Then I should see the home page