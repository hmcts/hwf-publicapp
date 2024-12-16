Feature: Applying on behalf page

  Background: Navigating to the applying on behalf page
    Given probate is enabled
    And I am on the apply on behalf page

  Scenario: Selecting Yes
    When I select yes to are you applying on behalf of someone

  Scenario: Selecting No
    When I select no to are you applying on behalf of someone

  Scenario: Path not applying on behalf someone else
    When I select no to are you applying on behalf of someone
    Then I should be taken to national insurance page

  Scenario: Path applying on behalf someone else over 16
    When I select yes to are you applying on behalf of someone
    Then I should be on are you legal representative page
    When I answer legal representative
    Then I should be on legal representative detail page
    When I click continue
    Then I should see 'Please enter first name' error message
    When I fill in all mandatory fields for legal representative
    Then I should be on are you applying for over 16 page
    When I click continue
    Then I should see 'Select whether the person you're applying for is over 16' error message
    When I answer yes to over 16
    Then I should be taken to national insurance page

  Scenario: Path applying on behalf someone else under 16
    When I select yes to are you applying on behalf of someone
    Then I should be on are you legal representative page
    When I answer legal representative
    Then I should be on legal representative detail page
    When I fill in all mandatory fields for legal representative
    Then I should be on are you applying for over 16 page
    When I answer no to over 16
    Then I should be taken to savings and investments page