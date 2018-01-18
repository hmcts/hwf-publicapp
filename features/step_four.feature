@e2e

Feature: Step four page

  Scenario: Displays step number
    Given I am a single person on the step four page
    Then I should see step 4 of 20

  Scenario: Displays header
    Given I am a single person on the step four page
    Then I should see 'How much do you have in savings and investments?' header

  Scenario: Selecting £0 to £2,999
    Given I am a single person on the step four page
    When I submit the form with £0 to £2,999 checked
    Then I am taken to step 6 - Do you receive any of the following benefits?

  Scenario: Selecting £3,000 to £15,999
    Given I am a single person on the step four page
    When I submit the form with £3,000 to £15,999 checked
    Then I am taken to step 5 - Are you 61 years old or over?

  Scenario: Selecting £16,000 or more
    Given I am a single person on the step four page
    When I submit the form with £16,000 or more checked
    Then I am taken to step 6 - Do you receive any of the following benefits?

  Scenario: Help with savings and investments
    Given I am a single person on the step four page
    When I click on 'Help with savings and investments'
    Then I should see help with savings and investments copy

  Scenario: Does not display reminder for single people
    Given I am a single person on the step four page
    Then I should not see the reminder to include my partners savings

  Scenario: Displays reminder for married people
    Given I am a married person on the step four page
    Then I should see the reminder to include my partners savings 
