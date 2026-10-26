# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/).

## 2026-10-26 (ruby-update)

### Security

- crass 1.0.7 → 1.0.8 — fixes GHSA-pq4g-8rxf-4g29 (CSS sanitizer bypass).

### Changed

- Routine gem and npm bumps, no open advisories; fresh releases applied on explicit approval.

## 2026-10-26 (infra-update)

### Changed

- Updated Ruby 4.0.7 → 4.0.9 (security release; Regexp CVE fixes).
- Jenkins `installRuby` now uses `rvm install --binary --autolibs=read-only`.
  Why: the new ubuntu-preview agents cannot run `apt-get update`, and the
  Travis binary mirror only carries 4.0.9 for Ubuntu 24.04.

## 2026-10-20 (gem-updates-v72)

### Changed

- Routine gem and npm bumps, no open advisories; the fresh (< 7 day old) releases were
  applied on explicit approval. Versions are in the lockfile diff.
- rubocop-capybara 3.1.0 added `Capybara/VisibilityOption`: the one `visible: false` in
  the cucumber steps became the equivalent `visible: :all`.
- govuk-frontend 6.6.0 deprecates the character count `maxwords` option; unused here.
- Yarn 4.18.0 → 4.18.1 via `packageManager`; the Dockerfile's `corepack install` picks it up.

### Known issues

- redis-client 0.31.0 blocked by redis 6.0.0 (`= 0.30.1`); cucumber 12 and the other
  transitive majors still constrained by their parents.

## 2026-10-12 (gem-updates-v71)

### Changed

Second pass, 12 Oct:

- Updated json 2.21.2 → 3.0.2 (major; held last pass, full suite green on it twice)
- Updated date 3.5.1 → 3.6.0, uri 1.1.1 → 1.1.2, prettyprint 0.2.0 → 0.2.1
- Updated mime-types-data 3.2026.0929 → 3.2026.1006
- Updated rubocop 1.91.0 → 1.92.0 and rubocop-rspec_rails 2.32.0 → 2.33.0 (no new offences)
- Updated selenium-webdriver 4.50.0 → 4.51.0
- Updated test-prof 1.6.3 → 1.6.4
- Updated webmock 3.26.4 → 3.29.0
- Updated playwright (npm) and playwright-ruby-client 1.63.0 → 1.64.0, kept in step

All of these were published less than 7 days before the run and applied on explicit approval.

First pass, 6 Oct:

- Updated capybara-playwright-driver 0.5.10 → 0.5.12
- Updated rdoc 8.0.0 → 8.1.0
- Updated regexp_parser 2.13.0 → 2.13.1
- Updated sentry-rails and sentry-ruby 7.0.0 → 7.1.0 (7.1.0 turns Rails structured logging
  off by default; this app never enabled it, so no config change)
- Updated net-smtp 0.5.1 → 0.5.2
- Updated mime-types-data 3.2026.0701 → 3.2026.0929
- Updated brakeman 8.0.6 → 8.1.0 (no new warnings)
- Updated selenium-webdriver 4.49.0 → 4.50.0
- Updated simplecov 1.3.1 → 1.3.2
- Updated listen 3.10.0 → 3.10.1
- Updated parallel 2.2.0 → 2.3.0
- Updated sass 1.105.0 → 1.105.1

Everything from sentry down was published less than 7 days before this run and was
applied on explicit approval rather than held.

### Known issues

- redis-client 0.31.0 not available — redis 6.0.0 pins `redis-client = 0.30.1`.
- cucumber-* / diff-lcs / multi_test / marcel majors still constrained by their parent gems.

## 2026-09-28 (gem-updates-v70)

### Changed

- Updated rails 8.1.3.1 → 8.1.4
- Updated io-console 0.9.3 → 0.9.4
- Updated net-protocol 0.3.0 → 0.4.0
- Updated regexp_parser 2.12.0 → 2.13.0
- Updated rubocop-rails 2.37.0 → 2.38.0 (no new offences)
- Updated rubyzip 3.6.0 → 3.7.0
- Updated simplecov 1.3.0 → 1.3.1
- Updated slim-rails 4.0.0 → 4.0.1
- Updated unicode-display_width 3.2.0 → 3.3.0 and unicode-emoji 4.2.0 → 4.3.0 (transitive)
- Updated sass 1.104.1 → 1.105.0
- Updated webpack 5.111.0 → 5.111.1

### Known issues

- json held at 2.21.2 — Rails 8.1.4 makes `ActiveSupport::JSON.decode` json 3 compatible,
  so 3.0.2 can be retried next run.
- mime-types-data 3.2026.0922 held — published 6 days before this run.
- cucumber-* / diff-lcs / multi_test / marcel majors still constrained by their parent gems.

## 2026-09-17

### Changed

- Updated Ruby 4.0.6 → 4.0.7 (Gemfile, .ruby-version, Dockerfile, Jenkinsfiles and README).
  Routine bugfix release, no security advisories. The Dockerfile pulls from the HMCTS
  ACR mirror; confirm `imported/library/ruby:4.0.7-alpine3.23` has been imported before
  merging.

## 2026-09-16

### Changed

- Updated bigdecimal 4.1.2 → 4.1.3
- Updated govuk-frontend 6.5.0 → 6.5.1
- Updated io-console 0.9.2 → 0.9.3
- Updated jwt 3.2.0 → 3.3.0
- Updated msgpack 1.8.4 → 1.8.5
- Updated net-imap 0.6.6 → 0.6.7
- Updated notifications-ruby-client 6.4.0 → 6.5.1
- Updated parallel_tests 5.7.0 → 5.8.0
- Updated playwright-ruby-client 1.62.0 → 1.63.0
- Updated rubocop 1.90.0 → 1.91.0
- Updated sass 1.104.0 → 1.104.1
- Updated selenium-webdriver 4.48.0 → 4.49.0
- Updated simplecov 1.2.0 → 1.3.0
- Updated webpack 5.110.3 → 5.111.0

### Known issues

- json held at 2.21.2 — 3.0.2 was tried and reverted: ActiveSupport 8.1.3.1 calls
  `JSON.parse(json, options)` with a positional options hash, which json 3.0 rejects
  (`ArgumentError: wrong number of arguments (given 2, expected 1)`), breaking every
  cookie/session decode in the feature specs. Retry once Rails ships json 3 support.
- cucumber-* / diff-lcs / multi_test / marcel major versions still unavailable — pinned by
  cucumber 11.1.1 (latest), rspec-expectations (< 2.0) and activestorage (~> 1.0).

## 2026-09-07

### Changed

- Updated bootsnap 1.25.0 → 1.26.0
- Updated parallel 2.1.0 → 2.2.0
- Updated playwright 1.62.1 → 1.63.0
- Updated rubyzip 3.4.1 → 3.6.0
- Updated sass 1.103.1 → 1.104.0

### Known issues

- json held at 2.21.2 — 3.0.0 is a major release published 2026-09-07, deferred
  until it has settled.
- Updated simplecov 0.22.0 → 1.2.0 — pin lifted; SonarCloud's Ruby analyzer (sonar-ruby
  1.25.0, RUBY-188) now reads the 1.x JSON report format. simplecov_json_formatter and
  docile are gone from the lockfile as simplecov 1.x bundles its own JSON formatter.
- cucumber-* / diff-lcs / multi_test / marcel major versions unavailable — pinned by
  cucumber 11.1.1 (latest), rspec-expectations (< 2.0) and activestorage (~> 1.0);
  they will arrive with their parents' future releases.

## 2026-09-03

### Changed

- Updated govuk-frontend 6.4.0 → 6.5.0
- Updated net-protocol 0.2.2 → 0.3.0
- Updated rbs 4.1.3 → 4.2.0
- Updated rubocop 1.89.0 → 1.90.0 (new Style/DirectiveScope cop disabled in
  .rubocop.yml to keep the existing disable/enable directive pairs)
- Updated sass 1.102.0 → 1.103.1
- Updated selenium-webdriver 4.47.0 → 4.48.0
- Updated sentry-rails 6.7.0 → 7.0.0
- Updated sentry-ruby 6.7.0 → 7.0.0 (major: Sentry logs and metrics are now on by
  default; `send_default_pii` deprecated in favour of `data_collection`)
- Updated webmock 3.26.2 → 3.26.4
- Updated webpack 5.109.2 → 5.110.3
- Updated webpack-cli 7.2.2 → 7.2.3

### Known issues

- rubyzip held at 3.4.1 — 3.6.0 released 2026-09-01, deferred for supply-chain caution.
- simplecov held at ~> 0.22.0 — 1.x emits a JSON report format SonarQube cannot parse.
- cucumber-* / diff-lcs / multi_test / marcel major versions unavailable — pinned by
  cucumber 11.1.1 (latest), rspec-expectations (< 2.0) and activestorage (~> 1.0);
  they will arrive with their parents' future releases.

## 2026-08-18

### Changed

- Updated brakeman 8.0.5 → 8.0.6
- Updated execjs 2.10.1 → 2.10.2
- Updated io-console 0.8.2 → 0.9.2
- Updated rack 3.2.6 → 3.2.7
- Updated rbs 4.1.2 → 4.1.3
- Updated rubocop-performance 1.26.1 → 1.27.0
- Updated rubocop-rails 2.36.0 → 2.37.0
- Updated temple 0.10.6 → 0.10.7
- Updated tilt 2.8.0 → 2.9.0
- Updated Yarn 4.17.1 → 4.18.0 (packageManager)

### Known issues

- simplecov held at ~> 0.22.0 — 1.x emits a JSON report format SonarQube cannot parse.
- cucumber-* / diff-lcs / multi_test major versions unavailable — pinned by
  cucumber 11.1.1 (latest) and rspec-expectations (< 2.0); they will arrive with
  their parents' future releases.

## 2026-08-13

### Changed

- Updated Ruby 4.0.5 → 4.0.6 (Gemfile, .ruby-version, Dockerfile and CI images)
- Updated bootsnap 1.24.6 → 1.25.0
- Updated erb 6.0.6 → 6.0.7
- Updated reline 0.6.3 → 0.7.0
- Updated rubocop 1.88.2 → 1.89.0
- Updated selenium-webdriver 4.46.0 → 4.47.0
- Updated sentry-rails 6.6.2 → 6.7.0
- Updated sentry-ruby 6.6.2 → 6.7.0
- Updated temple 0.10.4 → 0.10.6

### Known issues

- execjs 2.10.2, io-console 0.9.2 and rbs 4.1.3 deferred — released within the last
  2 days (supply-chain caution); pick up on the next security update run.
- simplecov held at ~> 0.22.0 — 1.x emits a JSON report format SonarQube cannot parse.
- cucumber-* / diff-lcs / multi_test major versions unavailable — pinned by
  cucumber 11.1.1 (latest) and rspec-expectations (< 2.0); they will arrive with
  their parents' future releases.
