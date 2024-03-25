Feature: Probate page

  Background: Navigating to the probate page
    Given probate is enabled
    And I am on the page for Are you paying a fee for a probate case?

  Scenario: Selecting no to are you paying a fee for a probate case
    When I select no to are you paying a fee for a probate case
    Then I should be taken to the claim page

  Scenario: Selecting yes to are you paying a fee for a probate case
    When I select yes to are you paying a fee for a probate case
    And I enter the name of deceased
    And I enter a valid date of death
    Then I should be taken to the claim page
    
  Scenario: Partially selecting yes to are you paying a fee for a probate case
    When I select yes to are you paying a fee for a probate case
    And I click continue
    Then I should see 'Please enter the deceased's name' error message

  Scenario: Displays date can't be in the future error message
    When I enter a future date of death
    Then I should see this date can't be in the future error message

  Scenario: Displays invalid format error message
    When I enter a invalid date of death
    Then I should see enter the date in this format error message

  Scenario: Displays make a selection error message
    When I click continue
    Then I should see select whether you're paying a fee for a probate case error message

  Scenario: Probate page timeout (no option)
    When I slowly select no to are you paying a fee for a probate case
    Then I should see the home page

  Scenario: Probate page timeout (yes option)
    When I slowly select yes to are you paying a fee for a probate case
    Then I should see the home page