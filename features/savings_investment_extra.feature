Feature: Savings and investment extra page
  
  Scenario: Selecting yes to are you 66 years old or over?
    Given probate is enabled
    And I am single with £3,000 to £15,999 in savings
    When I submit yes I am 66 years old or over
    Then I should be taken to benefits page

  Scenario: Entering a valid amount of savings that's within range
    Given probate is enabled
    And I am single with £3,000 to £15,999 in savings
    When I submit no to are you 66 years old or over
    And I enter £5000 as my savings and investments
    And I click continue
    Then I should be taken to benefits page

  Scenario: Displays out of the range error message
    Given probate is enabled
    And I am married with £3,000 to £15,999 in savings
    When I submit no to are you 66 years old or over
    And I enter £1600 as our savings and investments
    And I click continue
    Then I should see enter amount between error message

  Scenario: Displays how much error message when left blank
    Given probate is enabled
    And I am single with £3,000 to £15,999 in savings
    When I submit no to are you 66 years old or over
    And I click continue
    Then I should see enter how much you have in savings and investments error message

  Scenario: Savings and investments extra page timeout (over 66 option)
    Given probate is enabled
    And I am single with £3,000 to £15,999 in savings
    When I slowly submit yes I am 66 years old or over
    Then I should see the home page

  Scenario: Savings and investments extra page timeout (not over 66 option)
    Given probate is enabled
    And I am single with £3,000 to £15,999 in savings
    When I slowly submit no I am not 66 years old or over
    Then I should see the home page