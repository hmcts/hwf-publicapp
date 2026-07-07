# Automated testing

## Dependencies

You need to install:

Ruby

[Bundler](http://bundler.io/)

[PhantomJS](https://github.com/teampoltergeist/poltergeist#installing-phantomjs)

To install all of the required gems:

`$ bundle install`

### Rubocop

To assess Ruby code quality across the application we use:

[Rubocop](https://github.com/bbatsov/rubocop)

To run the tool, use:

`$ rubocop`

### Running Cucumber scenarios

For integration and UI testing, we use:

[Cucumber](http://cukes.info/)

[Capybara](https://github.com/jnicklas/capybara)

To run the standard Cucumber test suite, use:

`$ bundle exec cucumber features`

## check your ENV['HOSTNAME'] if you have an issues with "Real HTTP connections are disabled. Unregistered request"
## from webmock

To run the all scenarios in a particular feature file:

`$ bundle exec cucumber cucumber features/summary.feature`

To run a particular scenario using line number:

`$ bundle exec cucumber cucumber features/summary.feature:10`

To run in a browser:

`$ bundle exec DRIVER=chrome cucumber`

`$ bundle exec DRIVER=firefox cucumber`
Please note: Firefox with macOS 10.15 “Catalina”, please refer to [macOS notarization](https://firefox-source-docs.mozilla.org/testing/geckodriver/Notarization.html)

### Running smoke tests

`$ bundle exec cucumber --tags @smoke`

### Running cross browser and device tests

### Creating an HTML report

Creating an HTML report uses the report_builder gem so ensure that you have done a bundle install before continuing.

To create a HTML report detailing the results of a cucumber test:

Run the cucumber tests with the "report" profile:

`$ cucumber -p report` or 

`$ cucumber -p report features/address.feature` (eg for one feature)

This will create a .json file in the ~/features/cucumber-report directory which details the results of the cucumber 
tests. The file will be embedded with screenshots of any failed tests.

To convert the .json into a .html file, execute:

`$ ruby features/support/report_builder.rb`

This will create the .html in the features/cucumber-report directory. Open in browser by right-clicking the file and 
going to 'Open in Browser'. 

Note that the .html and screenshot.png files are included in the .gitignore file.

### Brakeman

[Brakeman](https://github.com/presidentbeef/brakeman) is a static analysis tool which checks Ruby on Rails applications for security vulnerabilities.
