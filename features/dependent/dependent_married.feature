Feature: Dependent page

  Background: Navigating to the dependent page
    Given probate is enabled
    And I am 'married' and on the dependent page

  Scenario: Yes to do you have any children
    And I submit the form with four children
    Then I should be taken to kind of income page

  Scenario: No to do you have any children
    When I submit the form with no I do not have any children
    Then I should be taken to kind of income page

  Scenario: Help with benefits
    Then I should see help with financially dependent children copy

  Scenario: Displays child number error
    When I click continue
    Then I should see select child number error message

  Scenario: Displays child range error
    When I submit the form with 1 child
    Then I should see select child range error message

  Scenario: Dependent page timeout (No option)
    When I submit the form with no I do not have any children after a long time
    Then I should see the home page

  Scenario: Dependent page timeout (Yes option)
    When I submit the form with yes I do have children after a long time
    Then I should see the home page