Feature: Form name page

    Scenario: Does not display probate applications not available warning message - probate enabled
      Given probate is enabled
      When I am on the form number page
      Then I should not see probate applications not available warning message

    Scenario: Displays probate applications not available warning message - probate disabled
      Given probate is disabled
      When I am on the form number page
      Then I should see probate applications not available warning message

    Scenario: Entering valid form number
      Given probate is enabled
      And I am on the form number page
      When I submit the form with a valid form number
      Then I should be taken to fee page

    Scenario: Leaving form number blank
      Given probate is enabled
      And I am on the form number page
      When I submit the form without a number
      Then I should see enter a number error message

    Scenario: Entering a help with fees form number
      Given probate is enabled
      And I am on the form number page
      When I submit the form with a help with fees form number 'COP44A'
      Then I should see you entered the help with fees form number error message
      And I submit the form with a help with fees form number 'EX160'
      Then I should see you entered the help with fees form number error message

    Scenario: Selecting I don’t have a form
      Given probate is enabled
      And I am on the form number page
      When I submit the form with I don’t have a form checked
      Then I should be taken to fee page

    Scenario: Applying for help with hearing fees
      Given probate is enabled
      And I am on the form number page
      When I click on 'Applying for help with hearing fees'
      Then I should see more information about what to put in the form number field
      Then the page should be axe clean
