# Help with fees - public facing app
[![Build Status](https://img.shields.io/github/checks-status/hmcts/hwf-publicapp/master?label=build)](https://github.com/hmcts/hwf-publicapp/commits/master)
[![Quality Gate Status](https://sonarcloud.io/api/project_badges/measure?project=hwf-publicapp&metric=alert_status)](https://sonarcloud.io/project/overview?id=hwf-publicapp)
[![Coverage](https://sonarcloud.io/api/project_badges/measure?project=hwf-publicapp&metric=coverage)](https://sonarcloud.io/project/overview?id=hwf-publicapp)
[![Maintainability Rating](https://sonarcloud.io/api/project_badges/measure?project=hwf-publicapp&metric=sqale_rating)](https://sonarcloud.io/project/overview?id=hwf-publicapp)
[![Security Rating](https://sonarcloud.io/api/project_badges/measure?project=hwf-publicapp&metric=security_rating)](https://sonarcloud.io/project/overview?id=hwf-publicapp)

[![Ruby](https://img.shields.io/badge/dynamic/regex?url=https%3A%2F%2Fraw.githubusercontent.com%2Fhmcts%2Fhwf-publicapp%2Fmaster%2F.ruby-version&search=%28%3F%3Aruby-%29%3F%28%5Cd%2B%5C.%5Cd%2B%5C.%5Cd%2B%29&replace=%241&label=ruby&color=CC342D&logo=ruby&logoColor=white)](.ruby-version)
[![Rails](https://img.shields.io/badge/dynamic/regex?url=https%3A%2F%2Fraw.githubusercontent.com%2Fhmcts%2Fhwf-publicapp%2Fmaster%2FGemfile.lock&search=%5Cn%20%20%20%20rails%20%5C%28%28%5B%5Cw.-%5D%2B%29%5C%29&replace=%241&label=rails&color=CC0000&logo=rubyonrails&logoColor=white)](Gemfile.lock)
[![Renovate](https://img.shields.io/badge/renovate-enabled-brightgreen?logo=renovatebot)](renovate.json)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

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
FROM hmctsprod.azurecr.io/imported/library/ruby:4.0.7-alpine3.23
```
to
```
FROM ruby:4.0.7-alpine3.23
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