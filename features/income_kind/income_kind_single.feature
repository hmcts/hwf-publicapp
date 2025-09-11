Feature: Income kind page

  Background: Navigating to the kind of income page as a single person
    When I am a single person on kind of income page

  Scenario: Displays income lists for a single person
    Then I should see an income list:
      | income name                                                                                  |
      | Wages before tax and National Insurance are taken off                                        |
      | Net profits from self employment                                                              |
      | Child Benefit                                                                                 |
      | Working Tax Credit                                                                           |
      | Child Tax Credit                                                                             |
      | Maintenance payments                                                                         |
      | Contribution-based Jobseekers Allowance (JSA)                                                |
      | Contribution-based Employment and Support Allowance (ESA)                                    |
      | Universal Credit                                                                             |
      | Pensions (state, work, private, pension credit (savings credit))                             |
      | Rent from anyone living with you                                                             |
      | Rent from other properties you own                                                           |
      | Cash gifts\nInclude all one off payments                                                     |
      | Financial support from others\nInclude all one off payments                                  |
      | Loans                                                                                        |
      | Other income\nFor example, income from online selling or from dividends or interest payments |
      | None of the above                                                                            |

  Scenario: No income
    When I submit the form with none of the above checked
    Then I should be taken to income period page
    When I submit the form with income '1000' and monthly
    Then I should be taken to the probate page

  Scenario: Submit the page with wages
    When I submit the form with wages checked
    Then I should be taken to income period page

  Scenario: Displays error message
    When I click continue
    Then I should see select your kinds of income error message

  Scenario: Displays child benefit error message
    When I submit the form with child benefit checked
    Then I should be taken to income period page
    When I select no children as a single person
    And I submit the form with child benefit checked
    Then I should see the no child selected error message

  Scenario: Income kind page timeout (single wages option)
    And I slowly submit the form with wages checked
    Then I should see the home page