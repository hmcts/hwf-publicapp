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


### Docker image on local

To be able to pull the image locally you either have to log in via
```az acr login --name hmctsprod --subscription DCD-CNP-PROD```

or you can just remove the path from the image line ie:

```
FROM hmctsprod.azurecr.io/imported/library/ruby:4.0.5-alpine3.23
```
to
```
FROM ruby:4.0.5-alpine3.23
```

## Feature tests

See the [feature testing README](/features/README.md).

## Frontend toolkit
```
yarn install
```
or
```
yarn set version latest
```

## Update existing frontend libraries
```
yarn up "*"
```

## Dependency resolutions (security pins)
The `resolutions` block in `package.json` force-pins some deep transitive
dependencies to patched versions so `yarn npm audit` stays clean:

- `tar` and `undici` — pulled in only via `sass` → `@parcel/watcher` →
  `node-gyp` (build/install-time native-addon tooling, never shipped to the
  browser). Pinned to `tar@^7.5.19` / `undici@^6.27.0` to clear the node-gyp
  advisories while still satisfying its version ranges.
- `fast-uri` and `picomatch` — pinned to compatible patched versions.

Run `yarn npm audit --all --recursive` to check for new advisories. If a pin is
ever bumped, re-run `yarn install`, `yarn build:css` and `yarn build`, then the
feature tests to confirm nothing broke. Drop a pin once the upstream dependency
ships the fix on its own. See [`FRONTEND_CHANGELOG.md`](FRONTEND_CHANGELOG.md)
for the history of frontend dependency decisions.

## CSS + JS updates
We are now using propshaft, cssbundling-rails and jsbundling-rails. You will need to run
```
yarn build:css --watch
yarn build --watch
```
to build your assets you localhost for the first time. Then everytime you are toding any changes to JS or CSS.

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
Deployment versions trigger: 11