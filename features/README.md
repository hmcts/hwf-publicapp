# Automated testing

## Rubocop testing

To assess Ruby code quality across the application we use [Rubocop](https://github.com/bbatsov/rubocop).

To run the tool, use:

`$ rubocop`

## Cucumber feature testing

For integration and UI testing, we use [Cucumber](https://cucumber.io/) and [Capybara](https://github.com/teamcapybara/capybara).

To run the standard Cucumber test suite, use:

`$ bundle exec cucumber features`

To run the all scenarios in a particular feature file:

`$ bundle exec cucumber cucumber features/summary.feature`

To run a particular scenario using line number:

`$ bundle exec cucumber cucumber features/summary.feature:10`

To run in a specific browser:

`$ bundle exec DRIVER=chrome cucumber`

`$ bundle exec DRIVER=firefox cucumber`
Please note: Firefox with macOS 10.15 “Catalina”, please refer to [macOS notarization](https://firefox-source-docs.mozilla.org/testing/geckodriver/Notarization.html)

## Smoke testing

Smoke tests verify core functionalities before deeper, comprehensive testing

To run the smoke tests, use:

`$ bundle exec cucumber --tags @hwf_submit_application`

## Cross-browser and device testing with 🎭 Playwright

By default, only Rack and Selenium Chrome are used for the feature tests.

For cross-browser and device feature testing we use [Playwright](https://github.com/microsoft/playwright) and the [capybara-playwright-driver gem](https://github.com/YusukeIwaki/capybara-playwright-driver).

To begin, install the required browsers:

`$ yarn playwright install`

Then run the test suite using the rack command:

`$ bundle exec rack test:cross_browser_device`

This will run `@javascript` tagged feature tests on Desktop Chrome, Desktop Edge, Desktop Firefox, Desktop WebKit, Mobile Chrome, and Mobile WebKit.

To run one of the drivers individually, e.g. Desktop Webkit run:

`$ DRIVER=playwright_webkit CAPYBARA_JAVASCRIPT_DRIVER=playwright_webkit bundle exec cucumber features/`

## Brakeman

[Brakeman](https://github.com/presidentbeef/brakeman) is a static analysis tool which checks Ruby on Rails applications for security vulnerabilities.
