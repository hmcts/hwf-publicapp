Feature: End to end tests

  Background: Same start for each path
    Given I open the home page
    Then I should see the home page
    When I click the start button
    Then I am on the checklist page
    When I continue
    Then I am on the form number page

@smoke
  Scenario: End to end path one
    When I submit the form with a help with fees form number 'XX10'
    Then I should be taken to fee page
    When I submit no to have you already paid the fee
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
    When I enter a date of birth "27/09/1989"
    Then I should be taken to personal details page
    When I enter my title
    And I enter my first name
    And I enter my last name
    Then I should be taken to address page
    When I enter my address with postcode
    Then I should be taken to contact page
    When I enter a valid email address
    Then I should be taken to apply type page
    When I select I will be completing via online service
    Then I should be taken to summary page
    And I should see my details:
      | scope                                                                     |
      | Form name or number XX10 Change form name or number                       |
      | Fee paid No Change fee paid                                               |
      | National Insurance number JL806367D Change national insurance number      |
      | Status Married or living with someone and sharing an income Change status |
      | Savings and investments £5,000 Change savings and investments             |
      | Benefits Not receiving eligible benefits Change benefits                  |
      | Children 4 Change children                                                |
      | Income £5,000 Change income                                               |
      | Income type Your income type Change income type                           |
      | Probate case No Change probate case                                       |
      | Claim number Yes Change claim number                                      |
      | Date of birth 27/09/1989 Change date of birth                             |
      | Full name Ms Sally Smith Change full name                                 |
      | Address 102 Petty France London SW1H 9AJ Change address                   |
      | Email test@hmcts.net Change email                                         |

@smoke
  Scenario: End to end path two
    When I submit the form with I don’t have a form checked
    Then I should be taken to fee page
    When I submit no to have you already paid the fee
    Then I should be taken to national insurance presence page
    When I do not have a national insurance number
    Then I should be taken to the home office page
    When I submit a valid home office number
    Then I should be taken to marital status page
    When I submit the form as single
    Then I should be taken to savings and investments page
    When I submit the form with £0 to £2,999 checked
    Then I should be taken to dependent page
    When I submit the form with no I do not have any children
    Then I should be taken to kind of income page
    When I submit the form with wages checked
    Then I should be taken to income range page
    And I should see low income range 'Less than £1,170'
    And I should see medium income range 'Between £1,170 and £5,170'
    And I should see high income range 'More than £5,170'
    When I submit less than
    Then I should be taken to the probate page
    When I select yes to are you paying a fee for a probate case
    And I enter the name of deceased
    And I enter a date of death "10/01/2023"
    Then I should be taken to the claim page
    When I select no to do you have a case, claim or notice to pay number
    Then I should be taken to date of birth page
    When I enter a date of birth "27/09/1950"
    Then I should be taken to personal details page
    When I enter my title
    And I enter my first name
    And I enter my last name
    Then I should be taken to address page
    When I enter my address with postcode
    Then I should be taken to contact page
    When I enter a valid email address
    Then I should be taken to apply type page
    When I select I will be completing via online service
    Then I should be taken to summary page
    And I should see my details:
      | scope                                                                                   |
      | Form name or number — Change form name or number                                        |
      | Fee paid No Change fee paid                                                             |
      | National Insurance number No Change national insurance number                           |
      | Home Office reference number 1212-0001-0240-0490/01 Change home office reference number |
      | Status Single Change status                                                             |
      | Savings and investments £0 to £2,999 Change savings and investments                     |
      | Children No Change children                                                             |
      | Income Less than £1,170 Change income                                                   |
      | Income type Your income type Change income type                                         |
      | Name of deceased John Smith Change name of deceased                                     |
      | Date of death 10/01/2023 Change date of death                                           |
      | Claim number No Change claim number                                                     |
      | Date of birth 27/09/1950 Change date of birth                                           |
      | Full name Ms Sally Smith Change full name                                               |
      | Address 102 Petty France London SW1H 9AJ Change address                                 |
      | Email test@hmcts.net Change email                                                       |