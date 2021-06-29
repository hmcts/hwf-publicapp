@hwf_submit_application

Feature: Confirmation page

  Background: Navigating to the confirmation page
    Given I am on the confirmation page with probate enabled

  Scenario: Displays instructions
    Then I should see instruction points

  Scenario: Save or print this page
    Then I should see save or print this page

  Scenario: Finish application
    When I click continue
    Then I should be taken to the confirmation done page
    Then the page should be axe clean
