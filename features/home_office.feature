@e2e

Feature: Home office page

  Background: Home office page
    Given probate is enabled
    And I am on the home office page

  Scenario: Entering a valid home office number
    When I submit a valid home office number
    Then I should be taken to date of birth page

  Scenario: If I do not have either a national insurance number or home office number
    Then I should see what to do if I do not have either a national insurance number or home office number
    And there should be a link paper application form

  Scenario: Where to find my home office reference number
    When I click on 'Where to find my Home Office reference number?'
    Then I should see further information about where to find my home office number

  Scenario: Displays error message enter your home office number
    When I click continue
    Then I should see enter your home office number error message
