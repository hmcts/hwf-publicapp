Feature: Checklist page

  Background: Navigating to the checklist page
    Given probate is enabled
    And I am on the checklist page
 
  Scenario: National insurance number or home office number
    Then I see that I need my national insurance number or home office number
    And if I do not have a national insurance or home office number then I can use the paper form

  Scenario: If you do not know your national insurance number
    When I click on if you do not know your national insurance number
    Then I should see where I can find my national insurance number
    And a link to receive a reminder in the post

  Scenario: If you do not know your home office number
    When I click on if you do not know your home office number
    Then I should see where I can find my home office number

  Scenario: Court and tribunal form number
    Then I see that I need to make sure that I have the court or tribunal form number

  Scenario: Case number, claim number or notice to pay
    Then I see that I need to make sure that I have the case number, claim number or notice to pay

  Scenario: Continue
    When I continue
    Then I should be taken to form number page

  Scenario: Footer content
    Then I should see a list of seven links
    Then the page should be axe clean
