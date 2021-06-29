Feature: Income amount page

  Scenario: Submits married monthly income - probate enabled
    Given probate is enabled
    And I am a married person on income amount page
    When I submit the form with my monthly income
    Then I should be taken to the probate page

  Scenario: Submits single monthly income - probate disabled
    Given probate is disabled
    And I am a single person on income amount page
    When I submit the form with my monthly income
    Then I should be taken to the claim page

  Scenario: Income list
    Given probate is enabled
    When I am a married person on income amount page
    And I should see the income list on step ten page:
      | income name                                               |
      | Wages before tax and National Insurance are taken off     |
      | Working Tax Credit                                        |

  Scenario: Displays error message
    Given probate is enabled
    When I am a married person on income amount page
    When I click continue
    Then I should see enter how much income do you receive error message
    Then the page should be axe clean
