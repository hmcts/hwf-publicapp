@hwf_submit_application

Feature: Online confirmation page

  Background: Navigating to the confirmation page
    Given I am 'married' and on the online confirmation page with probate enabled

  Scenario: Displays instructions
    Then I should see online instruction points
    And I should see online next steps

  Scenario: Save or print this page
    Then I should see save or print this page

  Scenario: Finish application without confirming
    When I click the finish application button
    Then I should see 'online' error

  Scenario: Finish application
    When I click the confirm checkbox
    And I click the finish application button
    Then I should be taken to the survey page

  Scenario: Finish page timeout
    When I slowly click the finish application button
    Then I should see the home page
