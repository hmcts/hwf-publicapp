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
    Then I should be taken to national insurance page

  Scenario: Path applying on behalf someone else over 16
    When I should be taken to fee page
    When I submit no to have you already paid the fee
    Then I submit the form with a help with fees form number 'XX10'
    Then I should be on the application on behalf of someone else page
    When I answer Yes to on behalf question
    Then I should be on are you legal representative page
    When I click continue
    Then I should see 'Select whether you're a legal representative or litigation friend' error message
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


  Scenario: Path applying on behalf someone else unde 16
    When I should be taken to fee page
    When I submit no to have you already paid the fee
    Then I submit the form with a help with fees form number 'XX10'
    Then I should be on the application on behalf of someone else page
    When I answer Yes to on behalf question
    Then I should be on are you legal representative page
    When I answer legal representative
    Then I should be on legal representative detail page
    When I fill in all mandatory fields for legal representative
    Then I should be on are you applying for over 16 page
    When I answer no to over 16
    Then I should be taken to savings and investments page

  Scenario: End to end post UCD
    When I should be taken to fee page
    When I submit no to have you already paid the fee
    Then I submit the form with a help with fees form number 'XX10'
    Then I should be on the application on behalf of someone else page
    When I answer Yes to on behalf question
    Then I should be on are you legal representative page
    When I answer legal representative
    Then I should be on legal representative detail page
    When I fill in all mandatory fields for legal representative
    Then I should be on are you applying for over 16 page
    When I answer yes to over 16
    Then I should be taken to national insurance page
    When I submit a valid national insurance number (UCD)
    Then I should be taken to marital status page
    When I submit the form as married
    Then I should be taken to partner national insurance page
    When I select my partner does not have a national insurance number
    Then I should be taken to savings and investments page
    When I submit the form with less than £4,250 checked
    Then I should be taken to benefits page
    When I submit the form with no I do not receive one of the benefits listed
    Then I should be taken to dependent page
    When I submit the form with no I do not have any children
    Then I should be taken to kind of income page
    When I submit the married form with wages and working tax credit checked
    Then I should be taken to income period page
    When I submit the form with income '1000' and monthly
    Then I should be taken to the claim page
    When I select no to do you have a case, claim or notice to pay number
    Then I should be taken to date of birth page
    When I enter a valid date of birth for me and my partner
    Then I should be taken to personal details page
    When I enter mine and my partner's names
    Then I should be taken to address page
    When I enter my address with postcode
    Then I should be taken to apply type page
    When I select I will be completing via online service
    Then I should be taken to summary page
    And I should see my details:
      | scope                                                                                               |
      | Form name or number XX10 Change form name or number                                                 |
      | Fee paid No Change fee paid                                                                         |
      | Applying on behalf of someone else Yes Change applying on behalf of someone else                    |
      | Legal representative or litigation friend Legal representative Change legal representative details  |
      | Legal representative details                                                                        |
      | Full name Tom Jones Change legal representative details                                             |
      | Email tom@jones.com Change legal representative details                                             |
      | Position held at firm Change legal representative details                                           |
      | Address London road Bath ABC132 Change legal representative details                                 |
      | Applicant over 16 Yes Change applicant over 16                                                      |
      | National Insurance number JL806367D Change national insurance number                                |
      | Status Married or living with someone and sharing an income Change status                           |
      | Savings and investments Less than £4,250 Change savings and investments                             |
      | Benefits Not receiving eligible benefits Change benefits                                            |
      | Children No Change children                                                                         |
      | Total income £1,000 Last calendar month Change income                                               |
      | Income type Your income type Change income type                                                     |
      | Claim number No Change claim number                                                                 |
      | Date of birth 28/11/1992 Change date of birth                                                       |
      | Partner's date of birth 28/11/1992 Change partner's date of birth                                   |
      | Full name Thomas Test Change full name                                                              |
      | Partner’s full name Tina Test Change full name                                                      |
      | Address 102 Petty France London SW1H 9AJ Change address                                             |
      | Court or tribunal application Online service Change court or tribunal application                   |

