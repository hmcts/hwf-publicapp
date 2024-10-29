@hwf_submit_application

Feature: Paper confirmation page

  Background: Navigating to the confirmation page
    Given I am 'single' and on the paper confirmation page with probate enabled

  Scenario: Displays instructions
    Then I should see instruction points
    And I should see next steps

  Scenario: Save or print this page
    Then I should see save or print this page

  Scenario: Finish application
    When I click the finish application button
    Then I should be taken to the survey page

  Scenario: Paper page timeout
    When I slowly click the finish application button
    Then I should see the home page
