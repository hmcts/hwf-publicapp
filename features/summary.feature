Feature: Summary page

  Scenario: Displays your details table - probate enabled
    Given I am on the summary page with probate enabled
    Then I should see probate in the check details table

  Scenario: Displays your details table - probate disabled
    Given I am on the summary page with probate disabled
    Then I should see my details:
    | scope                                                                     |
    | Form name or number C100 Change form name or number                       |
    | Fee paid No Change fee paid                                               |
    | National Insurance number JL806367D Change national insurance number      |
    | Status Married or living with someone and sharing an income Change status |
    | Savings and investments £0 to £2,999 Change savings and investments       |
    | Benefits Receiving eligible benefits Change benefits                      |
    | Claim number No Change claim number                                       |
    | Date of birth 23/07/1980 Change date of birth                             |
    | Full name Ms Sally Smith Change full name                                 |
    | Address 102 Petty France London SW1H 9AJ Change address                  |
    | Email test@hmcts.net Change email                                         |
    And I should be able to go back and change my details:
    | url                    |
    | form_name              |
    | fee                    |
    | national_insurance     |
    | marital_status         |
    | savings_and_investment |
    | benefit                |
    | claim                  |
    | dob                    |
    | personal_detail        |
    | applicant_address      |
    | contact                |
    And I should not see probate in the check details table

  Scenario: Displays home office number
    Given I have a home office number but not a national insurance number
    And I am on the summary page
    Then I should see my details:
    | scope                                                                     |
    | Form name or number C100 Change form name or number                       |
    | Fee paid No Change fee paid                                               |
    | National Insurance number No Change national insurance number             |
    | Home Office reference number 1212-0001-0240-0490/01 Change home office reference number|
    | Status Married or living with someone and sharing an income Change status |
    | Savings and investments £0 to £2,999 Change savings and investments       |
    | Children No Change children                                               |
    | Income £0 Change income                                                   |
    | Claim number No Change claim number                                       |
    | Date of birth 23/07/1980 Change date of birth                             |
    | Full name Ms Sally Smith Change full name                                 |
    | Address 102 Petty France London SW1H 9AJ Change address                  |
    | Email test@hmcts.net Change email                                         |

  Scenario: Displays declaration of truth
    Given I am on the summary page with probate enabled
    Then I should see declaration of truth

  @hwf_submit_application @zap
  Scenario: Continue button
    Given I am on the summary page with probate enabled
    When I click submit application and continue
    Then I should be taken to confirmation page
    Then the page should be axe clean
