## Accessibility testing with Axe

The [Service Standard](https://www.gov.uk/service-manual/helping-people-to-use-your-service/testing-for-accessibility) requires all services to meet level AA of the [Web Content Accessibility Guidelines 2.2](https://www.gov.uk/service-manual/helping-people-to-use-your-service/understanding-wcag) (WCAG 2.2) as a minimum. As part of this, code must be regularly tested for accessibility using both manual and automated testing.

For automated accessibility testing we use [Axe](https://www.deque.com/axe/) and the [Axe Core gem](https://github.com/dequelabs/axe-core-gems).

The automated accessibility tests can be run using the rake command:

`$ bundle exec rake test:accessibility`

The tests can be viewed in [accessibility/accessibility.feature](accessibility.feature).

The test configuration and step definitions can be viewed in [features/step_definitions/accessibility_steps.rb](../features/step_definitions/accessibility_steps.rb).