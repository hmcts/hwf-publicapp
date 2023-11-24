Feature: Marital status page

  Background: Navigating to the marital status page
    And the ucd changes apply
    And I am on the marital status page ucd

  Scenario: Selecting single
    When I submit the form as single
    Then I should be taken to savings and investments page
    And the ucd changes end

  Scenario: Selecting married
    When I submit the form as married
    And I should see partner NI page
    Then I should be taken to savings and investments page
    And the ucd changes end

  Scenario: Help with status
    When I click on 'Why are we asking for partner status?'
    Then I should see help with status copy ucd
    And the ucd changes end

  Scenario: Error message when trying to move on without selecting option
    When I click continue
    Then I should see 'Select whether you're single, married or living with someone and sharing an income' error message
    And the ucd changes end

  Scenario: Marital status page timeout (Single option)
    When I slowly submit the form as single
    Then I should see the home page
    And the ucd changes end

  Scenario: Marital status page timeout (Partner option)
    When I slowly submit the form as married or living with someone and sharing an income
    Then I should see the home page
    And the ucd changes end
