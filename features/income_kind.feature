Feature: Income kind page

  Scenario: Displays income lists for a single person
    Given probate is enabled
    When I am a single person on kind of income page
    Then I should see an income list:
      | income name                                               |
      | Wages                                                     |
      | Child Benefit                                             |
      | Working Tax Credit                                        |
      | Child Tax Credit                                          |
      | Maintenance payments                                      |
      | Contribution-based Jobseekers Allowance (JSA)             |
      | Contribution-based Employment and Support Allowance (ESA) |
      | Universal Credit                                          |
      | Pensions (state, work, private)                           |
      | Rent from anyone living with you                          |
      | Rent from other properties you own                        |
      | Other income                                      |
      | No income                                                 |

  Scenario: Displays income lists for a couple
    Given probate is enabled
    And I am a married person on kind of income page
    Then I should see an income list for myself and my partner

  Scenario: No income - probate enabled
    Given probate is enabled
    And I am a single person on kind of income page
    When I submit the form with no income checked
    Then I should be taken to the probate page

  Scenario: No income - probate disabled
    Given probate is disabled
    And I am a single person on kind of income page
    When I submit the form with no income checked
    Then I should be taken to the claim page

  Scenario: Submit the page with wages
    Given probate is disabled
    And I am a single person on kind of income page
    When I submit the form with wages checked
    Then I should be taken to income range page

  Scenario: Displays error message
    Given probate is enabled
    And I am a single person on kind of income page
    When I click continue
    Then I should see select your kinds of income error message
    Then the page should be axe clean
