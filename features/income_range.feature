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
    Then I should see low income range 'Less than £1,170'
    And I should see medium income range 'Between £1,170 and £5,170'
    And I should see high income range 'More than £5,170'

  Scenario: Income range for married with three children
    Given probate is enabled
    And I am a married person with three children on income range page
    Then I should see low income range 'Less than £2,140'
    And I should see medium income range 'Between £2,140 and £6,140'
    And I should see high income range 'More than £6,140'

  Scenario: Income range for single with three children
    Given probate is enabled
    And I am a single person with three children on income range page
    Then I should see low income range 'Less than £1,965'
    And I should see medium income range 'Between £1,965 and £5,965'
    And I should see high income range 'More than £5,965'

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

  Scenario: Income range page timeout
    Given probate is enabled
    And I am a single person with no children on income range page
    When I slowly submit less than
    Then I should see the home page