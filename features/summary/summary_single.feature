Feature: Summary page

  Scenario: Displays your details table - probate enabled
    Given I am 'single' and on the summary page with probate enabled
    Then I should see probate in the check details table

  Scenario: Displays your details table - probate disabled
    Given I am 'single' and on the summary page with probate disabled
    Then I should see my details:
      | scope                                                                     |
      | Form name or number C100 Change form name or number                       |
      | Fee paid No Change fee paid                                               |
      | National Insurance number JL806367D Change national insurance number      |
      | Status Single Change status |
      | Less than £4,250 Change savings and investments                           |
      | Benefits Receiving eligible benefits Change benefits                      |
      | Claim number No Change claim number                                       |
      | Date of birth 23/07/1980 Change date of birth                                                 |
      | Full name Sally Smith Change full name                                           |
      | Address 102 Petty France London SW1H 9AJ Change address                   |
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
    And I am 'single' and on the summary page
    Then I should see my details:
      | scope                                                                     |
      | Form name or number C100 Change form name or number                       |
      | Fee paid No Change fee paid                                               |
      | National Insurance number No Change national insurance number             |
      | Home Office reference number 1212-0001-0240-0490/01 Change home office reference number|
      | Status Single Change status |
      | Less than £4,250 Change savings and investments                           |
      | Children No Change children                                               |
      | Total income £0 Last calendar month Change income                                                   |
      | Income type Your income type Change income                                |
      | Claim number No Change claim number                                       |
      | Date of birth 23/07/1980 Change date of birth                             |
      | Full name Sally Smith Change full name                                      |
      | Address 102 Petty France London SW1H 9AJ Change address                   |
      | Email test@hmcts.net Change email                                         |

  Scenario: Displays declaration of truth
    Given I am 'single' and on the summary page with probate enabled
    Then I should see declaration of truth

  @hwf_submit_application @zap
  Scenario: Continue button
    Given I am 'single' and on the summary page with probate enabled
    When I click submit application and continue
    Then I should be taken to confirmation page

  @hwf_submit_application @zap
  Scenario: User details are not persisted
    Given I am 'single' and on the summary page with probate enabled
    When I click submit application and continue
    And I visit the start session path
    Then I expect to have a blank form number

  @hwf_submit_application
  Scenario: User submits for a successful refund
    Given I am 'single' and on the summary page with probate enabled and paid a fee
    When I click submit application and continue
    Then I should be taken to confirmation page about refund

  Scenario: User submits a benefit application and then changes benefit answer.
    Given I am 'single' and on the summary page with probate disabled
    And I change the benefit status
    And I navigate back to the summary page using the browser back button
    Then I should see a changes notification.

  Scenario: User submits with the service down
    Given I am 'single' and on the summary page with probate enabled and paid a fee
    When The submission service is down and I click continue
    Then They are redirected to the summary page with error message.
    