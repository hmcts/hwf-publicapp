@hwf_submit_application

Feature: Online confirmation page

  Background: Navigating to the confirmation page
    Given I am on the online confirmation page with probate enabled

  Scenario: Displays instructions
    Then I should see online instruction points
    And I should see online next steps

  Scenario: Save or print this page
    Then I should see save or print this page

  Scenario: Finish application
    When I click the finish application button
    Then I should be taken to the survey page
