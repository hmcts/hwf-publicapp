# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/).

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
