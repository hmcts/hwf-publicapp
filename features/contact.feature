Feature: Contact page

  Background: Navigating to the contact page
    Given I am on the contact page with probate enabled

  Scenario: Entering a valid email address
    When I enter a valid email address
    Then I should be taken to apply type page

  Scenario: Entering a invalid email address
    When I enter an invalid email address
    And I click continue
    Then I remain on this page

  Scenario: Displays share your experience
    Then I click share experience checkbox

  Scenario: Continuing without supplying an email address
    When I click continue
    Then I should be taken to apply type page

  Scenario: Contact page timeout
    When I enter a valid email address after a long time
    Then I should see the home page
