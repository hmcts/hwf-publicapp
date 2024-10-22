Feature: Address page

  Background: Navigating to the address page
    Given I am 'single' and on the address page with probate enabled

  Scenario: Entering address with postcode
    When I enter my address with postcode
    Then I should be taken to contact page

  Scenario: Displays enter your postcode error message
    When I enter my address
    And I click continue
    Then I should see 'Enter your postcode' error message

  Scenario: Displays enter your address error message
    When I enter my postcode
    And I click continue
    Then I should see 'Enter your house number and street' error message

  Scenario: Displays error message when no address is entered
    And I click continue
    Then I should see 'Enter your house number and street' error message

  Scenario: Displays error message when invalid postcode is entered
    When I enter my address
    And I enter my postcode with special characters
    And I click continue
    Then I should see 'Must not contain special characters' error message

  Scenario: Address page timeout
    When I enter my address with postcode after a long time
    Then I should see the home page