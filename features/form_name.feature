Feature: Form name page

    Background: Navigating to the form name page
      Given probate is enabled
      And I am on the form number page

    Scenario: Does not display probate applications not available warning message - probate enabled
      Then I should not see probate applications not available warning message

    Scenario: Displays probate applications not available warning message - probate disabled
      Given probate is disabled
      And I am on the form number page
      Then I should see probate applications not available warning message

    Scenario: Entering valid form number
      When I submit the form with a valid form number
      Then I should be taken to fee page

    Scenario: Leaving form number blank
      When I submit the form without a number
      Then I should see enter a number error message

    Scenario: Entering a help with fees form number
      When I submit the form with a help with fees form number 'COP44A'
      Then I should see you entered the help with fees form number error message
      And I submit the form with a help with fees form number 'EX160'
      Then I should see you entered the help with fees form number error message

    Scenario: Selecting I don’t have a form
      When I submit the form with I don’t have a form checked
      Then I should be taken to fee page

    Scenario: Applying for help with hearing fees
      When I click on 'Applying for help with hearing fees'
      Then I should see more information about what to put in the form number field

    Scenario: Filling in with valid form number
      When I submit the form with a help with fees form number 'XX10'
      Then I should be taken to fee page

    Scenario: Filling in with help for hearing fees
      When I submit the form with a help with fees form number 'hearing fee for claim'
      Then I should be taken to fee page

    Scenario: Form name page timeout
      When I submit the form with a valid form number after a long time
      Then I should see the home page with error
