Feature: Income kind page UCD

  Background: apply the ucd changes
    And the ucd changes apply

  Scenario: Displays income lists for a single person
    When I am a single person on kind of income page ucd
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
    And the ucd changes end

  Scenario: No income - probate disabled
    And I am a single person on kind of income page ucd
    When I submit the form with none of the above checked
    Then I should be taken to income period page
    When I submit the form with income '1000' and monthly
    Then I should be taken to the claim page
    And the ucd changes end

  Scenario: Submit the page with wages
    And I am a single person on kind of income page ucd
    When I submit the form with wages checked
    Then I should be taken to income period page
    And the ucd changes end

  Scenario: Displays error message
    And I am a single person on kind of income page ucd
    When I click continue
    Then I should see select your kinds of income error message
    And the ucd changes end

  Scenario: Income kind page timeout (single wages option)
    When I am a single person on kind of income page ucd
    And I slowly submit the form with wages checked
    Then I should see the home page
    And the ucd changes end