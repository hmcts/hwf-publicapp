Feature: Income kind page

  Background: Navigating to the kind of income page as a married person
    And I am a married person on kind of income page

  Scenario: Displays income lists for a couple
    Then I should see an income list for myself and my partner

  Scenario: No income - probate disabled
    When I submit the form with none of the above checked
    Then I should be taken to income period page
    When I submit the form with income '1000' and monthly
    Then I should be taken to the probate page

  Scenario: Submit the page with wages
    When I submit the form with wages checked
    Then I should be taken to income period page

  Scenario: Displays couple error message
    When I click continue
    Then I should see select your kinds of income error message

  Scenario: Income kind page timeout (married wages option)
    And I slowly submit the form with wages checked
    Then I should see the home page
