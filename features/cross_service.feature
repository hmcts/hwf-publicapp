@hwf_submit_application

Feature: Cross Service
  @cross-service
  Scenario: Finish application through staffapp
    Given I am on the confirmation page with probate enabled
    When I copy the reference number
    When I click continue
    And I click the finish application button
    When I launch staff app
    And I process the application