# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/).

## [Unreleased]

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
