Feature: Personal details page

  Background: Navigating to the personal details page
    Given probate is enabled
    And I am married and on the personal details page with probate enabled

  Scenario: Displays header
    Then I should see 'What are the full names of both you and your partner?' header

  Scenario: Entering personal details
    And I enter mine and my partner's names
    Then I should be taken to address page

  Scenario: Displays enter your first name error message
    When I enter my last name
    And I click continue
    Then I should see 'Enter your first name' error message

  Scenario: Displays enter your last name error message
    When I enter my first name
    And I click continue
    Then I should see 'Enter your last name' error message

  Scenario: Displays 'Must not contain special characters' error message for first name
    When I enter my first name with special characters
    And I enter my last name
    And I click continue
    Then I should see 'Must not contain special characters' error message

  Scenario: Displays 'Must not contain special characters' error message for last name
    When I enter my last name with special characters
    And I enter my first name
    And I click continue
    Then I should see 'Must not contain special characters' error message

  Scenario: Name entry timeout
    When I slowly enter my name
    Then I should see the home page
