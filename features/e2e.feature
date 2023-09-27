Feature: End to end tests

  Background: Same start for each path
    Given I open the home page
    Then I should see the home page
    When I click the start button
    Then I am on the checklist page
    When I continue
    Then I am on the form number page

  Scenario: End to end path one (refund, married, £3,000 to £15,999 savings, no to 61, less than £5000 in savings, no benefits, 4 dependents, wages & working tax credit, mid income, no fee for probate, yes claim number, dob=34 years before today,  )
    When I submit the form with a help with fees form number 'XX10'
    Then I should be taken to fee page
    When I select yes to have you already paid the fee
    And I submit the form with a date that is within the last three months
    Then I should be taken to national insurance presence page
    When I have a national insurance number
    Then I should be taken to national insurance page
    When I submit a valid national insurance number
    Then I should be taken to marital status page
    When I submit the form as married
    Then I should be taken to savings and investments page
    When I submit the form with £3,000 to £15,999 checked
    Then I should be taken to savings and investment extra page
    When I submit no to are you 61 years old or over
    And I enter £5000 as our savings and investments
    And I click continue
    Then I should be taken to benefits page
    When I submit the form with no I do not receive one of the benefits listed
    Then I should be taken to dependent page
    When I select yes to do you have any children
    And I submit the form with four children
    Then I should be taken to kind of income page
    When I submit the married form with wages and working tax credit checked
    Then I should be taken to income range page
    And I should see low income range 'Less than £2,405'
    And I should see medium income range 'Between £2,405 and £6,405'
    And I should see high income range 'More than £6,405'
    When I submit between
    Then I should be taken to income amount page
    When I submit the form with my monthly income of £'5000'
    Then I should be taken to the probate page
    When I select no to are you paying a fee for a probate case
    Then I should be taken to the claim page
    When I select yes to do you have a case, claim or notice to pay number
    And I enter a case, claim or notice to pay number
    Then I should be taken to date of birth page
    When I enter a valid date of birth
    Then I should be taken to personal details page
    When I enter my title
    And I enter my first name
    And I enter my last name
    Then I should be taken to address page
    When I enter my address with postcode
    Then I should be taken to contact page
    When I enter a valid email address
    Then I should be taken to summary page

#  Scenario: End to end path two (non refund, single, £0 to £2,999 savings, yes to 61, benefits, no dependents)
#    When I submit the form with I don’t have a form checked
#    Then I should be taken to fee page
#    When I submit no to have you already paid the fee
    # pause
