@javascript @accessibility
Feature: Accessibility of public app pages

  Background: Navigating to the home page
    Given address lookup is disabled
    When I open the home page
    Then I should see the home page

  Scenario: Accessibility of public app pages
    Then the "Home" page should meet accessibility standards
    When I click the start button
    Then I am on the checklist page
    Then the "Checklist" page should meet accessibility standards
    When I continue
    Then I am on the fee page
    Then the "1 - Fee" page should meet accessibility standards
    And the "1 - Fee" error page should meet accessibility standards
    When I submit no to have you already paid the fee
    Then I should be taken to form number page
    And the "2 - Form number" page should meet accessibility standards
    And the "2 - Form number" error page should meet accessibility standards
    When I submit the form with a help with fees form number 'XX10'
    Then I should be taken to apply on behalf page
    And the "3 - Apply on behalf" page should meet accessibility standards
    And the "3 - Apply on behalf" error page should meet accessibility standards
    When I select no to are you applying on behalf of someone
    Then I should be taken to national insurance page
    And the "7 - National Insurance" page should meet accessibility standards
    And the "7 - National Insurance" error page should meet accessibility standards
    When I submit a valid national insurance number
    Then I should be taken to marital status page
    And the "9 - Relationship status" page should meet accessibility standards
    And the "9 - Relationship status" error page should meet accessibility standards
    When I submit the form as married
    Then I should be taken to partner national insurance page
    And the "10 - Partner National Insurance" page should meet accessibility standards
    And the "10 - Partner National Insurance" error page should meet accessibility standards
    When I select my partner does not have a national insurance number
    Then I should be taken to savings and investments page
    And the "11 - Savings and investments" page should meet accessibility standards
    And the "11 - Savings and investments" error page should meet accessibility standards
    When I submit the form with between £4,250 and £15,999 checked
    Then I should be taken to savings and investment extra page
    And the "12 - Over 66" page should meet accessibility standards
    And the "12 - Over 66" error page should meet accessibility standards
    When I submit no to are you 66 years old or over
    And I enter £5000 as our savings and investments
    And I click continue
    Then I should be taken to benefits page
    And the "13 - Benefits" page should meet accessibility standards
    And the "13 - Benefits" error page should meet accessibility standards
    When I submit the form with no I do not receive one of the benefits listed
    Then I should be taken to dependent page
    And the "14 - Dependent" page should meet accessibility standards
    And the "14 - Dependent" error page should meet accessibility standards
    And I submit the form with four children
    Then I should be taken to kind of income page
    And the "15 - Kind of income" page should meet accessibility standards
    And the "15 - Kind of income" error page should meet accessibility standards
    When I submit the married form with wages and working tax credit checked
    Then I should be taken to income period page
    And the "16 - Income period" page should meet accessibility standards
    And the "16 - Income period" error page should meet accessibility standards
    When I submit the form with income '5000' and monthly
    Then I should be taken to the probate page
    And the "17 - Probate" page should meet accessibility standards
    And the "17 - Probate" error page should meet accessibility standards
    When I select no to are you paying a fee for a probate case
    Then I should be taken to the claim page
    And the "18 - Claim" page should meet accessibility standards
    And the "18 - Claim" error page should meet accessibility standards
    When I select yes to do you have a case, claim or notice to pay number
    And I enter a case, claim or notice to pay number
    Then I should be taken to date of birth page
    And the "19 - Date of birth" page should meet accessibility standards
    And the "19 - Date of birth" error page should meet accessibility standards
    And I enter a valid date of birth for me and my partner
    Then I should be taken to personal details page
    And the "20 - Personal details" page should meet accessibility standards
    And the "20 - Personal details" error page should meet accessibility standards
    When I enter mine and my partner's names
    Then I should be taken to address page
    And the "21 - Address" page should meet accessibility standards
    And the "21 - Address" error page should meet accessibility standards
    When I enter my address with postcode
    Then I should be taken to contact page
    And the "22 - Contact" page should meet accessibility standards
    And I enter an invalid email address
    And the "22 - Contact" error page should meet accessibility standards
    When I enter a valid email address
    Then I should be taken to apply type page
    And the "23 - Apply type" page should meet accessibility standards
    And the "23 - Apply type" error page should meet accessibility standards
    When I select I will be completing via online service
    Then I should be taken to summary page
    And the "24 - Summary" page should meet accessibility standards
    And the "24 - Summary" error page should meet accessibility standards

  Scenario: Accessibility of public app pages with representative
    When I should see the home page
    Then I click the start button
    And I am on the checklist page
    When I continue
    Then I am on the fee page
    And I select yes to have you already paid the fee
    And I submit the form with a date that is within the last three months
    And I submit the form with a help with fees form number 'XX10'
    Then I should be taken to apply on behalf page
    When I select yes to are you applying on behalf of someone
    Then I should be on are you legal representative page
    And the "4 - Legal representative or litigation friend" page should meet accessibility standards
    And the "4 - Legal representative or litigation friend" error page should meet accessibility standards
    When I answer legal representative
    Then I should be on legal representative detail page
    And the "5 - Legal representative details" page should meet accessibility standards
    And the "5 - Legal representative details" error page should meet accessibility standards
    When I fill in all mandatory fields for legal representative
    Then I should be on are you applying for over 16 page
    And the "6 - Are you applying for over 16" page should meet accessibility standards
    And the "6 - Are you applying for over 16" error page should meet accessibility standards
    When I answer yes to over 16
    And I am on the national insurance page, select no and submit
    Then I should be taken to the home office page
    And the "8 - Home office" page should meet accessibility standards
    And the "8 - Home office" error page should meet accessibility standards

  Scenario: Cookies page
    When I open the cookies page
    Then I should be on the cookies page
    Then the "Cookies" page should meet accessibility standards

  Scenario: Privacy policy page
    When I open the privacy policy page
    Then I should be on the privacy policy page
    Then the "Privacy policy" page should meet accessibility standards

  Scenario: Terms and conditions page
    When I open the terms and conditions page
    Then I should be on the terms and conditions page
    Then the "Terms and conditions" page should meet accessibility standards

  Scenario: Accessibility statement page
    When I open the accessibility statement page
    Then I should be on the accessibility statement page
    Then the "Accessibility statement" page should meet accessibility standards

  Scenario: Technical help page
    When I open the technical help page
    Then I should be on the technical help page
    Then the "Technical help" page should meet accessibility standards