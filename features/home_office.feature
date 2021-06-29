Feature: Home office page

  Background: Home office page
    Given probate is enabled
    And I am on the home office page

  Scenario: Entering a valid home office number
    When I submit a valid home office number
    Then I should be taken to marital status page

  Scenario: Entering an invalid home office number
    When I submit an invalid home office number
    Then I should see enter a valid home office number error message
  
  Scenario: Home office number left blank
    When I click continue
    Then I should see enter your home office number error message

  Scenario: If I do not have either a national insurance number or home office number
    Then I should see what to do if I do not have either a national insurance number or home office number
    And there should be a link paper application form

  Scenario: Where to find my home office reference number
    When I click on 'Where to find my Home Office reference number?'
    Then I should see further information about where to find my home office number
    Then the page should be axe clean
