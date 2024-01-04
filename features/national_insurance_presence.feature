Feature: National insurance presence page

  Background: Navigating to the national insurance page
    Given probate is enabled
    And I am on the national insurance presence page

  Scenario: I have a national insurance number
    When I have a national insurance number
    Then I should be taken to national insurance page

  Scenario: I do not have a national insurance number
    When I do not have a national insurance number
    Then I should be taken to the home office page

  Scenario: Where to find my national insurance number
    When I click on 'Find a lost National Insurance number'
    Then I should see further information with a link to ask for a reminder

  Scenario: Displays error message when proceeding with blank national insurance number
    When I click continue
    Then I should see enter your national insurance number error message

  Scenario: National insurance presence page timeout (No option)
    When I slowly select that I do have a national insurance number
    Then I should see the home page
