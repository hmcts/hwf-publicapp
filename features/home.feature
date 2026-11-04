Feature: Home page
  Background: Navigate to home page
    Given I open the home page

  Scenario: I want to learn if I can apply for "Help with fees"
    Then I should see the home page
    
  Scenario: Court or tribunal fee link
    Then I should see the court and tribunal fees link

  Scenario: in Welsh (Cymraeg)
    Then I should see the welsh guide link

  Scenario: Read further guidance link
    Then I should see the further guidance link

  Scenario: form COP44A link
    Then I should see the Court of Protection form link

  Scenario: form EX160 link
    Then I should see the paper form link

  Scenario: Footer content
    Then I should see a list of seven links