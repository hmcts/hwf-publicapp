Feature: End to end tests

  Background: Same start for each path
    Given address lookup is disabled
    When I open the home page
    Then I should see the home page
    When I click the start button
    Then I am on the checklist page
    When I continue
    Then I am on the fee page

  Scenario: End to end path one - married
    When I should be taken to fee page
    When I submit no to have you already paid the fee
    Then I submit the form with a help with fees form number 'XX10'
    Then I should be taken to apply on behalf page
    When I select no to are you applying on behalf of someone
    Then I should be taken to national insurance page
    When I submit a valid national insurance number
    Then I should be taken to marital status page
    When I submit the form as married
    Then I should be taken to partner national insurance page
    When I select my partner does not have a national insurance number
    Then I should be taken to savings and investments page
    When I submit the form with between £4,250 and £15,999 checked
    Then I should be taken to savings and investment extra page
    When I submit no to are you 66 years old or over
    And I enter £5000 as our savings and investments
    And I click continue
    Then I should be taken to benefits page
    When I submit the form with no I do not receive one of the benefits listed
    Then I should be taken to dependent page
    When I select yes to do you have any children
    And I submit the form with four children
    Then I should be taken to kind of income page
    When I submit the married form with wages and working tax credit checked
    Then I should be taken to income period page
    When I submit the form with income '5000' and monthly
    Then I should be taken to the probate page
    When I select no to are you paying a fee for a probate case
    Then I should be taken to the claim page
    When I select yes to do you have a case, claim or notice to pay number
    And I enter a case, claim or notice to pay number
    Then I should be taken to date of birth page
    And I enter a valid date of birth for me and my partner
    Then I should be taken to personal details page
    When I enter mine and my partner's names
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
      | Children 4 (aged 0-13) 0 (aged 14 and over) Change children               |
      | Total income £5,000 Last calendar month Change income                         |
      | Income type Your income type Change income type                           |
      | Probate case No Change probate case                                       |
      | Claim number 012345678 Change claim number                                |
      | Date of birth 28/11/1992 Change date of birth                             |
      | Partner's date of birth 28/11/1992 Change partner's date of birth         |
      | Full name Thomas Test Change full name                                    |
      | Partner’s full name Tina Test Change full name                            |
      | Address 102 Petty France London SW1H 9AJ Change address                   |
      | Email test@hmcts.net Change email                                         |

  Scenario: End to end path two - single
    Given I should be taken to fee page
    When I submit no to have you already paid the fee
    Then I submit the form with I don’t have a form checked
    Then I should be taken to apply on behalf page
    When I select no to are you applying on behalf of someone
    Then I should be taken to national insurance page
    When I am on the national insurance page, select no and submit
    Then I should be taken to the home office page
    When I submit a valid home office number
    Then I should be taken to marital status page
    When I submit the form as single
    Then I should be taken to savings and investments page
    When I submit the form with less than £4,250 checked
    Then I should be taken to dependent page
    When I submit the form with no I do not have any children
    Then I should be taken to kind of income page
    When I submit the form with wages checked
    Then I should be taken to income period page
    When I submit the form with income '0' and monthly
    Then I should be taken to the probate page
    When I select yes to are you paying a fee for a probate case
    And I enter the name of deceased
    And I enter a date of death "10/01/2023"
    Then I should be taken to the claim page
    When I select no to do you have a case, claim or notice to pay number
    Then I should be taken to date of birth page
    When I enter a date of birth "27/09/1950"
    Then I should be taken to personal details page
    When I enter my full name
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
      | Savings and investments Less than £4,250 Change savings and investments                     |
      | Children No Change children                                                             |
      | Total income £0 Last calendar month Change income                                                   |
      | Income type Your income type Change income type                                         |
      | Name of deceased John Smith Change name of deceased                                     |
      | Date of death 10/01/2023 Change date of death                                           |
      | Claim number No Change claim number                                                     |
      | Date of birth 27/09/1950 Change date of birth                                           |
      | Full name Sally Smith Change full name                                               |
      | Address 102 Petty France London SW1H 9AJ Change address                                 |
      | Email test@hmcts.net Change email                                                       |