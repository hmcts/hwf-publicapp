Feature: Savings and investment extra page

  Background: Apply UCD changes
    And the ucd changes apply

  Scenario: Selecting yes to are you 66 years old or over?
    And I am single with between £4,250 and £15,999 in savings
    When I submit yes I am 66 years old or over
    Then I should be taken to benefits page
    And the ucd changes end

  Scenario: Entering a valid amount of savings that's within range
    And I am single with between £4,250 and £15,999 in savings
    When I submit no to are you 66 years old or over
    And I enter £5000 as my savings and investments ucd
    And I click continue
    Then I should be taken to benefits page
    And the ucd changes end

  Scenario: Displays out of the range error message
    And I am married with between £4,250 and £15,999 in savings
    When I submit no to are you 66 years old or over
    And I enter £1600 as our savings and investments ucd
    And I click continue
    Then I should see enter amount between error message ucd
    And the ucd changes end

  Scenario: Displays how much error message when left blank
    And I am single with between £4,250 and £15,999 in savings
    When I submit no to are you 66 years old or over
    And I click continue
    Then I should see enter how much you have in savings and investments error message
    And the ucd changes end

  Scenario: Savings and investments extra page timeout (over 66 option)
    And I am single with between £4,250 and £15,999 in savings
    When I slowly submit yes I am 66 years old or over
    Then I should see the home page
    And the ucd changes end

  Scenario: Savings and investments extra page timeout (not over 66 option)
    And I am single with between £4,250 and £15,999 in savings
    When I slowly submit no I am not 66 years old or over
    Then I should see the home page
    And the ucd changes end