Feature: National insurance page

  Background: Navigating to the national insurance page
    Given probate is enabled
    And I am on the national insurance page

  Scenario: Entering a valid national insurance number
    When I submit a valid national insurance number
    Then I should be taken to marital status page

  Scenario: Displays error message enter a valid national insurance number
    When I submit an invalid national insurance number
    Then I should see enter a valid National Insurance number error message

  Scenario: Displays error message enter your national insurance number
    When I click continue
    Then I should see enter your national insurance number error message
    Then the page should be axe clean
