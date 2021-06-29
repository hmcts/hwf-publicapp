Feature: Income range page

  Scenario: Income list
    Given probate is enabled
    When I am a single person with no children on income range page
    Then I should see the income list on step nine page:
      | income name                                               |
      | Wages before tax and National Insurance are taken off     |
      | Working Tax Credit                                        |

  Scenario: Income range for single with no children
    Given probate is enabled
    And I am a single person with no children on income range page
    Then I should see low income range 'Less than £1,085'
    And I should see medium income range 'Between £1,085 and £5,085'
    And I should see high income range 'More than £5,085'

  Scenario: Income range for married with three children
    Given probate is enabled
    And I am a married person with three children on income range page
    Then I should see low income range 'Less than £1,980'
    And I should see medium income range 'Between £1,980 and £5,980'
    And I should see high income range 'More than £5,980'

  Scenario: Income range for single with three children
    Given probate is enabled
    And I am a single person with three children on income range page
    Then I should see low income range 'Less than £1,820'
    And I should see medium income range 'Between £1,820 and £5,820'
    And I should see high income range 'More than £5,820'

  Scenario: Selecting the less than range - probate enabled
    Given probate is enabled
    And I am a single person with no children on income range page
    When I submit less than
    Then I should be taken to the probate page

  Scenario: Selecting the less than range - probate disabled
    Given probate is disabled
    And I am a single person with no children on income range page
    When I submit less than
    Then I should be taken to the claim page

  Scenario: Selecting the between range
    Given probate is enabled
    And I am a single person with no children on income range page
    When I submit between
    Then I should be taken to income amount page

  Scenario: Selecting the more than range - probate enabled
    Given probate is enabled
    And I am a single person with no children on income range page
    When I submit more than
    Then I should be taken to the probate page

  Scenario: Selecting the more than range - probate disabled
    Given probate is disabled
    Given I am a single person with no children on income range page
    When I submit more than
    Then I should be taken to the claim page

  Scenario: Displays error message
    Given probate is enabled
    And I am a single person with no children on income range page
    When I click continue
    Then I should see select your monthly income error message
    Then the page should be axe clean
