Feature: Dependent page

  Background: Navigating to the dependent page
    Given probate is enabled
    And I am on the dependent page

  Scenario: Yes to do you have any children
    When I select yes to do you have any children
    And I submit the form with four children
    Then I should be taken to kind of income page

  Scenario: No to do you have any children
    When I submit the form with no I do not have any children
    Then I should be taken to kind of income page

  Scenario: Displays error message
    When I click continue
    Then I should see you need to say whether you have financially dependent children error message

  Scenario: Help with benefits
    When I click on 'Help with financially dependent children'
    Then I should see help with financially dependent children copy
    Then the page should be axe clean
