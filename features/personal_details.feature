Feature: Personal details page

  Background: Navigating to the personal details page
    Given probate is enabled
    And I am on the personal details page with probate enabled
  
  Scenario: Displays header
    Then I should see 'What is your full name?' header

  Scenario: Entering personal details
    When I enter my title
    And I enter my first name
    And I enter my last name
    Then I should be taken to address page

  Scenario: Entering a full name without a title
    When I enter my first name
    And I enter my last name
    Then I should be taken to address page

  Scenario: Displays enter your first name error message
    When I enter my last name
    And I click continue
    Then I should see 'Enter your first name' error message

  Scenario: Displays enter your last name error message
    When I enter my first name
    And I click continue
    Then I should see 'Enter your last name' error message
    Then the page should be axe clean
