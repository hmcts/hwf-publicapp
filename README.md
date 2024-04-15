# Help with fees - public facing app
[![Code Climate](https://codeclimate.com/github/ministryofjustice/hwf-publicapp/badges/gpa.svg)](https://codeclimate.com/github/ministryofjustice/hwf-publicapp) [![Test Coverage](https://codeclimate.com/github/ministryofjustice/hwf-publicapp/badges/coverage.svg)](https://codeclimate.com/github/ministryofjustice/hwf-publicapp)

[![Build Status](https://dev.azure.com/HMCTS-PET/pet-azure-infrastructure/_apis/build/status/Help%20with%20Fees/hwf-publicapp?branchName=develop)](https://dev.azure.com/HMCTS-PET/pet-azure-infrastructure/_build/latest?definitionId=25&branchName=develop)

Help with fees app for public.

## Dependency
Mimemagic gem has a dependency so you need to install this on your machine first
```brew install shared-mime-info.```

## Redis
HwF Public app is not using standard database. It's using Redis key store. You will need to run a redis-server in order
for the application to work correctly.

More info: https://redis.io/docs/getting-started/installation/install-redis-on-mac-os/

## Docker

Using this command `docker build hmcts/hwf-publicapp:vX.Y`

(Where `X` & `Y` are version numbers) 

## Feature tests

See the [feature testing README](https://github.com/hmcts/hwf-publicapp/blob/master/README.md).

## Frontend toolkit
npm install --save govuk-frontend (https://github.com/alphagov/govuk-frontend/blob/master/docs/installation/installing-with-npm.md)

## Run tests in parallel
Follow the [official guides](https://github.com/grosser/parallel_tests#setup-environment-from-scratch-create-db-and-loads-schema-useful-for-ci) to setup your local env.


Run the specs in parallel
```
RAILS_ENV=test bundle exec rake parallel:spec
```

Run the cucumber features in parallel
```
CAPYBARA_SERVER_PORT=random bundle exec rake parallel:features
```
Deployment versions trigger: 2