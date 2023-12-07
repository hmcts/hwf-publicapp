Feature: End to end tests

  Background: Same start for each path
    Given address lookup is disabled
    And the ucd changes apply
    When I open the home page
    Then I should see the home page
    When I click the start button
    Then I am on the checklist page
    When I continue
    Then I am on the fee page ucd

  Scenario: Path not applying on behalf someone else
    When I should be taken to fee page
    When I submit no to have you already paid the fee
    Then I submit the form with a help with fees form number 'XX10'
    Then I should be on the application on behalf of someone else page
    When I answer No to on behalf question
    Then I should be taken to national insurance presence page
    When I have a national insurance number

  Scenario: Path applying on behalf someone else over 16
    When I should be taken to fee page
    When I submit no to have you already paid the fee
    Then I submit the form with a help with fees form number 'XX10'
    Then I should be on the application on behalf of someone else page
    When I answer Yes to on behalf question
    Then I should be on are you legal representative page
    When I anwser legal representative
    Then I should be on legal representative detail page
    When I fill in all mandatory fields for legal representative
    Then I should be on are you applying for over 16 page
    When I anwser yes to over 16
    Then I should be taken to national insurance presence page
    When I have a national insurance number


  Scenario: Path applying on behalf someone else unde 16
    When I should be taken to fee page
    When I submit no to have you already paid the fee
    Then I submit the form with a help with fees form number 'XX10'
    Then I should be on the application on behalf of someone else page
    When I answer Yes to on behalf question
    Then I should be on are you legal representative page
    When I anwser legal representative
    Then I should be on legal representative detail page
    When I fill in all mandatory fields for legal representative
    Then I should be on are you applying for over 16 page
    When I anwser no to over 16
    Then I should be taken to savings and investments page

