Feature: Income kind page UCD

  Background: apply the ucd changes
    And the ucd changes apply

  Scenario: Displays income lists for a couple
    And I am a married person on kind of income page ucd
    Then I should see an income list for myself and my partner for ucd
    And the ucd changes end

  Scenario: No income - probate disabled
    And I am a married person on kind of income page ucd
    When I submit the form with none of the above checked
    Then I should be taken to income period page
    When I submit the form with income '1000' and monthly
    Then I should be taken to the claim page
    And the ucd changes end

  Scenario: Submit the page with wages
    And I am a married person on kind of income page ucd
    When I submit the form with wages checked
    Then I should be taken to income period page
    And the ucd changes end

  Scenario: Displays couple error message
    And I am a married person on kind of income page ucd
    When I click continue
    Then I should see select your kinds of income error message
    And the ucd changes end

  Scenario: Income kind page timeout (married wages option)
    When I am a married person on kind of income page ucd
    And I slowly submit the form with wages checked
    Then I should see the home page
    And the ucd changes end