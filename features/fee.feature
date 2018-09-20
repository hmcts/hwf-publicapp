@e2e

Feature: Fee page

  Background: Fee page
    Given I am on the page for step two - Have you already paid the fee?

  Scenario: Neither selecting yes or no
    When I click continue
    Then I should see select whether you've already paid the fee error message

  Scenario: Selecting no to have you already paid the fee?
    When I select no to have you already paid the fee?
    And I click continue
    Then I am taken to step 3 - Are you single, married or living with someone and sharing an income?

  Scenario: Selecting yes but not providing a date
    When I select yes to have you already paid the fee?
    And I click continue
    Then I should see enter the date in this format error message

  Scenario: Date within the last 3 months
    When I select yes to have you already paid the fee?
    And I submit the form with a date thats within the last three months
    Then I am taken to step 3 - Are you single, married or living with someone and sharing an income?

  Scenario: Date exceeding 3 months
    When I select yes to have you already paid the fee?
    And I submit the form with a date that exceeds three months
    Then I should see the application must have been made in the last 3 months error message

  Scenario: Date is in the future
    When I select yes to have you already paid the fee?
    And I submit the form with a future date
    Then I should see this date can't be in the future error message