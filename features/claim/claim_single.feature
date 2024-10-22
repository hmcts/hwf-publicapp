Feature: Claim page

  Background: Navigating to the claim page
    Given probate is enabled
    And I am 'single' and on the claim page

  Scenario: Selecting no to do you have a case, claim or notice to pay number
    When I select no to do you have a case, claim or notice to pay number
    Then I should be taken to date of birth page

  Scenario: Entering a case, claim or notice to pay number
    When I select yes to do you have a case, claim or notice to pay number
    And I enter a case, claim or notice to pay number
    Then I should be taken to date of birth page

  Scenario: Help with case numbers
    When I click on 'Help with case number'
    Then I should see help with case number copy

  Scenario: Displays enter a number error message
    And I select yes to do you have a case, claim or notice to pay number
    When I click continue
    Then I should see enter a case, claim or ‘notice to pay’ number error message

  Scenario: Displays a case number length error message
    When I select yes to do you have a case, claim or notice to pay number
    And I enter a long case, claim or notice to pay number
    Then I should see 'The number must be less than 25 characters' error message

  Scenario: Displays make a selection error message
    When I click continue
    Then I should see select whether you have a case, claim or ‘notice to pay’ error message

  Scenario: Claim page timeout (yes option)
    When I select yes to do you have a case, claim or notice to pay number
    And I enter a case, claim or notice to pay number after a long time
    Then I should see the home page

  Scenario: Claim page timeout (no option)
    When I slowly select no to do you have a case, claim or notice to pay number
    Then I should see the home page