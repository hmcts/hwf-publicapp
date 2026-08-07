# Frontend changelog

Notable frontend dependency updates and the reasoning behind version choices
(especially where something was deliberately *not* bumped). Newest first.

## 2026-08-06
`tar` bumped 7.5.19 → 7.5.22 (via the `resolutions` range) for GHSA-r292-9mhp-454m, an uncatchable stack-overflow DoS patched in 7.5.21 — it has no CVE yet, so `yarn npm audit` did not flag it. All direct deps refreshed to their latest minors: `govuk-frontend` 6.3.0 → 6.4.0 (additive Nunjucks-macro features only; our Slim markup, `initAll` usage and Sass imports are unaffected), `sass` 1.102.0, `webpack` 5.109.2, `webpack-cli` 7.2.2, `playwright` 1.62.1; `jquery` and `rails-ujs` already latest. Transitive deps re-resolved in-range; the exact `resolutions` pins (`fast-uri`, `picomatch`, `undici`) deliberately left as-is (see 2026-07-09). Webpack and Sass builds verified, audit clean.

## 2026-07-09
`picomatch` (4.0.5) and `fast-uri` (3.1.3) bumped to their latest in-range patches, while `undici` (held at 6.27.0, not 8.x) and `fast-uri` (not 4.x) stay back because their latest majors require node-gyp 13 / Node ≥26 (unpinned in CI) and ajv `^3` respectively — audit stays clean.
