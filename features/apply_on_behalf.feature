Feature: Applying on behalf page

  Background: Navigating to the applying on behalf page
    Given probate is enabled
    And I am on the apply on behalf page

  Scenario: Selecting Yes
    When I select yes to are you applying on behalf of someone

  Scenario: Selecting No
    When I select no to are you applying on behalf of someone